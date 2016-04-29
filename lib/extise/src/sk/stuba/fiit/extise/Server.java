package sk.stuba.fiit.extise;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.InetSocketAddress;
import java.util.List;

import com.google.common.base.Joiner;
import com.google.common.net.HostAndPort;
import com.google.common.net.MediaType;
import com.google.common.primitives.UnsignedInteger;

import com.sun.net.httpserver.Headers;
import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;
import com.sun.net.httpserver.HttpServer;
import org.elasticsearch.common.cli.commons.CommandLine;
import org.elasticsearch.common.cli.commons.CommandLineParser;
import org.elasticsearch.common.cli.commons.GnuParser;
import org.elasticsearch.common.cli.commons.Options;
import org.elasticsearch.common.cli.commons.ParseException;
import org.elasticsearch.common.cli.commons.UnrecognizedOptionException;
import sk.stuba.fiit.extise.Bootstrap.Environment;

import static java.lang.Integer.toHexString;
import static java.lang.String.format;
import static java.lang.System.err;
import static java.lang.System.out;

import static com.google.common.base.Strings.padStart;
import static com.google.common.base.Throwables.getStackTraceAsString;

import static org.elasticsearch.common.base.Charsets.UTF_8;

import static sk.stuba.fiit.perconik.utilities.concurrent.PlatformExecutors.newLimitedThreadPool;

@SuppressWarnings("restriction")
final class Server {
  public static final String PROGRAM = Main.PROGRAM + " server";

  public static final String VERSION = "0.0.0";

  static final String DEFAULT_HOST = "localhost";

  static final int DEFAULT_PORT = 7153;

  static final int DEFAULT_POOL = 200;

  private final HttpServer handle;

  private Server(final InetSocketAddress address, final int pool) throws IOException {
    this.handle = HttpServer.create(address, pool);

    this.handle.createContext("/", new Handler());
  }

  public static void run(final String ... args) throws ParseException {
    Options options = new Options();

    options.addOption("address", false, "");
    options.addOption("pool", false, "");
    options.addOption("h", "help", false, "");
    options.addOption("version", false, "");

    try {
      CommandLineParser parser = new GnuParser();
      CommandLine line = parser.parse(options, args);

      if (line.hasOption("help")) {
        out.printf("usage: %s [<options>]%n", PROGRAM);
        out.printf("        --address=<host:port>%n");
        out.printf("        --pool=<size>%n");
        out.printf("    -h, --help%n");
        out.printf("        --version%n%n");
        System.exit(0);
      }

      if (line.hasOption("version")) {
        out.printf("%s %s%n", PROGRAM, VERSION);

        System.exit(0);
      }

      InetSocketAddress address = new InetSocketAddress(DEFAULT_HOST, DEFAULT_PORT);

      if (line.hasOption("address")) {
        HostAndPort a = HostAndPort.fromString(line.getOptionValue("address"));

        address = InetSocketAddress.createUnresolved(a.getHostText(), a.getPortOrDefault(DEFAULT_PORT));
      }

      int pool = DEFAULT_POOL;

      if (line.hasOption("pool")) {
        pool = UnsignedInteger.valueOf(line.getOptionValue("pool")).intValue();
      }

      Server server = null;

      try {
        server = new Server(address, pool);

        server.handle.setExecutor(newLimitedThreadPool());
        server.handle.start();
      } catch (Throwable t) {
        try {
          if (server != null) {
            server.handle.stop(0);
          }
        } catch (Exception e) {
          // ignore
        }

        fail(t);
      }

      log("bound to %s:%d", address.getHostString(), address.getPort());
    } catch (UnrecognizedOptionException e) {
      throw new ParseException("invalid option: " + e.getOption());
    }
  }

  private static final class Handler implements HttpHandler {
    Handler() {}

    public void handle(final HttpExchange exchange) throws IOException {
      String identifier = padStart(toHexString(exchange.hashCode()), 8, '0');

      Headers headers = exchange.getRequestHeaders();
      List<String> arguments = headers.get("Argument");
      String expect = headers.getFirst("Content-length");
      InputStream input = exchange.getRequestBody();

      log(format("%s %s %s%s", identifier, exchange.getRequestMethod(), Joiner.on(" ").join(arguments), expect != null ? format(" < %s bytes", expect) : ""));

      exchange.getResponseHeaders().set("Content-Type", MediaType.PLAIN_TEXT_UTF_8.toString());

      int size;

      try (ByteArrayOutputStream buffer = new ByteArrayOutputStream(8192)) {
        Environment env = Environment.withStreams(input, buffer);
        String[] args = arguments.toArray(new String[arguments.size()]);

        Main.bootstrap(env, args);

        size = buffer.size();

        exchange.sendResponseHeaders(200, size);

        try (OutputStream output = exchange.getResponseBody()) {
          output.write(buffer.toByteArray());
        }
      } catch (Exception e) {
        String message = format("%s: %s%n%n%s", PROGRAM, "unknown failure", getStackTraceAsString(e));
        byte[] bytes = message.getBytes(UTF_8);
        size = bytes.length;

        exchange.sendResponseHeaders(500, size);

        try (OutputStream output = exchange.getResponseBody()) {
          output.write(bytes);
        }
      }

      log(format("%s %s > %s bytes", identifier, exchange.getResponseCode(), size));
    }
  }

  static void log(final String format, final Object ... args) {
    out.printf("%s: %s%n", PROGRAM, format(format, args));
  }

  private static void fail(final Throwable failure) {
    err.printf("%s: %s%n%n%s", PROGRAM, "internal failure", getStackTraceAsString(failure));
    System.exit(1);
  }
}

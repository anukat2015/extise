package sk.stuba.fiit.extise;

import java.util.Collection;
import java.util.List;

import com.google.common.base.Function;
import com.google.common.base.Joiner;

import org.elasticsearch.common.cli.commons.CommandLine;
import org.elasticsearch.common.cli.commons.CommandLineParser;
import org.elasticsearch.common.cli.commons.GnuParser;
import org.elasticsearch.common.cli.commons.Options;
import org.elasticsearch.common.cli.commons.ParseException;
import org.elasticsearch.common.cli.commons.UnrecognizedOptionException;

import static java.lang.System.err;
import static java.lang.System.out;
import static java.util.Arrays.asList;
import static java.util.Arrays.copyOfRange;

import static com.google.common.base.Functions.compose;
import static com.google.common.collect.Lists.newArrayList;

public final class Main {
  public static final String PROGRAM = "extise";

  public static final String VERSION = "0.0.0";

  public static void main(final String ... args) throws Exception {
    bootstrap(options(args));
  }

  @SuppressWarnings({"unchecked", "rawtypes"})
  private static void bootstrap(final String ... args) throws Exception {
    Function function = null;
    int index = 0;

    while (index < args.length) {
      if (args[index].equals("--")) {
        break;
      }

      if (function == null) {
        function = resolve(args[index]);
      } else {
        function = compose(resolve(args[index]), function);
      }

      index ++;
    }

    String[] paths = index < args.length ? copyOfRange(args, index + 1, args.length) : new String[0];

    Bootstrap.run(function, paths);
  }

  private static Function<? super Collection<String>, ? extends Collection<?>> resolve(final String name) throws Exception {
    String[] prefixes = { "sk.stuba.fiit.extise.dom", "sk.stuba.fiit.extise.map", "sk.stuba.fiit.extise.metric" };

    for (String prefix: prefixes) {
      try {
        return Function.class.cast(Class.forName(prefix + "." + name).newInstance());
      } catch (ClassNotFoundException e) {
        continue;
      }
    }

    throw new ClassNotFoundException("{" + Joiner.on(",").join(prefixes) + "}." + name);
  }

  private static String[] options(final String ... args) throws Exception {
    int index = asList(args).indexOf("--");

    Options options = new Options();

    options.addOption("h", "help", false, "");
    options.addOption("version", false, "");

    try {
      CommandLineParser parser = new GnuParser();
      CommandLine line = parser.parse(options, args);

      if (line.hasOption("help")) {
        out.printf("usage: %s [<options>] <function...> [--] [<file...>]%n%n", PROGRAM);
        out.printf("    -h, --help%n");
        out.printf("        --version%n%n");
        System.exit(0);
      }

      if (line.hasOption("version")) {
        out.printf("%s %s%n", PROGRAM, VERSION);
        System.exit(0);
      }

      List<String> result = newArrayList(line.getArgs());

      if (index == 0 || result.size() == 0) {
        throw failure("missing argument: <function>", new RuntimeException());
      }

      if (index + 1 == args.length) {
        throw failure("missing argument: <file>", new RuntimeException());
      }

      if (index > 0) {
        result.add(index, "--");
      }

      return result.toArray(new String[result.size()]);
    } catch (UnrecognizedOptionException e) {
      throw failure("invalid option: " + e.getOption(), e);
    } catch (ParseException e) {
      throw failure("unable to parse options", e);
    }
  }

  private static Exception failure(final String message, final Exception failure) throws Exception {
    err.printf("%s: %s%n", PROGRAM, message);
    System.exit(1);
    return failure;
  }
}

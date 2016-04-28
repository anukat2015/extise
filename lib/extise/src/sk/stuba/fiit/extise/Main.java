package sk.stuba.fiit.extise;

import java.io.IOException;
import java.util.Collection;
import java.util.List;

import com.google.common.base.Function;
import com.google.common.base.Joiner;
import com.google.common.collect.ComputationException;
import com.google.common.reflect.ClassPath;
import com.google.common.reflect.ClassPath.ClassInfo;

import org.elasticsearch.common.cli.commons.CommandLine;
import org.elasticsearch.common.cli.commons.CommandLineParser;
import org.elasticsearch.common.cli.commons.GnuParser;
import org.elasticsearch.common.cli.commons.Options;
import org.elasticsearch.common.cli.commons.ParseException;
import org.elasticsearch.common.cli.commons.UnrecognizedOptionException;
import sk.stuba.fiit.extise.Bootstrap.Environment;

import static java.lang.System.err;
import static java.lang.System.in;
import static java.lang.System.out;
import static java.lang.reflect.Modifier.isAbstract;
import static java.lang.reflect.Modifier.isPublic;
import static java.util.Arrays.asList;
import static java.util.Arrays.copyOfRange;

import static com.google.common.base.Functions.compose;
import static com.google.common.base.Throwables.getStackTraceAsString;
import static com.google.common.collect.Lists.newArrayList;

import static sk.stuba.fiit.extise.Bootstrap.Environment.withStreams;

public final class Main {
  public static final String PROGRAM = "extise";

  public static final String VERSION = "0.0.0";

  private Main() {}

  public static void main(final String ... args) {
    try {
      execute(withStreams(in, out), processOptions(args));
    }
    catch (ComputationException e) {
      reportFailure("unable to compute", e);
    }
    catch (ReflectiveOperationException e) {
      reportFailure("unable to resolve function", e);
    }
    catch (IOException e) {
      reportFailure("unable to read input", e);
    }
    catch (ParseException e) {
      reportFailure(e.getMessage(), e);
    }
  }

  public static void execute(final Environment environment, final String ... args) throws IOException, ReflectiveOperationException {
    runBootstrap(environment, args);
  }

  private static final String[] knownPackages = { "sk.stuba.fiit.extise.difference", "sk.stuba.fiit.extise.dom", "sk.stuba.fiit.extise.map", "sk.stuba.fiit.extise.metric" };

  @SuppressWarnings({"unchecked", "rawtypes"})
  static void runBootstrap(final Environment environment, final String ... args) throws IOException, ReflectiveOperationException {
    Function function = null;
    int index = 0;

    while (index < args.length) {
      if (args[index].equals("--")) {
        break;
      }

      if (function == null) {
        function = resolveFunction(args[index]);
      } else {
        function = compose(resolveFunction(args[index]), function);
      }

      index ++;
    }

    String[] paths = index < args.length ? copyOfRange(args, index + 1, args.length) : new String[0];

    Bootstrap.run(environment, function, paths);
  }

  private static Function<? super Collection<String>, ? extends Collection<?>> resolveFunction(final String name) throws ReflectiveOperationException {
    if (name.contains(".")) {
      return instantiateFunction(Class.forName(name));
    }

    for (String prefix: knownPackages) {
      try {
        return instantiateFunction(Class.forName(prefix + "." + name));
      } catch (ClassNotFoundException e) {
        continue;
      }
    }

    throw new ClassNotFoundException("{" + Joiner.on(",").join(knownPackages) + "}." + name);
  }

  private static Function<? super Collection<String>, ? extends Collection<?>> instantiateFunction(final Class<?> type) throws ReflectiveOperationException {
    return Function.class.cast(type.newInstance());
  }

  static String[] processOptions(final String ... args) throws ClassNotFoundException, ParseException {
    int index = asList(args).indexOf("--");

    Options options = new Options();

    options.addOption("list", false, "");
    options.addOption("server", false, "");
    options.addOption("h", "help", false, "");
    options.addOption("version", false, "");

    try {
      CommandLineParser parser = new GnuParser();
      CommandLine line = parser.parse(options, args);

      if (line.hasOption("help")) {
        out.printf("usage: %s [<options>] <function...> [--] [<file...>]%n%n", PROGRAM);
        out.printf("        --list%n");
        out.printf("    -h, --help%n");
        out.printf("        --version%n%n");

        System.exit(0);
      }

      if (line.hasOption("version")) {
        out.printf("%s %s%n", PROGRAM, VERSION);

        System.exit(0);
      }

      if (line.hasOption("list")) {
        try {
          ClassLoader loader = ClassLoader.getSystemClassLoader();
          ClassPath path = ClassPath.from(loader);

          for (String prefix: knownPackages) {
            out.printf("%s%n", prefix);

            for (ClassInfo info: path.getTopLevelClasses(prefix)) {
              String name = info.getSimpleName();

              if (name.equals("package-info")) {
                continue;
              }

              Class<?> type = Class.forName(info.getName());
              int modifiers = type.getModifiers();

              if (Function.class.isAssignableFrom(type) && !isAbstract(modifiers) && isPublic(modifiers)) {
                out.printf("  %s%n", name);
              }
            }
          }
        } catch (IOException e) {
          throw new ParseException("unable to list functions");
        }

        System.exit(0);
      }

      List<String> result = newArrayList(line.getArgs());

      if (index == 0 || result.size() == 0) {
        throw new ParseException("missing argument: <function>");
      }

      if (index + 1 == args.length) {
        throw new ParseException("missing argument: <file>");
      }

      if (index > 0) {
        result.add(index, "--");
      }

      return result.toArray(new String[result.size()]);
    } catch (UnrecognizedOptionException e) {
      throw new ParseException("invalid option: " + e.getOption());
    } catch (ParseException e) {
      throw new ParseException("unable to parse options");
    }
  }

  private static void reportFailure(final String message, final Exception failure) {
    err.printf("%s: %s%n", PROGRAM, message);

    if (!(failure instanceof ParseException)) {
      err.printf("%n%s", getStackTraceAsString(failure));
    }

    System.exit(1);
  }
}

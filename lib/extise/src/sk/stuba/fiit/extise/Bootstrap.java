package sk.stuba.fiit.extise;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.Reader;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Nullable;

import com.google.common.base.Function;
import com.google.common.base.Splitter;
import com.google.common.collect.ComputationException;
import com.google.common.io.CharStreams;
import com.google.common.io.Files;
import com.google.common.io.Resources;

import static com.google.common.base.Ascii.FS;
import static com.google.common.base.Ascii.US;
import static com.google.common.base.Charsets.UTF_8;
import static com.google.common.base.Preconditions.checkNotNull;
import static com.google.common.base.Throwables.propagate;
import static com.google.common.collect.Iterators.forArray;
import static com.google.common.collect.Lists.newArrayListWithCapacity;
import static com.google.common.collect.Lists.newArrayListWithExpectedSize;
import static com.google.common.io.Resources.getResource;

public final class Bootstrap {
  private Bootstrap() {}

  public static void run(final Environment environment, final Function<? super Collection<String>, ? extends Collection<?>> function, final String ... files) throws IOException {
    List<String> inputs;

    if (files.length != 0) {
      inputs = newArrayListWithCapacity(files.length);

      for (String file: files) {
        inputs.add(file + ((char) US) + Files.toString(new File(file), UTF_8));
      }
    } else {
      Reader reader = new BufferedReader(new InputStreamReader(environment.input, UTF_8));

      inputs = Splitter.on((char) FS).splitToList(CharStreams.toString(reader));
    }

    PrintWriter writer = new PrintWriter(environment.output, true);

    Collection<?> outputs;

    try {
      outputs = function.apply(inputs);
    } catch (Exception failure) {
      throw new ComputationException(failure);
    }

    for (Object output: outputs) {
      writer.println(output);
    }
  }

  public static final class Environment {
    final InputStream input;

    final OutputStream output;

    private Environment(final InputStream input, final OutputStream output) {
      this.input = checkNotNull(input);
      this.output = checkNotNull(output);
    }

    public static Environment withStreams(final InputStream input, final OutputStream output) {
      return new Environment(input, output);
    }
  }

  static abstract class AbstractUnit<T> implements Function<Collection<String>, Collection<T>> {
    AbstractUnit() {}

    abstract Collection<T> apply(final String input, @Nullable final String file);

    abstract Collection<T> apply(final String input);

    @Override
    protected final Object clone() throws CloneNotSupportedException {
      throw new CloneNotSupportedException();
    }

    @Override
    protected final void finalize() {}

    @Override
    public String toString() {
      return this.getClass().getSimpleName();
    }
  }

  public static abstract class Unit<T> extends AbstractUnit<T> {
    private static final Splitter splitter = Splitter.on((char) US).limit(2);

    protected Unit() {}

    protected static Iterator<String> partition(final String input) {
      Iterator<String> parts = Unit.splitter.split(input).iterator();

      String first = parts.next();
      String second = parts.hasNext() ? parts.next() : null;

      return second == null ? forArray(first, null) : forArray(second, first);
    }

    @Override
    public Collection<T> apply(final Collection<String> inputs) {
      List<T> output = newArrayListWithExpectedSize(16 * inputs.size());

      for (String input: inputs) {
        Iterator<String> partitions = partition(input);

        output.addAll(this.apply(partitions.next(), partitions.next()));
      }

      return output;
    }

    @Override
    protected Collection<T> apply(final String input, @Nullable final String file) {
      return this.apply(input);
    }

    @Override
    protected Collection<T> apply(final String input) {
      throw new UnsupportedOperationException();
    }
  }

  public static String load(final String resource) {
    try {
      return Resources.toString(getResource(resource), UTF_8);
    } catch (IOException e) {
      throw propagate(e);
    }
  }
}

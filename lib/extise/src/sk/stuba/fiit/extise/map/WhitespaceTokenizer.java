package sk.stuba.fiit.extise.map;

import java.util.Collection;

import static java.util.Arrays.asList;

import static sk.stuba.fiit.extise.Bootstrap.run;

public final class WhitespaceTokenizer extends StringMapper {
  public static void main(final String ... args) throws Exception {
    run(new WhitespaceTokenizer(), args);
  }

  @Override
  public Collection<String> apply(final String input) {
    return asList(input.split("\\s+"));
  }
}

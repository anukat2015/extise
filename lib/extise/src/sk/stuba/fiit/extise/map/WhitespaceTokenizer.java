package sk.stuba.fiit.extise.map;

import java.util.Collection;

import static java.util.Arrays.asList;

public final class WhitespaceTokenizer extends StringMapper {
  @Override
  public Collection<String> apply(final String input) {
    return asList(input.split("\\s+"));
  }
}

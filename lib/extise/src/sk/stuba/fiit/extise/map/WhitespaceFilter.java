package sk.stuba.fiit.extise.map;

import java.util.Collection;

import static java.util.Arrays.asList;
import static java.util.Collections.EMPTY_LIST;

import static sk.stuba.fiit.extise.Bootstrap.run;

import static sk.stuba.fiit.perconik.utilities.MoreStrings.isWhitespace;

public final class WhitespaceFilter extends StringMapper {
  public static void main(final String ... args) throws Exception {
    run(new WhitespaceFilter(), args);
  }

  @Override
  public Collection<String> apply(final String input) {
    return isWhitespace(input) ? EMPTY_LIST : asList(input);
  }
}

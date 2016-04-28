package sk.stuba.fiit.extise.map;

import java.util.Collection;

import static java.util.Arrays.asList;
import static java.util.Collections.EMPTY_LIST;

import static sk.stuba.fiit.perconik.utilities.net.UniformResources.newUri;

public final class UriFilter extends StringMapper {
  @Override
  public Collection<String> apply(final String input) {
    try {
      newUri(input);

      return EMPTY_LIST;
    } catch (Exception e) {
      return asList(input);
    }
  }
}

package sk.stuba.fiit.extise.map;

import java.util.Collection;

import static java.util.Arrays.asList;
import static java.util.Collections.EMPTY_LIST;

import static sk.stuba.fiit.extise.Bootstrap.run;

import static sk.stuba.fiit.perconik.utilities.net.UniformResources.newUrl;

public final class UrlFilter extends StringMapper {
  public static void main(final String ... args) throws Exception {
    run(new UrlFilter(), args);
  }

  @Override
  public Collection<String> apply(final String input) {
    try {
      newUrl(input);

      return EMPTY_LIST;
    } catch (RuntimeException e) {
      return asList(input);
    }
  }
}

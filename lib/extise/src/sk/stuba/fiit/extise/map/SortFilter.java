package sk.stuba.fiit.extise.map;

import java.util.Collection;
import java.util.List;

import static java.util.Collections.sort;

import static com.google.common.collect.Lists.newArrayList;

import static sk.stuba.fiit.extise.Bootstrap.run;

public final class SortFilter extends StringMapper {
  public static void main(final String ... args) throws Exception {
    run(new SortFilter(), args);
  }

  @Override
  public Collection<String> apply(final Collection<String> inputs) {
    List<String> output = newArrayList(inputs);

    sort(output);

    return output;
  }
}

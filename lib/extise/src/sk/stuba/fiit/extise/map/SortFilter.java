package sk.stuba.fiit.extise.map;

import java.util.Collection;
import java.util.List;

import static java.util.Collections.sort;

import static com.google.common.collect.Lists.newArrayList;

public final class SortFilter extends StringMapper {
  @Override
  public Collection<String> apply(final Collection<String> inputs) {
    List<String> output = newArrayList(inputs);

    sort(output);

    return output;
  }
}

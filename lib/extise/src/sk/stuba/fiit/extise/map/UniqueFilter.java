package sk.stuba.fiit.extise.map;

import java.util.Collection;

import static com.google.common.collect.Sets.newLinkedHashSet;

public final class UniqueFilter extends StringMapper {
  @Override
  public Collection<String> apply(final Collection<String> inputs) {
    return newLinkedHashSet(inputs);
  }
}

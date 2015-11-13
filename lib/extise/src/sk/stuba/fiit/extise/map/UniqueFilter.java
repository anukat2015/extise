package sk.stuba.fiit.extise.map;

import java.util.Collection;

import static com.google.common.collect.Sets.newLinkedHashSet;

import static sk.stuba.fiit.extise.Bootstrap.run;

public final class UniqueFilter extends StringMapper {
  public static void main(final String ... args) throws Exception {
    run(new UniqueFilter(), args);
  }

  @Override
  public Collection<String> apply(final Collection<String> inputs) {
    return newLinkedHashSet(inputs);
  }
}

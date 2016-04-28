package sk.stuba.fiit.extise.metric;

import java.util.Collection;

import static java.util.Arrays.asList;

import static sk.stuba.fiit.perconik.utilities.MoreStrings.lines;

public final class LinesOfCode extends NumericMetric<Integer> {
  @Override
  public Collection<Integer> apply(final String input) {
    return asList(lines(input).size());
  }
}

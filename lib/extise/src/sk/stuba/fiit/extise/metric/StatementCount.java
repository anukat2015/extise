package sk.stuba.fiit.extise.metric;

import java.util.Collection;

import org.eclipse.jdt.core.dom.CompilationUnit;
import org.eclipse.jdt.core.dom.Statement;

import sk.stuba.fiit.perconik.core.java.dom.NodeCounters;

import static java.util.Arrays.asList;

import static sk.stuba.fiit.extise.Bootstrap.run;
import static sk.stuba.fiit.extise.Java.parse;

public final class StatementCount extends NumericMetric<Integer> {
  public static void main(final String ... args) throws Exception {
    run(new StatementCount(), args);
  }

  @Override
  public Collection<Integer> apply(final String input) {
    CompilationUnit unit = (CompilationUnit) parse(input);

    return asList(NodeCounters.ofClass(Statement.class).apply(unit));
  }
}

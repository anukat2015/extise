package sk.stuba.fiit.extise.metric;

import java.util.Collection;

import org.eclipse.jdt.core.dom.AbstractTypeDeclaration;
import org.eclipse.jdt.core.dom.CompilationUnit;

import sk.stuba.fiit.perconik.core.java.dom.NodeCounters;

import static java.util.Arrays.asList;

import static sk.stuba.fiit.extise.Bootstrap.run;
import static sk.stuba.fiit.extise.Java.parse;

public final class TypeCount extends NumericMetric<Integer> {
  public static void main(final String ... args) throws Exception {
    run(new TypeCount(), args);
  }

  @Override
  public Collection<Integer> apply(final String input) {
    CompilationUnit unit = (CompilationUnit) parse(input);

    return asList(NodeCounters.ofClass(AbstractTypeDeclaration.class).apply(unit));
  }
}

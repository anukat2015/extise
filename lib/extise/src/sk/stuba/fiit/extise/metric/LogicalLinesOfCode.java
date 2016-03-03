package sk.stuba.fiit.extise.metric;

import java.util.Collection;

import org.eclipse.jdt.core.dom.ASTNode;
import org.eclipse.jdt.core.dom.CompilationUnit;
import org.eclipse.jdt.core.dom.Statement;

import sk.stuba.fiit.perconik.core.java.dom.NodeCounters;
import sk.stuba.fiit.perconik.core.java.dom.TreeParsers;

import static java.util.Arrays.asList;

import static sk.stuba.fiit.extise.Bootstrap.run;

public final class LogicalLinesOfCode extends NumericMetric<Integer> {
  public static void main(final String ... args) throws Exception {
    run(new LogicalLinesOfCode(), args);
  }

  @Override
  public Collection<Integer> apply(final String input) {
    CompilationUnit unit = (CompilationUnit) TreeParsers.parse(input);

    // TODO there can be more statements on a single logical line of code

    return asList(NodeCounters.<ASTNode>ofClass(Statement.class).apply(unit));
  }
}

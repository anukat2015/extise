package sk.stuba.fiit.extise.metric;

import java.util.Collection;
import java.util.List;
import java.util.Set;

import org.eclipse.jdt.core.dom.CompilationUnit;
import org.eclipse.jdt.core.dom.Statement;

import sk.stuba.fiit.extise.dom.NodeRegion;

import sk.stuba.fiit.perconik.core.java.dom.NodeCollectors;

import static java.util.Arrays.asList;

import static com.google.common.collect.Sets.newLinkedHashSetWithExpectedSize;

import static sk.stuba.fiit.extise.Java.parse;

public final class LogicalLinesOfCode extends NumericMetric<Integer> {
  @Override
  public Collection<Integer> apply(final String input) {
    CompilationUnit unit = (CompilationUnit) parse(input);

    List<Statement> statements = NodeCollectors.ofClass(Statement.class).apply(unit);
    Set<Integer> lines = newLinkedHashSetWithExpectedSize(statements.size());

    for (Statement statement: statements) {
      NodeRegion region = NodeRegion.of(unit, statement);

      for (int line: region.getLines(input, unit)) {
        lines.add(line);
      }
    }

    return asList(lines.size());
  }
}

package sk.stuba.fiit.extise.metric;

import java.util.Collection;

import org.eclipse.jdt.core.dom.CompilationUnit;

import static java.util.Arrays.asList;

import static sk.stuba.fiit.extise.Java.parse;

public final class CommentCount extends NumericMetric<Integer> {
  @Override
  public Collection<Integer> apply(final String input) {
    CompilationUnit unit = (CompilationUnit) parse(input);

    return asList(unit.getCommentList().size());
  }
}

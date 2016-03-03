package sk.stuba.fiit.extise.metric;

import java.util.Collection;

import org.eclipse.jdt.core.dom.ASTNode;
import org.eclipse.jdt.core.dom.Comment;
import org.eclipse.jdt.core.dom.CompilationUnit;

import sk.stuba.fiit.perconik.core.java.dom.NodeCounters;
import sk.stuba.fiit.perconik.core.java.dom.TreeParsers;

import static java.util.Arrays.asList;

import static sk.stuba.fiit.extise.Bootstrap.run;

public final class CommentLinesOfCode extends NumericMetric<Integer> {
  public static void main(final String ... args) throws Exception {
    run(new CommentLinesOfCode(), args);
  }

  @Override
  public Collection<Integer> apply(final String input) {
    CompilationUnit unit = (CompilationUnit) TreeParsers.parse(input);

    // TODO JDT somehow does not parse line & block comments
    // TODO number of comment nodes does not correspond with comment lines of code

    return asList(NodeCounters.<ASTNode>ofClass(Comment.class).apply(unit));
  }
}

package sk.stuba.fiit.extise.metric;

import java.util.Collection;
import java.util.List;
import java.util.Set;

import org.eclipse.jdt.core.dom.Comment;
import org.eclipse.jdt.core.dom.CompilationUnit;

import sk.stuba.fiit.extise.dom.NodeRegion;

import static java.util.Arrays.asList;

import static com.google.common.collect.Sets.newLinkedHashSetWithExpectedSize;

import static sk.stuba.fiit.extise.Bootstrap.run;
import static sk.stuba.fiit.extise.Java.parse;

public final class CommentLinesOfCode extends NumericMetric<Integer> {
  public static void main(final String ... args) throws Exception {
    run(new CommentLinesOfCode(), args);
  }

  @Override
  public Collection<Integer> apply(final String input) {
    CompilationUnit unit = (CompilationUnit) parse(input);

    List<Comment> comments = unit.getCommentList();
    Set<Integer> lines = newLinkedHashSetWithExpectedSize(comments.size());

    for (Comment comment: comments) {
      NodeRegion region = NodeRegion.of(unit, comment);

      for (int line: region.getLines(input, unit)) {
        lines.add(line);
      }
    }

    return asList(lines.size());
  }
}

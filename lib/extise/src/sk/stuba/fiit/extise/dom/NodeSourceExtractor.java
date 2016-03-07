package sk.stuba.fiit.extise.dom;

import org.eclipse.jdt.core.dom.ASTNode;
import org.eclipse.jdt.core.dom.CompilationUnit;

import sk.stuba.fiit.perconik.utilities.function.ListCollector;

import static java.lang.System.lineSeparator;

import static sk.stuba.fiit.perconik.core.java.dom.NodePaths.namePathExtractor;
import static sk.stuba.fiit.perconik.core.java.dom.NodeRangeType.STANDARD;

abstract class NodeSourceExtractor extends NodeExtractor {
  NodeSourceExtractor(final ListCollector<ASTNode, ASTNode> collector) {
    super(collector);
  }

  @Override
  final String extract(final String input, final CompilationUnit unit, final ASTNode node) {
    int offset = STANDARD.getOffset(unit, node);
    int length = STANDARD.getLength(unit, node);

    int line = unit.getLineNumber(offset);

    String path = namePathExtractor().apply(node).toString();
    String source = input.substring(offset, offset + length);

    return block(path, line, offset, length).append(lineSeparator()).append(source).toString();
  }
}

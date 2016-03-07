package sk.stuba.fiit.extise.dom;

import org.eclipse.jdt.core.dom.ASTNode;
import org.eclipse.jdt.core.dom.CompilationUnit;

import sk.stuba.fiit.perconik.utilities.function.ListCollector;

import static sk.stuba.fiit.perconik.core.java.dom.NodePaths.namePathExtractor;
import static sk.stuba.fiit.perconik.core.java.dom.NodeRangeType.STANDARD;

abstract class NodePositionExtractor extends NodeExtractor {
  NodePositionExtractor(final ListCollector<ASTNode, ASTNode> collector) {
    super(collector);
  }

  @Override
  final String extract(final String input, final CompilationUnit unit, final ASTNode node) {
    int offset = STANDARD.getOffset(unit, node);
    int length = STANDARD.getLength(unit, node);

    int line = unit.getLineNumber(offset);

    String path = namePathExtractor().apply(node).toString();

    return block(path, line, offset, length).toString();
  }
}

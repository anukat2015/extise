package sk.stuba.fiit.extise.dom;

import javax.annotation.Nullable;

import org.eclipse.jdt.core.dom.ASTNode;
import org.eclipse.jdt.core.dom.CompilationUnit;

import sk.stuba.fiit.perconik.utilities.function.ListCollector;

import static java.lang.System.lineSeparator;

import static sk.stuba.fiit.perconik.core.java.dom.NodePaths.namePathExtractor;

abstract class NodeSourceExtractor extends NodeExtractor {
  NodeSourceExtractor(final ListCollector<ASTNode, ASTNode> collector) {
    super(collector);
  }

  @Override
  final String extract(@Nullable final String file, final String input, final CompilationUnit unit, final ASTNode node) {
    String path = namePathExtractor().apply(node).toString();

    NodeRegion region = NodeRegion.of(unit, node);

    String source = region.getSource(input);

    return block(file, path, region.getLine(unit), region.offset, region.length).append(lineSeparator()).append(source).toString();
  }
}

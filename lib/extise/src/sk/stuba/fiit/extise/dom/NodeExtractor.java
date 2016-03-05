package sk.stuba.fiit.extise.dom;

import java.util.Collection;
import java.util.List;

import org.eclipse.jdt.core.dom.ASTNode;
import org.eclipse.jdt.core.dom.CompilationUnit;

import sk.stuba.fiit.extise.Bootstrap;

import sk.stuba.fiit.perconik.core.java.dom.TreeParsers;
import sk.stuba.fiit.perconik.utilities.function.ListCollector;

import static java.lang.System.lineSeparator;

import static com.google.common.base.Preconditions.checkNotNull;
import static com.google.common.collect.Lists.newArrayListWithCapacity;

import static sk.stuba.fiit.perconik.core.java.dom.NodePaths.namePathExtractor;
import static sk.stuba.fiit.perconik.core.java.dom.NodeRangeType.STANDARD;

abstract class NodeExtractor extends Bootstrap.Unit<String> {
  private final ListCollector<ASTNode, ASTNode> collector;

  NodeExtractor(final ListCollector<ASTNode, ASTNode> collector) {
    this.collector = checkNotNull(collector);
  }

  @Override
  protected Collection<String> apply(final String input) {
    CompilationUnit unit = (CompilationUnit) TreeParsers.parse(input);

    List<ASTNode> nodes = this.collector.apply(unit);
    List<String> blocks = newArrayListWithCapacity(nodes.size());

    for (ASTNode node: nodes) {
      int offset = STANDARD.getOffset(unit, node);
      int length = STANDARD.getLength(unit, node);

      String path = namePathExtractor().apply(node).toString();
      String source = input.substring(offset, offset + length);

      StringBuilder block = new StringBuilder(128 + path.length() + source.length());

      block.append("#").append(path);
      block.append(":").append(offset).append("+").append(length).append(lineSeparator());
      block.append(source).append(lineSeparator());

      blocks.add(block.toString());
    }

    return blocks;
  }
}

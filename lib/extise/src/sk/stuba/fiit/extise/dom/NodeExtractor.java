package sk.stuba.fiit.extise.dom;

import java.util.Collection;
import java.util.List;

import org.eclipse.jdt.core.dom.ASTNode;
import org.eclipse.jdt.core.dom.CompilationUnit;

import sk.stuba.fiit.extise.Bootstrap;

import sk.stuba.fiit.perconik.utilities.function.ListCollector;

import static com.google.common.base.Preconditions.checkNotNull;
import static com.google.common.collect.Lists.newArrayListWithCapacity;

import static sk.stuba.fiit.extise.Java.parse;

abstract class NodeExtractor extends Bootstrap.Unit<String> {
  private final ListCollector<ASTNode, ASTNode> collector;

  NodeExtractor(final ListCollector<ASTNode, ASTNode> collector) {
    this.collector = checkNotNull(collector);
  }

  static StringBuilder block(final String path, final int line, final int offset, final int length) {
    StringBuilder block = new StringBuilder(128 + path.length());

    block.append("# ").append(path).append(":").append(line).append(" ");
    block.append(offset).append("+").append(length);

    return block;
  }

  @Override
  public final Collection<String> apply(final String input) {
    CompilationUnit unit = (CompilationUnit) parse(input);

    List<ASTNode> nodes = this.collector.apply(unit);
    List<String> blocks = newArrayListWithCapacity(nodes.size());

    for (ASTNode node: nodes) {
      blocks.add(this.extract(input, unit, node));
    }

    return blocks;
  }

  abstract String extract(String input, CompilationUnit unit, ASTNode node);
}

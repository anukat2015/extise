package sk.stuba.fiit.extise.dom;

import java.util.Collection;
import java.util.List;

import javax.annotation.Nullable;

import com.google.common.base.Splitter;

import org.eclipse.jdt.core.dom.ASTNode;
import org.eclipse.jdt.core.dom.CompilationUnit;

import sk.stuba.fiit.extise.Bootstrap;

import sk.stuba.fiit.perconik.utilities.function.ListCollector;

import static com.google.common.base.Preconditions.checkNotNull;
import static com.google.common.collect.Lists.newArrayListWithCapacity;

import static sk.stuba.fiit.extise.Java.parse;

import static sk.stuba.fiit.perconik.utilities.MoreStrings.lineSeparatorRegex;

abstract class NodeExtractor extends Bootstrap.Unit<String> {
  private final ListCollector<ASTNode, ASTNode> collector;

  NodeExtractor(final ListCollector<ASTNode, ASTNode> collector) {
    this.collector = checkNotNull(collector);
  }

  static StringBuilder block(@Nullable final String file, final String path, final int line, final int offset, final int length) {
    StringBuilder block = new StringBuilder(128 + path.length());

    block.append("# ").append(file != null ? file : "?").append(":").append(path).append(":");
    block.append(line).append(" ").append(offset).append("+").append(length);

    return block;
  }

  @Override
  public final Collection<String> apply(final String input) {
    String file = null, source = input;

    if (input.startsWith("#")) {
      List<String> parts = Splitter.onPattern(lineSeparatorRegex()).limit(2).splitToList(input);

      file = parts.get(0);
      file = file.substring(1, file.length()).trim();
      source = parts.size() == 2 ? parts.get(1) : "";
    }

    CompilationUnit unit = (CompilationUnit) parse(source);

    List<ASTNode> nodes = this.collector.apply(unit);
    List<String> blocks = newArrayListWithCapacity(nodes.size());

    for (ASTNode node: nodes) {
      blocks.add(this.extract(file, source, unit, node));
    }

    return blocks;
  }

  abstract String extract(@Nullable String path, String input, CompilationUnit unit, ASTNode node);
}

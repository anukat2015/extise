package sk.stuba.fiit.extise.map;

import java.util.Collection;

import org.eclipse.jdt.core.dom.ASTNode;
import org.eclipse.jdt.core.dom.CompilationUnit;

import sk.stuba.fiit.perconik.core.java.dom.NodeTokenizer;

import static com.google.common.base.Preconditions.checkNotNull;

import static sk.stuba.fiit.extise.Bootstrap.parse;

class JavaTokenizer extends StringMapper {
  private final NodeTokenizer<ASTNode> tokenizer;

  JavaTokenizer(final NodeTokenizer<ASTNode> tokenizer) {
    this.tokenizer = checkNotNull(tokenizer);
  }

  @Override
  public final Collection<String> apply(final String input) {
    CompilationUnit unit = (CompilationUnit) parse(input);

    return this.tokenizer.apply(unit);
  }
}

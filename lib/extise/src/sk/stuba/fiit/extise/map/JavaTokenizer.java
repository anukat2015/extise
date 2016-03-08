package sk.stuba.fiit.extise.map;

import java.util.Collection;
import java.util.List;

import org.eclipse.jdt.core.dom.ASTNode;
import org.eclipse.jdt.core.dom.Comment;
import org.eclipse.jdt.core.dom.CompilationUnit;

import sk.stuba.fiit.extise.dom.NodeToSourceTransformer;

import sk.stuba.fiit.perconik.core.java.dom.NodeCollectors;
import sk.stuba.fiit.perconik.core.java.dom.NodeTokenizer;
import sk.stuba.fiit.perconik.eclipse.jdt.core.dom.NodeType;

import static com.google.common.base.Preconditions.checkNotNull;
import static com.google.common.collect.Lists.newArrayListWithExpectedSize;

import static sk.stuba.fiit.extise.Java.parse;

class JavaTokenizer extends StringMapper {
  private final NodeTokenizerFactory<ASTNode> factory;

  JavaTokenizer(final NodeTokenizerFactory<ASTNode> factory) {
    this.factory = checkNotNull(factory);
  }

  interface NodeTokenizerFactory<N extends ASTNode> {
    public NodeTokenizer<N> build(String source, CompilationUnit unit);
  }

  static final NodeTokenizerFactory<ASTNode> nodeTokenizerFactory(final NodeType type, final NodeType ... rest) {
    return new NodeTokenizerFactory<ASTNode>() {
      public NodeTokenizer<ASTNode> build(final String source, final CompilationUnit unit) {
        NodeTokenizer.Builder<ASTNode> builder = NodeTokenizer.builder();

        builder.collector(NodeCollectors.ofType(type, rest));
        builder.transformer(NodeToSourceTransformer.on(source, unit));

        return builder.build();
      }
    };
  }

  @Override
  public final Collection<String> apply(final String input) {
    CompilationUnit unit = (CompilationUnit) parse(input);

    NodeTokenizer<ASTNode> tokenizer = this.factory.build(input, unit);
    List<String> tokens = newArrayListWithExpectedSize(4096);

    // block and line comments need to be processes separately

    for (Comment comment: (List<Comment>) unit.getCommentList()) {
      if (comment.isBlockComment() || comment.isLineComment()) {
        tokens.addAll(tokenizer.apply(comment));
      }
    }

    // documentation comments and other nodes are processed by default

    tokens.addAll(tokenizer.apply(unit));

    return tokens;
  }
}

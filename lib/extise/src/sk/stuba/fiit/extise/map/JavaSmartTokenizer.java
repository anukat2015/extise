package sk.stuba.fiit.extise.map;

import com.google.common.base.Function;

import org.eclipse.jdt.core.dom.ASTNode;
import org.eclipse.jdt.core.dom.CompilationUnit;
import org.eclipse.jdt.core.dom.StringLiteral;

import sk.stuba.fiit.extise.dom.NodeRegion;

import sk.stuba.fiit.perconik.core.java.dom.NodeCollectors;
import sk.stuba.fiit.perconik.core.java.dom.NodeTokenizer;
import sk.stuba.fiit.perconik.utilities.function.ListCollector;

import static sk.stuba.fiit.perconik.eclipse.jdt.core.dom.NodeType.BLOCK_COMMENT;
import static sk.stuba.fiit.perconik.eclipse.jdt.core.dom.NodeType.JAVADOC;
import static sk.stuba.fiit.perconik.eclipse.jdt.core.dom.NodeType.LINE_COMMENT;
import static sk.stuba.fiit.perconik.eclipse.jdt.core.dom.NodeType.QUALIFIED_NAME;
import static sk.stuba.fiit.perconik.eclipse.jdt.core.dom.NodeType.SIMPLE_NAME;
import static sk.stuba.fiit.perconik.eclipse.jdt.core.dom.NodeType.STRING_LITERAL;

public final class JavaSmartTokenizer extends JavaTokenizer {
  public JavaSmartTokenizer() {
    super(nodeTokenizerFactory());
  }

  static NodeTokenizerFactory<ASTNode> nodeTokenizerFactory() {
    return new NodeTokenizerFactory<ASTNode>() {
      public NodeTokenizer<ASTNode> build(final String source, final CompilationUnit unit) {
        ListCollector<ASTNode, ASTNode> collector = NodeCollectors.ofType(BLOCK_COMMENT, LINE_COMMENT, JAVADOC, QUALIFIED_NAME, SIMPLE_NAME, STRING_LITERAL);

        Function<ASTNode, String> transformer = new Function<ASTNode, String>() {
          public String apply(final ASTNode input) {
            if (input instanceof StringLiteral) {
              return ((StringLiteral) input).getLiteralValue();
            }

            return NodeRegion.of(unit, input).getSource(source);
          }

          @Override
          public String toString() {
            return "SmartTansformer";
          }
        };

        return NodeTokenizer.builder().collector(collector).transformer(transformer).build();
      }
    };
  }
}

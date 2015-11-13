package sk.stuba.fiit.extise.map;

import com.google.common.base.Function;

import org.eclipse.jdt.core.dom.ASTNode;
import org.eclipse.jdt.core.dom.StringLiteral;

import sk.stuba.fiit.perconik.core.java.dom.NodeCollectors;
import sk.stuba.fiit.perconik.core.java.dom.NodeTokenizer;
import sk.stuba.fiit.perconik.utilities.function.ListCollector;

import static sk.stuba.fiit.extise.Bootstrap.run;

import static sk.stuba.fiit.perconik.eclipse.jdt.core.dom.NodeType.JAVADOC;
import static sk.stuba.fiit.perconik.eclipse.jdt.core.dom.NodeType.QUALIFIED_NAME;
import static sk.stuba.fiit.perconik.eclipse.jdt.core.dom.NodeType.SIMPLE_NAME;
import static sk.stuba.fiit.perconik.eclipse.jdt.core.dom.NodeType.STRING_LITERAL;

public final class JavaSmartTokenizer extends JavaTokenizer {
  public JavaSmartTokenizer() {
    super(smart());
  }

  static NodeTokenizer<ASTNode> smart() {
    ListCollector<ASTNode, ASTNode> collector = NodeCollectors.ofType(JAVADOC, QUALIFIED_NAME, SIMPLE_NAME, STRING_LITERAL);

    Function<ASTNode, String> transformer = new Function<ASTNode, String>() {
      public String apply(final ASTNode input) {
        return input instanceof StringLiteral ? ((StringLiteral) input).getLiteralValue() : input.toString();
      }

      @Override
      public String toString() {
        return "SmartTansformer";
      }
    };

    return NodeTokenizer.builder().collector(collector).transformer(transformer).build();
  }

  public static void main(final String ... args) throws Exception {
    run(new JavaSmartTokenizer(), args);
  }
}

package sk.stuba.fiit.extise.map;

import static sk.stuba.fiit.perconik.eclipse.jdt.core.dom.NodeType.QUALIFIED_NAME;

public final class JavaQualifiedNameTokenizer extends JavaTokenizer {
  public JavaQualifiedNameTokenizer() {
    super(nodeTokenizerFactory(QUALIFIED_NAME));
  }
}

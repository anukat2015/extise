package sk.stuba.fiit.extise.map;

import static sk.stuba.fiit.perconik.eclipse.jdt.core.dom.NodeType.JAVADOC;

public final class JavadocTokenizer extends JavaTokenizer {
  public JavadocTokenizer() {
    super(nodeTokenizerFactory(JAVADOC));
  }
}

package sk.stuba.fiit.extise.map;

import static sk.stuba.fiit.perconik.eclipse.jdt.core.dom.NodeType.SIMPLE_NAME;

public final class JavaSimpleNameTokenizer extends JavaTokenizer {
  public JavaSimpleNameTokenizer() {
    super(nodeTokenizerFactory(SIMPLE_NAME));
  }
}

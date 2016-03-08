package sk.stuba.fiit.extise.map;

import static sk.stuba.fiit.extise.Bootstrap.run;

import static sk.stuba.fiit.perconik.eclipse.jdt.core.dom.NodeType.QUALIFIED_NAME;

public final class JavaQualifiedNameTokenizer extends JavaTokenizer {
  public JavaQualifiedNameTokenizer() {
    super(nodeTokenizerFactory(QUALIFIED_NAME));
  }

  public static void main(final String ... args) throws Exception {
    run(new JavaQualifiedNameTokenizer(), args);
  }
}

package sk.stuba.fiit.extise.map;

import static sk.stuba.fiit.extise.Bootstrap.run;

import static sk.stuba.fiit.perconik.eclipse.jdt.core.dom.NodeType.JAVADOC;

public final class JavadocTokenizer extends JavaTokenizer {
  public JavadocTokenizer() {
    super(nodeTokenizerFactory(JAVADOC));
  }

  public static void main(final String ... args) throws Exception {
    run(new JavadocTokenizer(), args);
  }
}

package sk.stuba.fiit.extise.map;

import sk.stuba.fiit.perconik.core.java.dom.NodeCollectors;
import sk.stuba.fiit.perconik.core.java.dom.NodeTokenizer;
import sk.stuba.fiit.perconik.eclipse.jdt.core.dom.NodeType;

import static sk.stuba.fiit.extise.Bootstrap.run;

public final class JavadocTokenizer extends JavaTokenizer {
  public JavadocTokenizer() {
    super(NodeTokenizer.using(NodeCollectors.ofType(NodeType.JAVADOC)));
  }

  public static void main(final String ... args) throws Exception {
    run(new JavadocTokenizer(), args);
  }
}

package sk.stuba.fiit.extise.map;

import sk.stuba.fiit.perconik.core.java.dom.NodeTokenizers;

import static sk.stuba.fiit.extise.Bootstrap.run;

public final class JavaQualifiedNameTokenizer extends JavaTokenizer {
  public JavaQualifiedNameTokenizer() {
    super(NodeTokenizers.simpleNames());
  }

  public static void main(final String ... args) throws Exception {
    run(new JavaQualifiedNameTokenizer(), args);
  }
}

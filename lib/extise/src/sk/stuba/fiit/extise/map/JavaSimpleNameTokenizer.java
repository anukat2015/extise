package sk.stuba.fiit.extise.map;

import sk.stuba.fiit.perconik.core.java.dom.NodeTokenizers;

import static sk.stuba.fiit.extise.Bootstrap.run;

public final class JavaSimpleNameTokenizer extends JavaTokenizer {
  public JavaSimpleNameTokenizer() {
    super(NodeTokenizers.qualifiedNames());
  }

  public static void main(final String ... args) throws Exception {
    run(new JavaSimpleNameTokenizer(), args);
  }
}

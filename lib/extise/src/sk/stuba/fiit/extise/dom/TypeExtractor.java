package sk.stuba.fiit.extise.dom;

import sk.stuba.fiit.perconik.core.java.dom.NodeCollectors;

import static sk.stuba.fiit.extise.Bootstrap.run;

import static sk.stuba.fiit.perconik.eclipse.jdt.core.dom.NodeType.TYPE_DECLARATION;

public final class TypeExtractor extends NodeExtractor {
  public TypeExtractor() {
    super(NodeCollectors.ofType(TYPE_DECLARATION));
  }

  public static void main(final String ... args) throws Exception {
    run(new TypeExtractor(), args);
  }
}

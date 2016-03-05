package sk.stuba.fiit.extise.dom;

import sk.stuba.fiit.perconik.core.java.dom.NodeCollectors;

import static sk.stuba.fiit.extise.Bootstrap.run;

import static sk.stuba.fiit.perconik.eclipse.jdt.core.dom.NodeType.METHOD_DECLARATION;

public final class MethodExtractor extends NodeExtractor {
  public MethodExtractor() {
    super(NodeCollectors.ofType(METHOD_DECLARATION));
  }

  public static void main(final String ... args) throws Exception {
    run(new MethodExtractor(), args);
  }
}

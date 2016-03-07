package sk.stuba.fiit.extise.dom;

import sk.stuba.fiit.perconik.core.java.dom.NodeCollectors;

import static sk.stuba.fiit.extise.Bootstrap.run;

import static sk.stuba.fiit.perconik.eclipse.jdt.core.dom.NodeType.ANNOTATION_TYPE_DECLARATION;
import static sk.stuba.fiit.perconik.eclipse.jdt.core.dom.NodeType.ENUM_DECLARATION;
import static sk.stuba.fiit.perconik.eclipse.jdt.core.dom.NodeType.TYPE_DECLARATION;

public final class TypePositionExtractor extends NodePositionExtractor {
  public TypePositionExtractor() {
    super(NodeCollectors.ofType(ANNOTATION_TYPE_DECLARATION, ENUM_DECLARATION, TYPE_DECLARATION));
  }

  public static void main(final String ... args) throws Exception {
    run(new TypePositionExtractor(), args);
  }
}

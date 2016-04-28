package sk.stuba.fiit.extise.map;

import static sk.stuba.fiit.perconik.eclipse.jdt.core.dom.NodeType.BLOCK_COMMENT;
import static sk.stuba.fiit.perconik.eclipse.jdt.core.dom.NodeType.JAVADOC;
import static sk.stuba.fiit.perconik.eclipse.jdt.core.dom.NodeType.LINE_COMMENT;

public final class JavaCommentTokenizer extends JavaTokenizer {
  public JavaCommentTokenizer() {
    super(nodeTokenizerFactory(BLOCK_COMMENT, LINE_COMMENT, JAVADOC));
  }
}

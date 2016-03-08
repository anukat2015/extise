package sk.stuba.fiit.extise.dom;

import com.google.common.base.Function;

import org.eclipse.jdt.core.dom.ASTNode;
import org.eclipse.jdt.core.dom.CompilationUnit;

import static com.google.common.base.Preconditions.checkNotNull;

import static sk.stuba.fiit.perconik.utilities.MorePreconditions.checkNotNullOrEmpty;

public final class NodeToSourceTransformer<N extends ASTNode> implements Function<N, String> {
  private final String source;

  private final CompilationUnit unit;

  private NodeToSourceTransformer(final String source, final CompilationUnit unit) {
    this.source = checkNotNullOrEmpty(source);
    this.unit = checkNotNull(unit);
  }

  public static <N extends ASTNode> NodeToSourceTransformer<N> on(final String source, final CompilationUnit unit) {
    return new NodeToSourceTransformer<>(source, unit);
  }

  public String apply(final N input) {
    return NodeRegion.of(this.unit, input).getSource(this.source);
  }

  @Override
  public boolean equals(final Object o) {
    if (this == o) {
      return true;
    }

    if (!(o instanceof NodeToSourceTransformer)) {
      return false;
    }

    NodeToSourceTransformer<?> other = (NodeToSourceTransformer<?>) o;

    return this.source.equals(other.source) && this.unit.equals(other.unit);
  }

  @Override
  public int hashCode() {
    return 31 * (31 * this.source.hashCode()) + this.unit.hashCode();
  }

  @Override
  public String toString() {
    return "source";
  }
}

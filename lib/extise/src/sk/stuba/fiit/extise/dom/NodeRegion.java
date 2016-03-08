package sk.stuba.fiit.extise.dom;

import org.eclipse.jdt.core.dom.ASTNode;
import org.eclipse.jdt.core.dom.CompilationUnit;

import sk.stuba.fiit.perconik.core.java.dom.NodeRangeType;

import static com.google.common.base.Preconditions.checkArgument;

import static sk.stuba.fiit.perconik.core.java.dom.NodeRangeType.STANDARD;
import static sk.stuba.fiit.perconik.utilities.MoreStrings.lines;

public final class NodeRegion {
  private static final NodeRangeType range = STANDARD;

  public final int offset;

  public final int length;

  private NodeRegion(final int offset, final int length) {
    this.offset = offset;
    this.length = length;
  }

  public static NodeRegion of(final CompilationUnit unit, final ASTNode node) {
    return of(range.getOffset(unit, node), range.getLength(unit, node));
  }

  public static NodeRegion of(final int offset, final int length) {
    checkArgument(offset >= 0);
    checkArgument(length >= 0);

    return new NodeRegion(offset, length);
  }

  @Override
  public boolean equals(final Object o) {
    if (this == o) {
      return true;
    }

    if (!(o instanceof NodeRegion)) {
      return false;
    }

    NodeRegion other = (NodeRegion) o;

    return this.offset == other.offset && this.length == other.length;
  }

  @Override
  public int hashCode() {
    return this.offset ^ this.length;
  }

  @Override
  public String toString() {
    return "offset=" + this.offset + ", length=" + this.length;
  }

  public int getLine(final CompilationUnit unit) {
    return unit.getLineNumber(this.offset);
  }

  public int[] getLines(final String input, final CompilationUnit unit) {
    int line = this.getLine(unit);
    int count = lines(this.getSource(input)).size();

    int[] lines = new int[count];

    for (int k = 0; k < count; k ++) {
      lines[k] = line + k;
    }

    return lines;
  }

  public String getSource(final String input) {
    return input.substring(this.offset, this.offset + this.length);
  }
}

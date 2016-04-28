package sk.stuba.fiit.extise.difference;

import java.util.Collection;
import java.util.List;

import difflib.Chunk;
import difflib.Delta;
import difflib.Delta.TYPE;
import difflib.DiffAlgorithm;
import difflib.DiffUtils;
import difflib.Patch;
import difflib.myers.MyersDiff;

import static com.google.common.collect.Lists.newArrayListWithCapacity;

import static sk.stuba.fiit.perconik.utilities.MoreStrings.lines;

public final class MyersTextDifferencer extends Differencer {
  public MyersTextDifferencer() {}

  static String chunk(final Chunk<String> chunk) {
    return chunk.getPosition() + ":" + chunk.getLines().size();
  }

  static String sign(final TYPE type) {
    switch (type) {
      case INSERT:
        return "+";
      case DELETE:
        return "-";
      case CHANGE:
        return "±";
      default:
        throw new AssertionError();
    }
  }

  @Override
  Collection<String> difference(final String original, final String revision) {
    DiffAlgorithm<String> algorithm = new MyersDiff<>();
    Patch<String> patch = DiffUtils.diff(lines(original), lines(revision), algorithm);
    List<Delta<String>> deltas = patch.getDeltas();
    List<String> difference = newArrayListWithCapacity(deltas.size());

    for (Delta<String> delta: deltas) {
      StringBuilder builder = new StringBuilder();

      builder.append(sign(delta.getType())).append(" ");
      builder.append(chunk(delta.getOriginal())).append(" ");
      builder.append(chunk(delta.getRevised()));

      difference.add(builder.toString());
    }

    return difference;
  }
}

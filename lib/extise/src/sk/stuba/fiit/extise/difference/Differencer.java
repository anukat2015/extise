package sk.stuba.fiit.extise.difference;

import java.util.Collection;
import java.util.Iterator;
import java.util.NoSuchElementException;

import javax.annotation.Nullable;

import sk.stuba.fiit.extise.Bootstrap;

abstract class Differencer extends Bootstrap.Unit<String> {
  Differencer() {}

  @Override
  public Collection<String> apply(final Collection<String> inputs) {
    Iterator<String> iterator = inputs.iterator();

    try {
      String original = partition(iterator.next()).next();
      String revision = partition(iterator.next()).next();

      if (iterator.hasNext()) {
        throw new IllegalArgumentException();
      }

      return difference(original, revision);
    } catch (NoSuchElementException reason) {
      throw new IllegalArgumentException(reason);
    }
  }

  @Override
  protected final Collection<String> apply(final String input, @Nullable final String file) {
    throw new UnsupportedOperationException();
  }

  @Override
  protected final Collection<String> apply(final String input) {
    throw new UnsupportedOperationException();
  }

  abstract Collection<String> difference(String original, String revision);
}

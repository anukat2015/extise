package sk.stuba.fiit.extise.map;

import java.util.Collection;
import java.util.Set;

import com.google.common.collect.ImmutableSet;

import static java.util.Arrays.asList;
import static java.util.Collections.EMPTY_LIST;

import static com.google.common.collect.ImmutableSet.copyOf;
import static com.google.common.collect.Sets.newHashSet;

class StopwordsFilter extends StringMapper {
  private final ImmutableSet<String> stopwords;

  StopwordsFilter(final Set<String> stopwords) {
    this.stopwords = copyOf(stopwords);
  }

  static Set<String> parse(final String content) {
    Set<String> stopwords = newHashSet();

    for (String stopword: content.split("\n")) {
      stopword = stopword.trim();

      if (!stopword.isEmpty() && !stopword.startsWith("#")) {
        stopwords.add(stopword);
      }
    }

    return stopwords;
  }

  @Override
  public final Collection<String> apply(final String input) {
    return this.stopwords.contains(input) ? EMPTY_LIST : asList(input);
  }
}

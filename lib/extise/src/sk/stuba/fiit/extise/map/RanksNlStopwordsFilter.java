package sk.stuba.fiit.extise.map;

import static sk.stuba.fiit.extise.Bootstrap.load;

public final class RanksNlStopwordsFilter extends StopwordsFilter {
  public RanksNlStopwordsFilter() {
    super(parse(load("stopwords/ranks.nl")));
  }
}

package sk.stuba.fiit.extise.map;

import static sk.stuba.fiit.extise.Bootstrap.load;
import static sk.stuba.fiit.extise.Bootstrap.run;

public final class RanksNlStopwordsFilter extends StopwordsFilter {
  public RanksNlStopwordsFilter() {
    super(parse(load("stopwords/ranks.nl")));
  }

  public static void main(final String ... args) throws Exception {
    run(new RanksNlStopwordsFilter(), args);
  }
}

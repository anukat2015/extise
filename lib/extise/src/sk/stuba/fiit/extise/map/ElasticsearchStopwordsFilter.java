package sk.stuba.fiit.extise.map;

import static sk.stuba.fiit.extise.Bootstrap.load;
import static sk.stuba.fiit.extise.Bootstrap.run;

public final class ElasticsearchStopwordsFilter extends StopwordsFilter {
  public ElasticsearchStopwordsFilter() {
    super(parse(load("stopwords/elasticsearch")));
  }

  public static void main(final String ... args) throws Exception {
    run(new ElasticsearchStopwordsFilter(), args);
  }
}

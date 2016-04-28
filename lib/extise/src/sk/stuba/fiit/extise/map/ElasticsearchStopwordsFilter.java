package sk.stuba.fiit.extise.map;

import static sk.stuba.fiit.extise.Bootstrap.load;

public final class ElasticsearchStopwordsFilter extends StopwordsFilter {
  public ElasticsearchStopwordsFilter() {
    super(parse(load("stopwords/elasticsearch")));
  }
}

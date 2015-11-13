package sk.stuba.fiit.extise.map;

import static sk.stuba.fiit.extise.Bootstrap.run;

public final class LovinsStemmer extends SnowballStemmer {
  public LovinsStemmer() {
    super(new org.tartarus.snowball.ext.LovinsStemmer());
  }

  public static void main(final String ... args) throws Exception {
    run(new LovinsStemmer(), args);
  }
}

package sk.stuba.fiit.extise.map;

import static sk.stuba.fiit.extise.Bootstrap.run;

public final class KpStemmer extends SnowballStemmer {
  public KpStemmer() {
    super(new org.tartarus.snowball.ext.KpStemmer());
  }

  public static void main(final String ... args) throws Exception {
    run(new KpStemmer(), args);
  }
}

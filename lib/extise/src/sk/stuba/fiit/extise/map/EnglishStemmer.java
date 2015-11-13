package sk.stuba.fiit.extise.map;

import static sk.stuba.fiit.extise.Bootstrap.run;

public final class EnglishStemmer extends SnowballStemmer {
  public EnglishStemmer() {
    super(new org.tartarus.snowball.ext.EnglishStemmer());
  }

  public static void main(final String ... args) throws Exception {
    run(new EnglishStemmer(), args);
  }
}

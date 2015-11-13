package sk.stuba.fiit.extise.map;

import static sk.stuba.fiit.extise.Bootstrap.run;

public final class PorterStemmer extends SnowballStemmer {
  public PorterStemmer() {
    super(new org.tartarus.snowball.ext.PorterStemmer());
  }

  public static void main(final String ... args) throws Exception {
    run(new PorterStemmer(), args);
  }
}

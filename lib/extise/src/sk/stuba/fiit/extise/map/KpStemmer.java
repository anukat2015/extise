package sk.stuba.fiit.extise.map;

public final class KpStemmer extends SnowballStemmer {
  public KpStemmer() {
    super(new org.tartarus.snowball.ext.KpStemmer());
  }
}

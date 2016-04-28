package sk.stuba.fiit.extise.map;

public final class EnglishStemmer extends SnowballStemmer {
  public EnglishStemmer() {
    super(new org.tartarus.snowball.ext.EnglishStemmer());
  }
}

package sk.stuba.fiit.extise.map;

public final class LovinsStemmer extends SnowballStemmer {
  public LovinsStemmer() {
    super(new org.tartarus.snowball.ext.LovinsStemmer());
  }
}

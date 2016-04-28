package sk.stuba.fiit.extise.map;

public final class PorterStemmer extends SnowballStemmer {
  public PorterStemmer() {
    super(new org.tartarus.snowball.ext.PorterStemmer());
  }
}

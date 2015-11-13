package sk.stuba.fiit.extise.map;

import java.util.Collection;
import java.util.regex.Pattern;

import static java.text.Normalizer.normalize;
import static java.text.Normalizer.Form.NFD;
import static java.util.Arrays.asList;
import static java.util.regex.Pattern.compile;

import static sk.stuba.fiit.extise.Bootstrap.run;

public final class UnaccentFilter extends StringMapper {
  public static void main(final String ... args) throws Exception {
    run(new UnaccentFilter(), args);
  }

  @Override
  public Collection<String> apply(final String input) {
    Pattern pattern = compile("\\p{InCombiningDiacriticalMarks}+");

    return asList(pattern.matcher(normalize(input, NFD)).replaceAll(""));
  }
}

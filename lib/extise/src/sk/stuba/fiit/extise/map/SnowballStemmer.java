package sk.stuba.fiit.extise.map;

import java.util.Collection;

import org.tartarus.snowball.SnowballProgram;

import static java.util.Arrays.asList;

import static com.google.common.base.Preconditions.checkNotNull;

class SnowballStemmer extends StringMapper {
  private final SnowballProgram program;

  SnowballStemmer(final SnowballProgram program) {
    this.program = checkNotNull(program);
  }

  @Override
  public final Collection<String> apply(final String input) {
    this.program.setCurrent(input);
    this.program.stem();

    return asList(this.program.getCurrent());
  }
}

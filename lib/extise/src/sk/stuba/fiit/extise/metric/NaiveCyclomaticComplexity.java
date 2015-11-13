package sk.stuba.fiit.extise.metric;

import java.util.Collection;

import com.google.common.base.Predicate;

import org.eclipse.jdt.core.dom.ASTNode;
import org.eclipse.jdt.core.dom.CompilationUnit;
import org.eclipse.jdt.core.dom.InfixExpression;
import org.eclipse.jdt.core.dom.InfixExpression.Operator;

import sk.stuba.fiit.perconik.core.java.dom.TreeParsers;
import sk.stuba.fiit.perconik.eclipse.jdt.core.dom.NodeType;

import static java.util.Arrays.asList;

import static com.google.common.base.Predicates.or;

import static org.eclipse.jdt.core.dom.InfixExpression.Operator.CONDITIONAL_AND;
import static org.eclipse.jdt.core.dom.InfixExpression.Operator.CONDITIONAL_OR;

import static sk.stuba.fiit.extise.Bootstrap.run;

import static sk.stuba.fiit.perconik.core.java.dom.NodeCounters.usingFilter;
import static sk.stuba.fiit.perconik.core.java.dom.NodeFilters.isMatching;
import static sk.stuba.fiit.perconik.eclipse.jdt.core.dom.NodeType.ASSERT_STATEMENT;
import static sk.stuba.fiit.perconik.eclipse.jdt.core.dom.NodeType.CATCH_CLAUSE;
import static sk.stuba.fiit.perconik.eclipse.jdt.core.dom.NodeType.CONDITIONAL_EXPRESSION;
import static sk.stuba.fiit.perconik.eclipse.jdt.core.dom.NodeType.DO_STATEMENT;
import static sk.stuba.fiit.perconik.eclipse.jdt.core.dom.NodeType.ENHANCED_FOR_STATEMENT;
import static sk.stuba.fiit.perconik.eclipse.jdt.core.dom.NodeType.FOR_STATEMENT;
import static sk.stuba.fiit.perconik.eclipse.jdt.core.dom.NodeType.IF_STATEMENT;
import static sk.stuba.fiit.perconik.eclipse.jdt.core.dom.NodeType.INFIX_EXPRESSION;
import static sk.stuba.fiit.perconik.eclipse.jdt.core.dom.NodeType.SWITCH_STATEMENT;
import static sk.stuba.fiit.perconik.eclipse.jdt.core.dom.NodeType.TRY_STATEMENT;
import static sk.stuba.fiit.perconik.eclipse.jdt.core.dom.NodeType.WHILE_STATEMENT;

public final class NaiveCyclomaticComplexity extends NumericMetric<Integer> {
  private static final int N = 1;

  // TODO include ELSE, CASE, THROW, THROWS, CATCH, FINALLY, BREAK, CONTINUE, RETURN, METHOD_INVOCATIONS?

  private static final NodeType[] TYPES = {
      ASSERT_STATEMENT,
      CATCH_CLAUSE,
      CONDITIONAL_EXPRESSION,
      DO_STATEMENT,
      ENHANCED_FOR_STATEMENT,
      FOR_STATEMENT,
      IF_STATEMENT,
      SWITCH_STATEMENT,
      TRY_STATEMENT,
      WHILE_STATEMENT
  };

  public static void main(final String ... args) throws Exception {
    run(new NaiveCyclomaticComplexity(), args);
  }

  private enum IsConditionalOperator implements Predicate<ASTNode> {
    instance;

    @Override
    public boolean apply(final ASTNode input) {
      if (!INFIX_EXPRESSION.isMatching(input)) {
        return false;
      }

      Operator o = ((InfixExpression) input).getOperator();

      return o == CONDITIONAL_AND || o == CONDITIONAL_OR;
    }
  }

  @Override
  public Collection<Integer> apply(final String input) {
    CompilationUnit unit = (CompilationUnit) TreeParsers.parse(input);

    return asList(N + usingFilter(or(isMatching(asList(TYPES)), IsConditionalOperator.instance)).apply(unit));
  }
}

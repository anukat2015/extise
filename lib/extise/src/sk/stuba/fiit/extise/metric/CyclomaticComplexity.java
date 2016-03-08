package sk.stuba.fiit.extise.metric;

import java.util.Collection;

import org.eclipse.jdt.core.dom.AnonymousClassDeclaration;
import org.eclipse.jdt.core.dom.AssertStatement;
import org.eclipse.jdt.core.dom.Assignment;
import org.eclipse.jdt.core.dom.BreakStatement;
import org.eclipse.jdt.core.dom.CatchClause;
import org.eclipse.jdt.core.dom.CompilationUnit;
import org.eclipse.jdt.core.dom.ConditionalExpression;
import org.eclipse.jdt.core.dom.ConstructorInvocation;
import org.eclipse.jdt.core.dom.ContinueStatement;
import org.eclipse.jdt.core.dom.DoStatement;
import org.eclipse.jdt.core.dom.EnhancedForStatement;
import org.eclipse.jdt.core.dom.FieldAccess;
import org.eclipse.jdt.core.dom.ForStatement;
import org.eclipse.jdt.core.dom.IfStatement;
import org.eclipse.jdt.core.dom.InfixExpression;
import org.eclipse.jdt.core.dom.InfixExpression.Operator;
import org.eclipse.jdt.core.dom.MethodInvocation;
import org.eclipse.jdt.core.dom.ReturnStatement;
import org.eclipse.jdt.core.dom.SuperConstructorInvocation;
import org.eclipse.jdt.core.dom.SuperFieldAccess;
import org.eclipse.jdt.core.dom.SuperMethodInvocation;
import org.eclipse.jdt.core.dom.SwitchCase;
import org.eclipse.jdt.core.dom.SwitchStatement;
import org.eclipse.jdt.core.dom.ThrowStatement;
import org.eclipse.jdt.core.dom.TryStatement;
import org.eclipse.jdt.core.dom.WhileStatement;

import sk.stuba.fiit.perconik.core.java.dom.traverse.NodeVisitor;

import static java.util.Arrays.asList;

import static sk.stuba.fiit.extise.Bootstrap.run;
import static sk.stuba.fiit.extise.Java.parse;

public final class CyclomaticComplexity extends NumericMetric<Integer> {
  public static void main(final String ... args) throws Exception {
    run(new CyclomaticComplexity(), args);
  }

  private static final class Complexer extends NodeVisitor {
    int v = 1;

    Complexer() {}

    // annotations and declarations

    @Override
    public boolean visit(final AnonymousClassDeclaration node) {
      // do not skip anonymous classes

      return true;
    }

    // assignments and invocations

    @Override
    public boolean visit(final Assignment node) {
      // assignment does not add to complexity
      this.v += 0;

      return super.visit(node);
    }

    @Override
    public boolean visit(final FieldAccess node) {
      // field access does not add to complexity
      this.v += 0;

      return super.visit(node);
    }

    @Override
    public boolean visit(final SuperFieldAccess node) {
      // field access does not add to complexity
      this.v += 0;

      return super.visit(node);
    }

    @Override
    public boolean visit(final ConstructorInvocation node) {
      // constructor invocation does not add to complexity
      this.v += 0;

      return super.visit(node);
    }

    @Override
    public boolean visit(final SuperConstructorInvocation node) {
      // constructor invocation does not add to complexity
      this.v += 0;

      return super.visit(node);
    }

    @Override
    public boolean visit(final MethodInvocation node) {
      // method invocation does not add to complexity
      this.v += 0;

      return super.visit(node);
    }

    @Override
    public boolean visit(final SuperMethodInvocation node) {
      // method invocation does not add to complexity
      this.v += 0;

      return super.visit(node);
    }

    // expressions and statements

    @Override
    public boolean visit(final AssertStatement node) {
      // assert statement opens two possible branches
      this.v += 2;

      return super.visit(node);
    }

    @Override
    public boolean visit(final IfStatement node) {
      // if statement opens two possible branches,
      // the presence of else part is irrelevant
      this.v += 2;

      return super.visit(node);
    }

    @Override
    public boolean visit(final ConditionalExpression node) {
      // conditional expression opens two possible branches
      this.v += 2;

      return super.visit(node);
    }

    @Override
    public boolean visit(final InfixExpression node) {
      Operator operator = node.getOperator();

      // conditional operators slightly increase complexity
      if (operator == Operator.CONDITIONAL_AND || operator == Operator.CONDITIONAL_OR) {
        this.v += 1;
      }

      return super.visit(node);
    }

    @Override
    public boolean visit(final SwitchStatement node) {
      // switch statement itself does not add to complexity
      this.v += 0;

      return super.visit(node);
    }

    @Override
    public boolean visit(final SwitchCase node) {
      // switch case opens one possible branch
      this.v += 1;

      return super.visit(node);
    }

    @Override
    public boolean visit(final WhileStatement node) {
      // while statement opens one possible branch
      this.v += 1;

      return super.visit(node);
    }

    @Override
    public boolean visit(final DoStatement node) {
      // do statement does not open any new branch
      this.v += 0;

      return super.visit(node);
    }

    @Override
    public boolean visit(final ForStatement node) {
      // for statement opens one possible branch
      this.v += 1;

      return super.visit(node);
    }

    @Override
    public boolean visit(final EnhancedForStatement node) {
      // enhanced for statement opens one possible branch
      this.v += 1;

      return super.visit(node);
    }

    @Override
    public boolean visit(final BreakStatement node) {
      // break statement does not add to complexity
      this.v += 0;

      return super.visit(node);
    }

    @Override
    public boolean visit(final ContinueStatement node) {
      // continue statement does not add to complexity
      this.v += 0;

      return super.visit(node);
    }

    @Override
    public boolean visit(final ReturnStatement node) {
      // return statement does not add to complexity
      this.v += 0;

      return super.visit(node);
    }

    @Override
    public boolean visit(final TryStatement node) {
      // try statement itself does not add to complexity
      this.v += 0;

      return super.visit(node);
    }

    @Override
    public boolean visit(final ThrowStatement node) {
      // throw statement does not add to complexity
      this.v += 0;

      return super.visit(node);
    }

    @Override
    public boolean visit(final CatchClause node) {
      // catch clause opens one possible branch
      this.v += 1;

      return super.visit(node);
    }
  }

  @Override
  public Collection<Integer> apply(final String input) {
    CompilationUnit unit = (CompilationUnit) parse(input);
    Complexer complexer = new Complexer();

    complexer.subtreeVisit(unit);

    return asList(complexer.v);
  }
}

package sk.stuba.fiit.extise;

import java.util.Map;

import org.eclipse.jdt.core.JavaCore;
import org.eclipse.jdt.core.dom.ASTNode;
import org.eclipse.jdt.core.dom.ASTParser;

import sk.stuba.fiit.perconik.core.java.dom.Nodes;

import static org.eclipse.jdt.core.JavaCore.COMPILER_CODEGEN_TARGET_PLATFORM;
import static org.eclipse.jdt.core.JavaCore.COMPILER_COMPLIANCE;
import static org.eclipse.jdt.core.JavaCore.COMPILER_SOURCE;
import static org.eclipse.jdt.core.JavaCore.VERSION_1_7;

import static sk.stuba.fiit.perconik.eclipse.jdt.core.dom.TreeApiLevel.JLS4;

public final class Java {
  private Java() {}

  public static ASTNode parse(final String source) {
    Map<String, String> options = JavaCore.getOptions();

    options.put(COMPILER_COMPLIANCE, VERSION_1_7);
    options.put(COMPILER_CODEGEN_TARGET_PLATFORM, VERSION_1_7);
    options.put(COMPILER_SOURCE, VERSION_1_7);

    ASTParser parser = ASTParser.newParser(JLS4.getValue());

    parser.setCompilerOptions(options);

    return Nodes.create(parser, source);
  }
}

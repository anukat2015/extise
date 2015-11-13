package sk.stuba.fiit.extise;

import java.io.File;
import java.util.Collection;

import com.google.common.base.Function;
import com.google.common.io.Files;

import org.elasticsearch.common.base.Charsets;
import sk.stuba.fiit.extise.map.ElasticsearchStopwordsFilter;
import sk.stuba.fiit.extise.map.JavaQualifiedNameTokenizer;
import sk.stuba.fiit.extise.map.JavaSimpleNameTokenizer;
import sk.stuba.fiit.extise.map.LowercaseFilter;
import sk.stuba.fiit.extise.map.PorterStemmer;
import sk.stuba.fiit.extise.map.SortFilter;
import sk.stuba.fiit.extise.map.UnaccentFilter;
import sk.stuba.fiit.extise.map.UniqueFilter;
import sk.stuba.fiit.extise.map.WhitespaceFilter;
import sk.stuba.fiit.extise.metric.CommentLinesOfCode;
import sk.stuba.fiit.extise.metric.CyclomaticComplexity;
import sk.stuba.fiit.extise.metric.LinesOfCode;
import sk.stuba.fiit.extise.metric.LogicLinesOfCode;
import sk.stuba.fiit.extise.metric.NaiveCyclomaticComplexity;
import sk.stuba.fiit.extise.metric.SourceLinesOfCode;

import static com.google.common.base.Functions.compose;

public final class Main {
  public static void main(final String ... args) throws Exception {
    String path = "../../spec/fixtures/classes/HashMap.java";
    String fixture = Files.toString(new File(path), Charsets.UTF_8);

    Function<Collection<String>, Collection<String>> fx;

    fx = new JavaSimpleNameTokenizer();
    fx = new JavaQualifiedNameTokenizer();
    //fx = new JavadocTokenizer();
    //fx = new JavaSmartTokenizer();
    //fx = new WhitespaceTokenizer();

    //fx = compose(new EnglishStemmer(), fx);
    fx = compose(new PorterStemmer(), fx);
    //fx = compose(new KpStemmer(), fx);
    //fx = compose(new LovinsStemmer(), fx);

    fx = compose(new ElasticsearchStopwordsFilter(), fx);
    //fx = compose(new RanksNlStopwordsFilter(), fx);

    fx = compose(new LowercaseFilter(), fx);
    fx = compose(new UnaccentFilter(), fx);
    fx = compose(new UniqueFilter(), fx);
    fx = compose(new WhitespaceFilter(), fx);
    fx = compose(new SortFilter(), fx);

    Bootstrap.run(fx, path);

    Bootstrap.run(new LinesOfCode(), path);
    Bootstrap.run(new SourceLinesOfCode(), path);
    Bootstrap.run(new LogicLinesOfCode(), path);
    Bootstrap.run(new CommentLinesOfCode(), path);

    Bootstrap.run(new NaiveCyclomaticComplexity(), path);
    Bootstrap.run(new CyclomaticComplexity(), path);
  }
}

# Extise

A collection of tools to estimate developers' expertise

## Requirements

- Bash 4.3.42
- Ruby 2.2.3
- PostgreSQL 9.5.1
- Java 1.7
- Eclipse 4.3
- JDT 3.8
- EGit 2.2
- Maven 3.2
- Tycho 0.20

## Structure

    bin                     Runnable commands and utilities
    db                      Database configuration and migrations
    docs                    Generated and other documentation
    lib                     Libraries along binary dependencies
      bugs_eclipse_org      Eclipse bugs and Mylyn context model
      core_ext              Extensions to Ruby core libraries
      database              Database access and model bindings
      expric                Experimental metrics
      extinf                Concept inferencers
      extise                Java DOM manipulation, IR utilities, SW metrics
      extisimo              Custom data model
      extnorm               Basic normalizations
      extric                Basic metrics
      git_eclipse_org       Eclipse Git repository utilities
    log                     Log files
    spec                    Test suites
    tmp                     Temporary files

## Data

Data repository is expected at `../data` by default, see [Extise Data](https://github.com/pavolzbell/extise-data)

## Commands

Every executable command responds to:

    -h, --help
        --version

additionally if appropriate to:

    -c, --[no-]color                        Default true
    -s, --[no-]sort                         Default true or false
    -t, --trim[=<length>]                   Default 80
    -v, --[no-]verbose                      Default true or false
    -q, --quiet                             Default false

and if parallelism is supported to:

        --parallel[=<count>]                Default 4
        --parallel-worker=(process|thread)  Default thread

## Data acquisition

Following commands do not have to be executed subsequently:

#### `fetch_gerrit_changes`

Download Gerrit change files according to input URL

    fetch_gerrit_changes https://git.eclipse.org/r

#### `fetch_mylyn_contexts`

Download and unpack Mylyn context files from remote server according to input bugs file  

    fetch_mylyn_contexts ../data/bugs.eclipse.org/bugzilla-bugs-20160110-1824/with-mylyn-contexts.xml

## Data import

Following commands should be executed subsequently:

#### `import_eclipse_bugs`

Import Eclipse bugs, fill `bugs_eclipse_org_{bugzillas,users,bugs,comments,attachments}` tables  

    import_eclipse_bugs ../data/bugs.eclipse.org/bugzilla-bugs-20160110-1824/with-mylyn-contexts.xml --stat
    import_eclipse_bugs ../data/bugs.eclipse.org/bugzilla-bugs-20160110-1824/with-mylyn-contexts.xml

Import Eclipse bugs with Mylyn context interactions, fill `bugs_eclipse_org_{bugzillas,users,bugs,comments,attachments,interactions}` tables

    import_eclipse_bugs ../data/bugs.eclipse.org/bugzilla-bugs-20160110-1824/with-mylyn-contexts.xml --mylyn-contexts=../data/bugs.eclipse.org/mylyn-contexts-20160110-1829 --stat
    import_eclipse_bugs ../data/bugs.eclipse.org/bugzilla-bugs-20160110-1824/with-mylyn-contexts.xml --mylyn-contexts=../data/bugs.eclipse.org/mylyn-contexts-20160110-1829
    import_eclipse_bugs ../data/bugs.eclipse.org/bugzilla-bugs-20160110-1824/with-mylyn-contexts.xml --mylyn-contexts=../data/bugs.eclipse.org/mylyn-contexts-20160110-1829 --mylyn-contexts-mode=delete

#### `import_eclipse_changes`

Import Eclipse changes, fill `git_eclipse_org_{users,projects,changes,reviews,labels}` tables
  
    import_eclipse_changes ../data/git.eclipse.org/gerrit-changes-20160411-1826 --stat
    import_eclipse_changes ../data/git.eclipse.org/gerrit-changes-20160411-1826

#### `import_mylyn_contexts`

Import Mylyn context interactions, fill `bugs_eclipse_org_{interactions}` tables

    import_mylyn_contexts ../data/bugs.eclipse.org/mylyn-contexts-20160110-1829/71687.xml --stat
    import_mylyn_contexts ../data/bugs.eclipse.org/mylyn-contexts-20160110-1829/71687.xml

#### `import_extise_users`

Import Extise users from Eclipse bugs and changes, fill `extisimo_{users}` tables

    import_extise_users bugs_eclipse_org
    import_extise_users git_eclipse_org

#### `patch_extise_users`

Patch Extise users with aliases, fill `extisimo_{users}` tables

    patch_extise_users ../data/bugs.eclipse.org/users-to-aliases.csv

#### `import_extise_tasks`

Import Extise tasks from Eclipse bugs, fill `extisimo_{projects,tasks,posts,attachments}` tables

    import_extise_tasks

#### `map_extise_repositories`

Map Extise repositories to projects, fill `extisimo_{repositories}` tables

    map_extise_repositories ../data/bugs.eclipse.org/repositories-to-projects.csv

#### `import_extise_commits`

Import Extise commits from repositories, fill `extisimo_{commits,elements}` tables

    import_extise_commits eclipse.pde.ui

#### `import_extise_interactions`

Import Extise interactions from tasks and commits, fill `extisimo_{sessions,interactions}` tables

    import_extise_interactions eclipse.pde.ui

#### `load_inferencers`

Load concept inferencers, fill `extisimo_{inferencers}` tables

    TODO

Unloads concept inferencers, deplete `extisimo_{inferencers,concepts}` tables

    TODO

#### `load_metrics`

Load expertise metrics, fill `extisimo_{metrics}` tables

    load_metrics
    load_metrics lib/extric/elements/*
    load_metrics --library=lib/extric

Unloads expertise metrics, deplete `extisimo_{metrics}` tables

    load_metrics --unload
    load_metrics --unload session
    load_metrics --unload session recent_lines_of_code
    load_metrics --unload lib/extric/elements/*
    load_metrics --unload --library=lib/extric

Unloads expertise metrics along with corresponding expertises, deplete `extisimo_{metrics,expertises}` tables

    load_metrics --unload=force

### Raw import

#### `psql`

Import from raw SQL 

    psql -U extise extise_development < ../data/extise.fiit.stuba.sk/database-exports/extise_development-bugs_eclipse_org-20160422-0110_bugzilla-bugs-20160110-1824.sql

## Data export

### Raw export

#### `pg_dump`

Export to raw SQL

    pg_dump -U extise --data-only --exclude-table=schema_\* extise_development > extise_development.sql
    pg_dump -U extise --data-only --table=bugs_eclipse_org_\* extise_development > extise_development-bugs_eclipse_org.sql

## Data lookup

#### `dbstat`

Print database statistics

    dbstat
    dbstat bugs_eclipse_org

#### `ropen`

Open data entity

    ropen project PDE UI
    ropen repository eclipse.pde.ui
    ropen commit eclipse.pde.ui 95ad7b194d9a98b93cd129f464dd5380842cf3a9 --service egit
    ropen element eclipse.pde.ui 9617552fae0b9e5e284f1b54f7a4b9f6cd25287c RegistryBrowser

## Source analysis

#### `extise`

Run Java source code or text analysis

    extise list

    extise MethodPositionExtractor < spec/fixtures/classes/HashMap.java
    extise CyclomaticComplexity -- spec/fixtures/classes/HashMap.java spec/fixtures/classes/TimeUnit.java 
    extise JavaQualifiedNameTokenizer UnaccentFilter LowercaseFilter PorterStemmer ElasticsearchStopwordsFilter WhitespaceFilter UniqueFilter SortFilter -- spec/fixtures/classes/*

    extise server
    extise server --address=localhost:7153 --pool=200
    
    curl -H 'Argument: CyclomaticComplexity' -H 'Argument: --' -H 'Argument: spec/fixtures/classes/Component.java' localhost:7153
    curl -H 'Argument: CyclomaticComplexity' -X POST --data-binary @- localhost:7153 < spec/fixtures/classes/Component.java

#### `jgibblda`

Run JGibbLDA for parameter estimation or inference

    TODO

## Concept inference

#### `infer`

Infer concepts by inferencer

    TODO

## Expertise estimation

#### `measure`

Measure expertises by metric, fill `extisimo_{expertises}` tables

    measure session
    measure session recent_lines_of_code
    measure session recent_lines_of_code --until=now

#### `normalize`

Normalize expertises measured by metric, fill `extisimo_{metrics,expertises}` tables

    normalize session recent_lines_of_code
    normalize session recent_lines_of_code --method=tanh

## Statistical analysis

#### `hist`

Compute data histogram

    hist ../samples/data
    hist -e '[0,1,0]'
    
    echo 0\n1\n0 | hist
    echo [0,1,0] | hist -e

#### `rhist`

Compute data histogram on attributes of entities

    rhist BugsEclipseOrg::Bug priority
    rhist -e 'BugsEclipseOrg::Bug.pluck :priority'
    
    echo 'BugsEclipseOrg::Bug.pluck :priority' | rhist -e

#### `cor`

Calculate correlation coefficient
    
    cor ../samples/vectors
    cor ../samples/vector-x ../samples/vector-y
    cor -e '[0,2,1,8,4,0,1,4]' -m pearson 
    cor -e '[0,2,1,8]' '[4,0,1,4]'

    echo 0\n3\n7\n9\n0\n9\n7 | cor
    echo [0,3,7,1,9,0,9,7] | cor -e

#### `rcor`

Calculate correlation coefficient between expertises

    rcor session:edits session:lines_of_code_delta
    rcor -e 'Extisimo::Expertise.by(Extisimo::Metric.find_by target: :session, name: :edits).pluck :value' 'Extisimo::Expertise.by(Extisimo::Metric.find_by target: :session, name: :lines_of_code_delta).pluck :value'

    echo 'Extisimo::Expertise.by(Extisimo::Metric.find_by target: :session, name: :edits).pluck(:value) + Extisimo::Expertise.by(Extisimo::Metric.find_by target: :session, name: :lines_of_code_delta).pluck(:value)' | rcor -e 

#### `ucor`

Calculate correlation coefficient between expertises for each user

    ucor session:edits session:lines_of_code_delta

## Batch commands

#### `bae`

Run command batches 

    bae ../data/extise.fiit.stuba.sk/measurements/basic/session-*
    bae ../data/extise.fiit.stuba.sk/measurements/basic/session-* --open

    echo measure target: :session, metric: :duration, normalization: :rescale | bae

## Utilities

#### `lsxml`

List XML contents

    lsxml ../data/bugs.eclipse.org/mylyn-contexts-20160110-1829/71687.xml

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin new-feature`)
5. Create new Pull Request

## License

This software is released under the [MIT License](LICENSE.md)

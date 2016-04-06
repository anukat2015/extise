# Extise

A collection of tools to estimate developers' expertise

## Requirements

- Ruby 2.2.3
- PostgreSQL 9.5.1
- Java 1.8
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
      database              Database access and model bindings
      extinf                Concept inferencers
      extise                Java DOM manipulation, IR utilities, SW metrics
      extisimo              Custom data model
      extric                Expertise metrics
      git_eclipse_org       Eclipse Git repository utilities
    log                     Log files
    spec                    RSpec test suite
    tmp                     Temporary files

## Commands

Every executable command responds to:

    -h, --help
        --version

and additionally, if appropriate to:
 
    -c, --[no-]color                 Default true
    -s, --[no-]sort                  Default true or false
    -t, --trim[=<length>]            Default 80
    -v, --[no-]verbose               Default true or false

## Data acquisition

Following commands do not have to be executed subsequently:

#### `fetch_eclipse_pages`

Download Eclipse pages of Bugzilla bugs and corresponding Gerrit changes according to input bugs file

    fetch_eclipse_pages ../data/bugs.eclipse.org/all-with-mylyn-context-20160110-1824.xml

#### `fetch_mylyn_contexts`

Download and unpack Mylyn context files from remote server according to input bugs file  

    fetch_mylyn_contexts ../data/bugs.eclipse.org/all-with-mylyn-context-20160110-1824.xml

## Data import

Following commands should be executed subsequently:

#### `import_eclipse_bugs`

Import Eclipse bugs, fill `bugs_eclipse_org_{bugzillas,users,bugs,comments,attachments}` tables  

    import_eclipse_bugs ../data/bugs.eclipse.org/all-with-mylyn-context-20160110-1824.xml --stat
    import_eclipse_bugs ../data/bugs.eclipse.org/all-with-mylyn-context-20160110-1824.xml
    import_eclipse_bugs ../data/bugs.eclipse.org/all-with-mylyn-context-20160110-1824.xml --mylyn-contexts=../data/bugs.eclipse.org/mylyn-contexts-20160110-1829
    import_eclipse_bugs ../data/bugs.eclipse.org/all-with-mylyn-context-20160110-1824.xml --mylyn-contexts=../data/bugs.eclipse.org/mylyn-contexts-20160110-1829 --mylyn-contexts-mode=delete

#### `import_eclipse_changes`

Import Eclipse changes, fill `git_eclipse_org_{users,projects,changes,reviews,labels}` tables
  
    import_eclipse_changes ../data/bugs.eclipse.org/all-with-mylyn-context-20160110-1824.xml --stat
    import_eclipse_changes ../data/bugs.eclipse.org/all-with-mylyn-context-20160110-1824.xml
    import_eclipse_changes ../data/bugs.eclipse.org/all-with-mylyn-context-20160110-1824.xml --bugzilla-pages=../data/bugs.eclipse.org/eclipse-bugs-20160330-0106 --gerrit-pages=../data/git.eclipse.org/eclipse-changes-20160330-0129

#### `import_mylyn_contexts`

Import Mylyn context interactions, fill `bugs_eclipse_org_{interactions}` tables

    import_mylyn_contexts ../data/bugs.eclipse.org/mylyn-contexts-20160110-1829/71687.xml --stat
    import_mylyn_contexts ../data/bugs.eclipse.org/mylyn-contexts-20160110-1829/71687.xml

#### `import_extise_tasks`

Import Extise tasks from Eclipse bugs, fill `extisimo_{users,projects,tasks,posts,attachments}` tables

    import_extise_tasks

#### `map_extise_repositories`

Map Extise repositories to projects, fill `extisimo_{repositories}` tables

    map_extise_repositories ../data/bugs.eclipse.org/repositories-to-projects-map.csv

#### `import_extise_commits`

Import Extise commits from repositories, fill `extisimo_{commits,elements}` tables

    import_extise_commits eclipse.pde.ui

#### `import_extise_interactions`

Import Extise interactions from tasks and commits, fill `extisimo_{sessions,interactions}` tables

    import_extise_interactions eclipse.pde.ui

#### `load_inferencers`

Load concept inferencers, fill `extisimo_{inferencers}` tables

    load_inferencers
    load_inferencers lib/extinf/tasks/*
    load_inferencers --library=lib/extinf

    load_inferencers --unload
    load_inferencers --unload=delete lib/extric/tasks/jgibblda.rb

#### `load_metrics`

Load expertise metrics, fill `extisimo_{metrics}` tables

    load_metrics
    load_metrics lib/extric/elements/*
    load_metrics --library=lib/extric

    load_metrics --unload
    load_metrics --unload=delete lib/extric/sessions/recent_lines_of_code.rb

### Raw import

#### `psql`

Import from raw SQL 

    psql -U extise extise_development < ../data/extise.fiit.stuba.sk/extise_development-bugs_eclipse_org-20160113-all-with-mylyn-context-20160110-1824.sql

## Data export

### Raw export

#### `pg_dump`

Export to raw SQL

    pg_dump -U extise --exclude-table=schema_\* --data-only extise_development > extise_development.sql

## Source analysis

#### `extise`

TODO

    extise --list
    extise MethodPositionExtractor < spec/fixtures/classes/HashMap.java
    extise CyclomaticComplexity < spec/fixtures/classes/HashMap.java
    extise JavaQualifiedNameTokenizer UnaccentFilter LowercaseFilter PorterStemmer ElasticsearchStopwordsFilter WhitespaceFilter UniqueFilter SortFilter -- spec/fixtures/classes/*

#### `jgibblda`

TODO

## Concept inference

#### `infer`

TODO

## Expertise estimation

#### `measure`

    measure session
    measure element recent_lines_of_code

## Utilities

#### `lsxml`

    lsxml ../data/bugs.eclipse.org/mylyn-contexts-20160110-1829/71687.xml

#### `dbstat`

    dbstat
    dbstat bugs_eclipse_org

#### `hist`

    hist ../data/extise.fiit.stuba.sk/extise_development-bugs_eclipse_org-20160113_all-with-mylyn-context-20160110-1824.warnings
    hist -e '[1,2,1]'
    echo 1\n2\n1 | hist
    echo [1,2,1] | hist -e

#### `rhist`

    rhist BugsEclipseOrg::Bug priority
    rhist -e 'BugsEclipseOrg::Bug.pluck(:priority)'

#### `ropen`

    ropen project PDE UI
    ropen repository eclipse.pde.ui
    ropen commit eclipse.pde.ui 95ad7b194d9a98b93cd129f464dd5380842cf3a9 --service egit
    ropen element eclipse.pde.ui 9617552fae0b9e5e284f1b54f7a4b9f6cd25287c RegistryBrowser

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin new-feature`)
5. Create new Pull Request

## License

This software is released under the [MIT License](LICENSE.md)

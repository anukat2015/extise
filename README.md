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
      extise                Java DOM manipulation, IR utilities and SW metrics
      extisimo              Expertise model of developers
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

Following commands should be executed subsequently:

#### `fetch_mylyn_contexts`

Download and unpack Mylyn context files from remote server according to input bugs file  

    fetch_mylyn_contexts ../data/bugs.eclipse.org/all-with-mylyn-context-20160110-1824.xml

## Data import

Following commands should be executed subsequently:

#### `import_eclipse_bugs`

Import Eclipse bugs, fill `bugs_eclipse_org_{bugzillas,users,bugs,comments,attachments}` tables  

    import_eclipse_bugs ../data/bugs.eclipse.org/all-with-mylyn-context-20160110-1824.xml --stat
    import_eclipse_bugs ../data/bugs.eclipse.org/all-with-mylyn-context-20160110-1824.xml
    import_eclipse_bugs ../data/bugs.eclipse.org/all-with-mylyn-context-20160110-1824.xml --mylyn=../data/bugs.eclipse.org/mylyn-context-20160110-1829

#### `import_mylyn_contexts`

Import Mylyn context interactions, fill `bugs_eclipse_org_{interactions}` tables

    import_mylyn_contexts ../data/bugs.eclipse.org/mylyn-context-20160110-1829/71687.xml --stat
    import_mylyn_contexts ../data/bugs.eclipse.org/mylyn-context-20160110-1829/71687.xml
    
#### `import_extise_tasks`

Import Extise tasks from Eclipse bugs, fill `extisimo_{users,projects,tasks,posts,attachments}` tables

    import_extise_tasks

#### `map_extise_repositories`

Map Extise repositories to projects, fill `extisimo_{repositories}` tables

    map_extise_repositories ../data/bugs.eclipse.org/repositories-to-projects-map.csv

#### `import_extise_commits`

Import Extise commits from repositories, fill `extisimo_{commits,elements}` tables

    import_extise_commits eclipse.pde.ui
    import_extise_commits eclipse.pde.ui --extract=method

#### `import_extise_interactions`

Import Extise interactions from tasks and commits, fill `extisimo_{sessions,interactions}` tables

    import_extise_interactions eclipse.pde.ui
    import_extise_interactions eclipse.pde.ui --match=method

### Raw import

#### `psql`

Import from raw SQL 

    psql -U extise extise_development < ../data/extise.fiit.stuba.sk/extise_development-bugs_eclipse_org-20160113-all-with-mylyn-context-20160110-1824.sql

## Data export

### Raw export

#### `pg_dump`

Export to raw SQL

    pg_dump -U extise --exclude-table=schema_\* --data-only extise_development > extise_development.sql

## Analysis

#### `extise`

TODO

    extise --list
    extise MethodPositionExtractor < spec/fixtures/classes/HashMap.java
    extise CyclomaticComplexity < spec/fixtures/classes/HashMap.java
    extise JavaQualifiedNameTokenizer UnaccentFilter LowercaseFilter PorterStemmer ElasticsearchStopwordsFilter WhitespaceFilter UniqueFilter SortFilter -- spec/fixtures/classes/*

#### `jgibblda`

TODO

## Utilities

#### `lsxml`

    lsxml ../data/bugs.eclipse.org/mylyn-context-20160110-1829/71687.xml

#### `dbstat`

    dbstat
    dbstat bugs_eclipse_org

#### `hist`

    hist ../data/extise.fiit.stuba.sk/extise_development-bugs_eclipse_org-20160113_all-with-mylyn-context-20160110-1824.warnings
    hist -e '[1,2,1]'
    echo 1\n2\n1 | hist
    echo [1,2,1] | hist -e

#### `rhist`

    rhist BugsEclipseOrg::Bug priority'
    rhist -e 'BugsEclipseOrg::Bug.pluck(:priority)'

#### `ropen`

    ropen project PDE UI
    ropen repository eclipse.pde.ui
    ropen -s egit commit eclipse.pde.ui 95ad7b194d9a98b93cd129f464dd5380842cf3a9
    ropen element eclipse.pde.ui 1837573ce7fdb32310064e06230cd995173dc2f6 5694e314bed2ebc911ff9643e6961b848bd35bb6 EEDescriptionGenerator

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin new-feature`)
5. Create new Pull Request

## License

This software is released under the [MIT License](LICENSE.md)

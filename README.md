# Extise

A collection of tools to estimate developers' expertise

## Requirements

- Ruby 2.2.3
- PostgreSQL 9.4.5
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

Executable commands respond to:

    -h, --help
        --version

and additionally if appropriate to:
 
    -c, --[no-]color                 Default true
    -s, --[no-]sort                  Default true or false
    -t, --trim[=<length>]            Default 80
    -v, --[no-]verbose               Default true or false

## Data acquisition

#### `fetch_mylyn_contexts`

    fetch_mylyn_contexts ../data/bugs.eclipse.org/all-with-mylyn-context-20160110-1824.xml

## Data import

#### `import_eclipse_bugs`

    import_eclipse_bugs ../data/bugs.eclipse.org/all-with-mylyn-context-20160110-1824.xml --stat
    import_eclipse_bugs ../data/bugs.eclipse.org/all-with-mylyn-context-20160110-1824.xml
    import_eclipse_bugs ../data/bugs.eclipse.org/all-with-mylyn-context-20160110-1824.xml --mylyn=../data/bugs.eclipse.org/mylyn-context
    
#### `import_mylyn_contexts`

    import_mylyn_contexts ../data/bugs.eclipse.org/mylyn-context-20160110-1827/71687.xml --stat
    import_mylyn_contexts ../data/bugs.eclipse.org/mylyn-context-20160110-1827/71687.xml

## Utilities

#### `lsxml`

    lsxml ../data/bugs.eclipse.org/mylyn-context-20160110-1827/71687.xml

#### `dbstat`

    dbstat

#### `hist`

    hist ../data/extise.fiit.stuba.sk/extise_development-bugs_eclipse_org-20160113_all-with-mylyn-context-20160110-1824.warnings
    hist -e '[1,2,1]'
    echo 1\n2\n1 | hist
    echo [1,2,1] | hist -e

#### `rhist`

    rhist BugsEclipseOrg::Bug priority'
    rhist -e 'BugsEclipseOrg::Bug.pluck(:priority)'

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin new-feature`)
5. Create new Pull Request

## License

This software is released under the [MIT License](LICENSE.md)

# Extise

A collection of tools to estimate developers' expertise

## Requirements

- Ruby 2.2.3
- PostgreSQL 9.4.5

- Java 1.7
- Eclipse 4.3
- JDT 3.8
- EGit 2.2
- Maven 3.2
- Tycho 0.20

## Structure

    bin             Runnable commands and utilities
    db              Database configuration and migrations
    docs            Generated and other documentation
    lib             Libraries along binary dependencies
      ecmo          Eclipse bugs and Mylyn context model
      exmo          Expertise model of developers
      exrec         Database access and model bindings
      extise        Java DOM manipulation, IR utilities and SW metrics
    log             Log files
    spec            RSpec test suite
    tmp             Temporary files

## Usage

    bin/fetch_mylyn_contexts ../data/bugs.eclipse.org/all-with-mylyn-context-20151020-201230.xml
    bin/lsxml -s ../data/bugs.eclipse.org/ajdt-with-mylyn-context-20151020-214105.xml

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin new-feature`)
5. Create new Pull Request

## License

This software is released under the [MIT License](LICENSE.md)

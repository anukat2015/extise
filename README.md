# Extise

A collection of tools to estimate developers' expertise

## Requirements

- Java 1.7
- Eclipse 4.3
- JDT 3.8
- EGit 2.2
- Maven 3.2
- Tycho 0.20

## Usage

```
bin/fetch_mylyn_contexts ../data/bugs.eclipse.org/all-with-mylyn-context-20151020-201230.xml
bin/lsxml -s ../data/bugs.eclipse.org/ajdt-with-mylyn-context-20151020-214105.xml
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin new-feature`)
5. Create new Pull Request

## License

This software is released under the [MIT License](LICENSE.md)

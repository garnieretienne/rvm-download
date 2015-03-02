# rvm-download

rvm-download is an [rbenv](https://github.com/sstephenson/rbenv) plugin that provides an `rbenv download` command to download and extract ruby binaries from the [RVM binaries repository](https://rvm.io/binaries/).

## Installation

`git clone https://github.com/garnieretienne/rvm-download.git ~/.rbenv/plugins/rvm-download`

## Usage

`Usage: rbenv download <ruby-version>`

Example: downloading ruby 2.1.0:
```
vagrant@precise64:~$ rbenv download 2.1.0
Download and extract ruby 2.1.0 from RVM repository
Ruby 2.1.0 has been installed
```

Example: trying to download a missing package
```
vagrant@precise64:~$ rbenv download 1.8.2
Download and extract ruby 1.8.2 from RVM repository
http://rvm.io/binaries/ubuntu/12.04/x86_64/ruby-1.8.2.tar.bz2 cannot be reached
Cannot found a built version of ruby '1.8.2' compiled for your current system: Ubuntu x86_64 (12.04)
```

Example: trying to install from a different URL
```
vagrant@precise64:~$ RVM_BINARIES_BASE=https://internal.example.com/rubies rbenv download 1.8.2
Download and extract ruby 1.8.2 from RVM repository
https://internal.example.com/rubies/ubuntu/12.04/x86_64/ruby-1.8.2.tar.bz2 cannot be reached
Cannot found a built version of ruby '1.8.2' compiled for your current system: Ubuntu x86_64 (12.04)
```

## Troubleshooting

###  It seems your ruby installation is missing psych (for YAML output)

```
It seems your ruby installation is missing psych (for YAML output).
To eliminate this warning, please install libyaml and reinstall your ruby.
```

Install the `libyaml` package available on your distribution. (`libyaml-0-2` on Ubuntu)



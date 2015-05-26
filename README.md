# rvm-download

rvm-download is an [rbenv](https://github.com/sstephenson/rbenv) plugin that provides an `rbenv download` command to download and extract ruby binaries from the [RVM binaries repository](https://rvm.io/binaries/).

## Installation

```console
$ git clone https://github.com/garnieretienne/rvm-download.git ~/.rbenv/plugins/rvm-download
```

## Usage

```console
$ rbenv download <ruby-version>
```

Example: downloading ruby 2.1.0:

```console
$ rbenv download 2.1.0
Download and extract ruby 2.1.0 from RVM repository
Ruby 2.1.0 has been installed
```

Example: trying to download a missing package

```console
$ rbenv download 1.8.2
Download and extract ruby 1.8.2 from RVM repository
http://rvm.io/binaries/ubuntu/12.04/x86_64/ruby-1.8.2.tar.bz2 cannot be reached
Cannot found a built version of ruby '1.8.2' compiled for your current system: Ubuntu x86_64 (12.04)
```

Example: trying to install from a different URL

```console
$ RVM_BINARIES_BASE=https://internal.example.com/rubies rbenv download 1.8.2
Download and extract ruby 1.8.2 from RVM repository
https://internal.example.com/rubies/ubuntu/12.04/x86_64/ruby-1.8.2.tar.bz2 cannot be reached
Cannot found a built version of ruby '1.8.2' compiled for your current system: Ubuntu x86_64 (12.04)
```

Example: installing Rubinus 2.5.2

```console
$ rbenv download rbx-2.5.2
Download and extract rubinius 2.5.2 from the RVM repository
Rubinius 2.5.2 has been installed
```

Example: listing all ruby binaries available in the RVM repository for the current platform

_Rubinus version are not listed here. To view available rubinus version, use this address: http://rubini.us/downloads/_

```console
$ rbenv --list
ruby-1.9.3-p547
ruby-1.9.3-p551
ruby-2.0.0-p353
ruby-2.0.0-p481
ruby-2.0.0-p576
ruby-2.0.0-p598
ruby-2.1.0
ruby-2.1.2
ruby-2.1.3
ruby-2.1.5
ruby-2.2.0
ruby-2.2.1
```

## Troubleshooting

###  It seems your ruby installation is missing psych (for YAML output)

```
It seems your ruby installation is missing psych (for YAML output).
To eliminate this warning, please install libyaml and reinstall your ruby.
```

Install the `libyaml` package available on your distribution. (`libyaml-0-2` on Ubuntu)

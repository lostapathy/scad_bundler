# scad_bundler

scad_bundler is a package manager for [OpenSCAD](http://openscad.org).  It's based on [RubyGems](https://rubygems.org) and uses [Bundler](https://bundler.io) under the hood.

scad_bundler is a fully-featured package manager that:

* downloads and installs OpenSCAD libraries needed by your project
* resolves compatible versions of dependencies of your libraries
* modifies environment variables to tell OpenSCAD where to find your libraries
* is capable of downloading libraries directly GitHub, off rubygems.org, from a private repository, or local files on your computer

## Installation

You will need to have Ruby and RubyGems installed to use scad_bundler.

Once RubyGems is installed, install `scad_bundler`:

    $ gem install scad_bundler

## Usage

See [this repo](https://github.com/lostapathy/scad_bundler_example) for an example project using scad_bundler.


Similar to how bundler works, scad_bundler dependencies are defined in a Scadfile and resolved versions are locked in a Scadfile.lock.  To initialize your project and create and empty `Scadfile`

    $ scad_bundle init

Dependencies can be declared inside your `scadfile` using bundler's [full capabilities](https://bundler.io/gemfile.html) for a Gemfile.  FIXME: add a simple example, and go into how version constraints work.

Once your dependencies have been listed, you can install them via:

    $ scad_bundle install

scad_bundler will then work out compatible versions of the libraries and install them on your system.  Then to fire up OpenSCAD:

    $ scad_bundle exec openscad

scad_bundler will then start `openscad` with the `OPENSCADPATH` environment set properly to use all of your libraries.

To upgrade libraries, simple call:

    $ scad_bundle update

## Conventions and Best Practices for creating OpenSCAD Libraries

scad_bundler packages are packaged using a subset of features from [RubyGems](https://rubygems.org).  Any documentation related to RubyGems can be used to create these libraries.  Since we only use a subset of the functionality, it's probably easiest to copy the .gemspec file from an existing library like [openscad_soften](https://github.com/lostapathy/openscad-libs/tree/master/openscad_soften) and modify from there.  TODO: create a simple command like `scad_bundle new` to create a skeleton file.

Your package do not have to be published to rubygems.org in order to use them with scad_bundler.  scad_bundler can also use packages from GitHub, local filesystem locations, or anywhere else [supported by bundler](http://bundler.io/gemfile.html).

### (Draft) Conventions

* All packages pushed to RubyGems should have the name prefaced by openscad_, i.e., `openscad_soften`
* All .scad files in your package should be placed in a subdirectory, but it need not match the library name.  To use them, you'll use/include them such as `use <soften/cube.scad`
* Libraries should be built such that users will import them via `use` rather than `include` whenever possible.
* Only place "public" modules/functions/variables that go together in each .scad file that is meant to be included by the user.  Separate "private" modules/functions/variables in separate .scad files to be included from the "public" file.  This minimizes the possibilities of namespace collisions with user code.
* Limit the amount of modules/functions/variables in each "public" scad file to a minimum.  This allows the user to import only those modules/functions/variables that they need into their namespace.

## Motivation

The motivation for scad_bundler is simple - create a first-class package manager for OpenSCAD to help advance the entire OpenSCAD ecosystem.

Having a package manager is an essential feature of modern languages, and OpenSCAD should be no different. A really solid package manager will allow us to build up components and utilities to simplify designs, so that users need not choose between starting at zero and manually wrangling files from Thingiverse.  Having this base of knowledge will also help the OpenSCAD community to better identify and codify best practices for sharing code and designing models.

That package manager needs to support versioning and version constraints, so that packages can evolve over time and ship breaking changes rather than stagnate on the first API to coalesce.

Many OpenSCAD project sit dormant for a long time, then get revisited to fix or upgrade a part.  Because of this, it's important that scad_bundler tracks library versions per-project, and different projects on your system can use different library versions.  This removes the need to incorporate every library change into your project. This means we're free to improve and evolve our libraries over time, without worry about breaking existing code - that existing code can continue to use the same version of the library until we're ready to upgrade it.

It is my hope that building this knowledge base will also help the community hash out common problems "in userspace" either completely or substantially, so that the scope of changes proposed for OpenSCAD itself can be smaller, more focused, and better tested than many proposals that come up now.


## FAQ

#### Why build on RubyGems and bundler?

RubyGems and bundler are a very stable base to build upon, and include very advanced support for specifying compatible library versions and then resolving those dependencies.  Using this foundation is much more expedient than starting from scratch.

#### Why host openscad packages on rubygems.org?

Hosting a package repository is *hard* work and very security intensive. Using another open source project's repository get us going from day one, and frees us from all of the infrastructure and security headaches hosting our own would entail.  If you don't want to post your package as a gem on rubygems.org, it's perfectly fine to post it on github and direct people to use that.  Long term, it would be ideal to host a separate package repository but there's nothing wrong with starting out like this.

#### Why pass library information via an environment variable?

The initial goal of scad_bundler was to create a package manager that worked without requiring any modifications to OpenSCAD.  Long-term, we would love to integrate more tightly with OpenSCAD, but this absolutely works for now.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/lostapathy/scad_bundler.

## TODO

* Better docs on how to package a new library
* Completely abstract away the fact that this is ruby-based over the long-term.
* Change the 'gem' declaration in Scadfile to something that isn't a ruby-centric.
* Decouple us from the 'gemspec' format.  In a perfect world, we'd have our own simplified package format that generated all the extra stuff RubyGems needs but scad_bundler does not.  It would also apply some conventions and best practices to the libraries to make other goals easier to accomplish.
* Long term, create an alternate package repository from RubyGems.org that only lists OpenSCAD packages and adds functionality more applicable to 3d modeling.
* Figure out a cleaner way to integrate this with OpenSCAD than just setting an environment variable on OpenSCAD startup.
* Better define what features we could add to OpenSCAD to better support libraries (i.e., namespacing support).
* Provide a hook in the library spec to specify a minimum OpenSCAD version compatible with the library.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

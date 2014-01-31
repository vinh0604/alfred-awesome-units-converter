# -*- encoding: utf-8 -*-
# stub: ruby-units 1.4.4 ruby lib

Gem::Specification.new do |s|
  s.name = "ruby-units"
  s.version = "1.4.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Kevin Olbrich, Ph.D."]
  s.date = "2013-07-19"
  s.description = "Provides classes and methods to perform unit math and conversions"
  s.email = ["kevin.olbrich+ruby_units@gmail.com"]
  s.extra_rdoc_files = ["LICENSE.txt", "README.md", "TODO"]
  s.files = ["LICENSE.txt", "README.md", "TODO"]
  s.homepage = "https://github.com/olbrich/ruby-units"
  s.licenses = ["MIT"]
  s.post_install_message = "====================\nDeprecation Warning\n====================\n\nSeveral convenience methods that ruby-units added to the string class have\nbeen deprecated in this release.  These methods include String#to, String#from, String#ago, String#before and others.\nIf your code relies on these functions, they can be added back by adding this line to your code.\n\nrequire 'ruby-units/string/extras'\n# note that these methods do not play well with Rails, which is one of the reasons they are being removed.\n\nThe extra functions mostly work the same, but will no longer properly handle cases when they are called with strings..\n\n'min'.from(\"4-1-2011\") # => Exception\n\nPass in a Date, Time, or DateTime object to get the expected result.\n\nThey will go away completely in the next release, so it would be a good idea to refactor your code\nto avoid using them.  They will also throw deprecation warnings when they are used.\n"
  s.require_paths = ["lib"]
  s.rubygems_version = "2.1.9"
  s.summary = "A class that performs unit conversions and unit math"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>, ["~> 1.0"])
      s.add_development_dependency(%q<jeweler>, [">= 0"])
    else
      s.add_dependency(%q<bundler>, ["~> 1.0"])
      s.add_dependency(%q<jeweler>, [">= 0"])
    end
  else
    s.add_dependency(%q<bundler>, ["~> 1.0"])
    s.add_dependency(%q<jeweler>, [">= 0"])
  end
end
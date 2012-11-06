This library provides external validations for any Ruby class.

It originates from [emmanuels aequitas repository](https://github.com/emmanuel/aequitas) 
with the following changes:

* Only support for external validators
* No contextual validators anymore (use additional external validators)
* Use dkubb/equalizer and dkubb/adamantium where possible.

Once these changes are mature they will hopefully be accepted and used as the base for a release.

## Specifying Validations

There are two primary ways to implement validations

1) Placing validation methods with properties as params in your class


```ruby
require 'aequitas'

class ProgrammingLanguage
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

class ProgrammingLanguageValidator
  include Aequitas

  attr_accessor :name

  validates_presence_of :name
end

ruby = ProrammingLanguage.new('ruby')

validator = ProgrammingLanguageValidator.new(ruby)
validator.valid? # => true
validator.errors # => []

other = ProrammingLanguage.new('')

validator = ProgrammingLanguageValidator.new(other)
validator.valid? # => false
validator.errors # => [<Aequitas::Rule::Violation ....>]

```

2) (TODO) Using inferred validations on Virtus attributes, please see Aequitas::Inferred.
Note that not all validations that are provided via validation methods,
are also available as autovalidation options. If they are available,
they're functionally equivalent though.

This functionallity is broken ATM.

```ruby
class ProgrammingLanguage
  include Virtus
  include Aequitas

  attribute :name, String, :required => true
end
```

See Aequitas::Macros to learn about the complete collection of validation rules available.

## Validating

Aequitas validations may be manually evaluated against a resource using the
`#valid?` method, which will return true if the resource is valid,
and false if it is invalid.

## Working with Validation Errors

If an instance fails one or more validation rules, Aequitas::Violation instances
will populate the Aequitas::ViolationSet object that is available through
the #errors method.

For example:

```ruby
validator = AccountValidator.new(Account.new(:name => "Jose"))
if validator.valid?
  # my_account is valid and can be saved
else
  validator.errors.each do |e|
    puts e
  end
end
```

See Aequitas::ViolationSet for all you can do with the #errors method.

##Contextual Validation

Aequitas does not provide a means of grouping your validations into
contexts. Define a external validator per context for this. 

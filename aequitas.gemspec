# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "aequitas/version"

Gem::Specification.new do |s|
  s.name        = "aequitas"
  s.version     = Aequitas::VERSION
  s.authors     = ["Emmanuel Gomez"]
  s.email       = ["emmanuel.gomez@gmail.com"]
  s.homepage    = "https://github.com/emmanuel/aequitas"
  s.summary     = %q{Library for performing validations on Ruby objects.}
  s.description = %q{Library for validating Ruby objects with rich metadata support.}

  # git ls-files
  s.files       = %w[
    Gemfile
    LICENSE
    README.rdoc
    Rakefile
    VERSION
    lib/aequitas.rb
    lib/aequitas/class_methods.rb
    lib/aequitas/context.rb
    lib/aequitas/contextual_rule_set.rb
    lib/aequitas/exceptions.rb
    lib/aequitas/macros.rb
    lib/aequitas/message_transformer.rb
    lib/aequitas/rule.rb
    lib/aequitas/rule/absence.rb
    lib/aequitas/rule/absence/blank.rb
    lib/aequitas/rule/absence/nil.rb
    lib/aequitas/rule/acceptance.rb
    lib/aequitas/rule/block.rb
    lib/aequitas/rule/confirmation.rb
    lib/aequitas/rule/format.rb
    lib/aequitas/rule/format/email_address.rb
    lib/aequitas/rule/format/proc.rb
    lib/aequitas/rule/format/regexp.rb
    lib/aequitas/rule/format/url.rb
    lib/aequitas/rule/guard.rb
    lib/aequitas/rule/length.rb
    lib/aequitas/rule/length/equal.rb
    lib/aequitas/rule/length/maximum.rb
    lib/aequitas/rule/length/minimum.rb
    lib/aequitas/rule/length/range.rb
    lib/aequitas/rule/method.rb
    lib/aequitas/rule/numericalness.rb
    lib/aequitas/rule/numericalness/integer.rb
    lib/aequitas/rule/numericalness/non_integer.rb
    lib/aequitas/rule/presence.rb
    lib/aequitas/rule/presence/not_blank.rb
    lib/aequitas/rule/presence/not_nil.rb
    lib/aequitas/rule/primitive_type.rb
    lib/aequitas/rule/primitive_type/virtus.rb
    lib/aequitas/rule/skip_condition.rb
    lib/aequitas/rule/value.rb
    lib/aequitas/rule/value/equal.rb
    lib/aequitas/rule/value/greater_than.rb
    lib/aequitas/rule/value/greater_than_or_equal.rb
    lib/aequitas/rule/value/less_than.rb
    lib/aequitas/rule/value/less_than_or_equal.rb
    lib/aequitas/rule/value/not_equal.rb
    lib/aequitas/rule/value/range.rb
    lib/aequitas/rule/within.rb
    lib/aequitas/rule_set.rb
    lib/aequitas/support/blank.rb
    lib/aequitas/support/ordered_hash.rb
    lib/aequitas/support/value_object.rb
    lib/aequitas/version.rb
    lib/aequitas/violation.rb
    lib/aequitas/violation_set.rb
    lib/aequitas/virtus_integration.rb
    lib/aequitas/virtus_integration/inline_attribute_rule_extractor.rb
    lib/aequitas/virtus_integration/inline_attribute_rule_extractor/array.rb
    lib/aequitas/virtus_integration/inline_attribute_rule_extractor/boolean.rb
    lib/aequitas/virtus_integration/inline_attribute_rule_extractor/numeric.rb
    lib/aequitas/virtus_integration/inline_attribute_rule_extractor/object.rb
    lib/aequitas/virtus_integration/inline_attribute_rule_extractor/string.rb
    spec/integration/aequitas/macros/validates_absence_of_spec.rb
    spec/integration/aequitas/macros/validates_acceptance_of_spec.rb
    spec/integration/aequitas/macros/validates_confirmation_of_spec.rb
    spec/integration/aequitas/macros/validates_format_of_spec.rb
    spec/integration/aequitas/macros/validates_length_of.rb
    spec/integration/aequitas/macros/validates_numericalness_of_spec.rb
    spec/integration/aequitas/macros/validates_presence_of_spec.rb
    spec/integration/aequitas/macros/validates_value_of_spec.rb
    spec/integration/aequitas/macros/validates_with_block.rb
    spec/integration/aequitas/macros/validates_with_method.rb
    spec/integration/aequitas/macros/validates_within.rb
    spec/integration/shared/macros/integration_spec.rb
    spec/integration/virtus/array/length/equal_spec.rb
    spec/integration/virtus/array/length/range_spec.rb
    spec/integration/virtus/boolean/presence_spec.rb
    spec/integration/virtus/integer/value/equal_to_spec.rb
    spec/integration/virtus/integer/value/greater_than_or_equal.rb
    spec/integration/virtus/integer/value/greater_than_spec.rb
    spec/integration/virtus/integer/value/less_than_or_equal.rb
    spec/integration/virtus/integer/value/less_than_spec.rb
    spec/integration/virtus/integer/value/not_equal_to_spec.rb
    spec/integration/virtus/string/format/email_address_spec.rb
    spec/integration/virtus/string/format/regexp_spec.rb
    spec/integration/virtus/string/format/url_spec.rb
    spec/integration/virtus/string/length/equal_spec.rb
    spec/integration/virtus/string/length/range_spec.rb
    spec/integration/virtus/string/presence_spec.rb
    spec/spec_helper.rb
    spec/suite.rb
    spec/unit/aequitas/rule/absence/blank_spec.rb
    spec/unit/aequitas/rule/acceptance_spec.rb
    spec/unit/aequitas/rule/confirmation_spec.rb
    spec/unit/aequitas/rule/guard_spec.rb
    spec/unit/aequitas/rule/skip_condition_spec.rb
    spec/unit/aequitas/rule_spec.rb
    spec/unit/aequitas/support/blank_spec.rb
    spec/unit/aequitas/support/value_object/equalizer_spec.rb
    spec/unit/aequitas/support/value_object_spec.rb
    spec/unit/aequitas/violation_set_spec.rb
  ]
  # git ls-files -- {test,spec,features}/*
  s.test_files    = %w[
    spec/integration/aequitas/macros/validates_absence_of_spec.rb
    spec/integration/aequitas/macros/validates_acceptance_of_spec.rb
    spec/integration/aequitas/macros/validates_confirmation_of_spec.rb
    spec/integration/aequitas/macros/validates_format_of_spec.rb
    spec/integration/aequitas/macros/validates_length_of.rb
    spec/integration/aequitas/macros/validates_numericalness_of_spec.rb
    spec/integration/aequitas/macros/validates_presence_of_spec.rb
    spec/integration/aequitas/macros/validates_value_of_spec.rb
    spec/integration/aequitas/macros/validates_with_block.rb
    spec/integration/aequitas/macros/validates_with_method.rb
    spec/integration/aequitas/macros/validates_within.rb
    spec/integration/shared/macros/integration_spec.rb
    spec/integration/virtus/array/length/equal_spec.rb
    spec/integration/virtus/array/length/range_spec.rb
    spec/integration/virtus/boolean/presence_spec.rb
    spec/integration/virtus/integer/value/equal_to_spec.rb
    spec/integration/virtus/integer/value/greater_than_or_equal.rb
    spec/integration/virtus/integer/value/greater_than_spec.rb
    spec/integration/virtus/integer/value/less_than_or_equal.rb
    spec/integration/virtus/integer/value/less_than_spec.rb
    spec/integration/virtus/integer/value/not_equal_to_spec.rb
    spec/integration/virtus/string/format/email_address_spec.rb
    spec/integration/virtus/string/format/regexp_spec.rb
    spec/integration/virtus/string/format/url_spec.rb
    spec/integration/virtus/string/length/equal_spec.rb
    spec/integration/virtus/string/length/range_spec.rb
    spec/integration/virtus/string/presence_spec.rb
    spec/rcov.opts
    spec/spec_helper.rb
    spec/suite.rb
    spec/unit/aequitas/rule/absence/blank_spec.rb
    spec/unit/aequitas/rule/acceptance_spec.rb
    spec/unit/aequitas/rule/confirmation_spec.rb
    spec/unit/aequitas/rule/guard_spec.rb
    spec/unit/aequitas/rule/skip_condition_spec.rb
    spec/unit/aequitas/rule_spec.rb
    spec/unit/aequitas/support/blank_spec.rb
    spec/unit/aequitas/support/value_object/equalizer_spec.rb
    spec/unit/aequitas/support/value_object_spec.rb
    spec/unit/aequitas/violation_set_spec.rb
  ]
  # `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.executables   = []
  s.require_paths = ["lib"]

  s.add_development_dependency("minitest", ["~> 2.8"])
  s.add_development_dependency("virtus",   ["~> 0.2.0"])
  s.add_development_dependency("dm-core",  ["~> 1.3.0"])
end

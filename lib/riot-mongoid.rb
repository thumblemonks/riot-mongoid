require 'riot'
require 'mongoid'

Mongoid::Field.module_eval do
  attr_reader :accessible
end

module RiotMongoid
  autoload :HasAssociationAssertion, "riot-mongoid/has_association"
  autoload :HasValidationAssertion, "riot-mongoid/has_validation"
  autoload :HasFieldAssertion, "riot-mongoid/has_field"
end
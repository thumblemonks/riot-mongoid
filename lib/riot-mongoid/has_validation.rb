module RiotMongoid
  class HasValidationAssertion < Riot::AssertionMacro
    register :has_validation

    def evaluate(model, *validation_macro_info)
      validation_type, validation_name, options = validation_macro_info
      validation = model.send(:all_validations).detect do |valid|
        valid.key =~ %r{#{validation_type.to_s.camelize}} and valid.attribute == validation_name
      end
      options ||= {}
      case
      when validation_name.nil? || validation_type.nil?
        fail("validation name, type and potential options must be specified with this assertion macro")
      when validation.nil?
        fail("expected #{model} to have validation on #{validation_name} of type #{validation_type}")
      else
        options_valid = options.all? { |key,value| validation.send(key) == value }
        options_valid ? pass("#{model} has '#{validation_type}' validation '#{validation_name}' with options #{options.inspect}") :
                        fail("expected #{model} to have options #{options.inspect} on validation #{validation_type}")
      end
    end
  end
end

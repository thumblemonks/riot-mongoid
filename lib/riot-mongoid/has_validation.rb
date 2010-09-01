module RiotMongoid
  class HasValidationAssertion < Riot::AssertionMacro
    register :has_validation

    def evaluate(model, *validation_macro_info)
      validation_type, validation_field, options = validation_macro_info
      type = validation_type.to_s
      %w{validates_ _of}.each { |part| type.gsub!(%r{#{part}},'') }
      validation = model._validators[validation_field].detect do |valid|
        valid.class.name =~ %r{#{type.capitalize}}
      end
      options ||= {}
      case
      when validation_field.nil? || validation_type.nil?
        fail("validation field, type and potential options must be specified with this assertion macro")
      when validation.nil?
        fail("expected #{model} to have validation on #{validation_field} of type #{validation_type}")
      when (validation.class.name =~ %r{Length} and options.any?)
        range = options[:within].to_a
        if (validation.options[:minimum] == range.first) and (validation.options[:maximum] == range.last)
          pass("#{model} has '#{validation_type}' validation '#{validation_field}' with options #{options.inspect}")
        else
          fail("expected #{model} to have options #{options.inspect} on validation #{validation_type}")
        end
      else
        options_valid = options.all? { |key,value| validation.options[key] == value }
        if options_valid
          pass("#{model} has '#{validation_type}' validation '#{validation_field}' with options #{options.inspect}")
        else
          fail("expected #{model} to have options #{options.inspect} on validation #{validation_type}")
        end
      end
    end
  end
end

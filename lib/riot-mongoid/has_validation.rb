module RiotMongoid
  class HasValidationAssertion < Riot::AssertionMacro
    register :has_validation

    def evaluate(model, type, field, options = {})
      fail_msg = "expected #{model.class.to_s} to have validation '#{type} :#{field}'"
      pass_msg = "#{model.class.to_s} has validation '#{type} :#{field}'"
      opt_msg  = " with options #{options.inspect}"

      type = type.to_s.match(/validates_(.*)_of/)[1] rescue type.to_s

      validation = model._validators[field].detect { |v| v.class.name =~ /#{type.camelize}/ }

      return fail(fail_msg) if validation.nil?

      # special case to check for validates_length_of :within option
      if validation.class.name =~ %r{Length} and options[:within]
        range = options[:within].to_a
        if (validation.options[:minimum] == range.first) and (validation.options[:maximum] == range.last)
          return pass(pass_msg + opt_msg)
        else
          return fail(fail_msg + opt_msg)
        end
      end

      unless options.empty?
        return fail(fail_msg + opt_msg) unless options.all? { |k,v| validation.options[k] == v }
        return pass(pass_msg + opt_msg)
      end

      pass pass_msg
    end
  end
end

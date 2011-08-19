module RiotMongoid
  class HasAssociationAssertion < Riot::AssertionMacro
    register :has_association

    def evaluate(model, type, field, options = {})
      fail_msg = "expected #{model.class.to_s} to have assocation '#{type} :#{field}'"
      pass_msg = "#{model.class.to_s} has association '#{type} :#{field}'"
      opt_msg  = " with options #{options.inspect}"
      assoc    = model.relations[field.to_s]

      return fail(fail_msg) if assoc.nil? || assoc.macro != type.to_sym

      unless options.empty?
        return fail(fail_msg + opt_msg) unless options.all? { |k, v| assoc.send(k) == v }
        return pass(pass_msg + opt_msg)
      end

      pass pass_msg
    end
  end
end

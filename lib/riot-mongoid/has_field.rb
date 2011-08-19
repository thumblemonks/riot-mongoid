module RiotMongoid
  class HasFieldAssertion < Riot::AssertionMacro
    register :has_field

    def evaluate(model, field_name, options = {})
      fail_msg = "expected #{model.class.to_s} to have field :#{field_name}"
      pass_msg = "#{model.class.to_s} has field :#{field_name}"
      opt_msg  = " with options #{options.inspect}"
      field    = model.fields[field_name.to_s]

      return fail(fail_msg) if field.nil?

      unless options.empty?
        return fail(fail_msg + opt_msg) unless options.all? { |k,v| field.send(k) == v }
        return pass(pass_msg + opt_msg)
      end

      pass pass_msg
    end
  end
end

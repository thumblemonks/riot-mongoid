module RiotMongoid
  class HasFieldAssertion < Riot::AssertionMacro
    register :has_field

    def evaluate(model, *macro_info)
      field_name, options = macro_info
      field = model.fields[field_name.to_s]
      if options.nil? || options.empty?
        fail("field options must be specified with this assertion macro")
      elsif field.nil?
        fail("expected #{model} to have field #{field_name}")
      else
        options_valid = options.all? { |key,value| field.send(key) == value }
        options_valid ? pass("#{model} has field '#{field_name}' with options #{options.inspect}") :
                        fail("expected model to have options #{options.inspect} on field #{field_name}")
      end
    end
  end # HasFieldAssertion
end   # RiotMongoid
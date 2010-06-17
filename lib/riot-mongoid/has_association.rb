module RiotMongoid
  class HasAssociationAssertion < Riot::AssertionMacro
    register :has_association

    def evaluate(model, *association_macro_info)
      assoc_type, assoc_name, options = association_macro_info
      assoc = model.associations[assoc_name.to_s]
      options ||= {}
      if assoc_name.nil?
        fail("association name and potential options must be specified with this assertion macro")
      elsif assoc.nil? || assoc.macro != assoc_type.to_sym
        fail("expected #{model} to have association #{assoc_name} of type #{assoc_type}")
      else
        options_valid = options.all? { |key,value| assoc.options.instance_variable_get("@attributes")[key] == value }
        options_valid ? pass("#{model} has '#{assoc_type}' association '#{assoc_name}' with options #{options.inspect}") :
                        fail("expected model to have options #{options.inspect} on association #{assoc_name}")
      end
    end
  end
end
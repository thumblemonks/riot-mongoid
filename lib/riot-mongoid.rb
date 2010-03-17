require 'riot'

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
        options_valid = options.all? { |key,value| assoc.send(key) == value }
        options_valid ? pass("#{model} has '#{assoc_type}' association '#{assoc_name}' with options #{options.inspect}") :
                        fail("expected model to have options #{options.inspect} on association #{assoc_name}")
      end
    end
  end # HasAssociationAssertion
end   # RiotMongoid
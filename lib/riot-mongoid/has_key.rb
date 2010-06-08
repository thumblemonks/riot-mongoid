module RiotMongoid
  class HasKeyAssertion < Riot::AssertionMacro
    register :has_key

    def evaluate(model, *key_macro_info)
      valid = key_macro_info == model.primary_key
      case
      when key_macro_info.nil?
        fail("keys must be specified with this assertion macro")
      else
        key = key_macro_info.join('-')
        valid ? pass("#{model} has key #{key}") : fail("expected #{model} to have key #{key}")
      end
    end
  end
end

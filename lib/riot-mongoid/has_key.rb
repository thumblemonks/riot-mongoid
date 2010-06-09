module RiotMongoid
  class HasKeyAssertion < Riot::AssertionMacro
    register :has_key

    def evaluate(model, *key_macro_info)
      if key_macro_info.nil?
        fail("keys must be specified with this assertion macro")
      else
        valid = key_macro_info == model.primary_key
        key = key_macro_info.join('-')
        valid ? pass("#{model} has key #{key}") : fail("expected #{model} to have key #{key}")
      end
    end
  end
end

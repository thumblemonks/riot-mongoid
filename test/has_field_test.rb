require File.join(File.dirname(__FILE__),'teststrap')

context "has_field macro" do
  setup do
    mock_model do
      field :name, :type => String
      field :rad,  :type => Boolean, :default => false
    end
  end
  asserts "passes when the field options are specified" do
    RiotMongoid::HasFieldAssertion.new.evaluate(topic, :name, :type => String).first
  end.equals(:pass)

  asserts "returns useful message" do
    RiotMongoid::HasFieldAssertion.new.evaluate(topic, :name, :type => String).last
  end.matches(/has field 'name' with options \{:type=>String\}/)

  asserts "fails when invalid field options are specified" do
    RiotMongoid::HasFieldAssertion.new.evaluate(topic, :name, :type => Date).first
  end.equals(:fail)

  asserts "passes with a slightly more complex field setup" do
    RiotMongoid::HasFieldAssertion.new.evaluate(topic, :rad, :type => Boolean, :default => false).first
  end.equals(:pass)

  asserts "fails with a slightly more complex field setup and a bad assertion" do
    RiotMongoid::HasFieldAssertion.new.evaluate(topic, :rad, :type => Boolean, :default => true).first
  end.equals(:fail)
end

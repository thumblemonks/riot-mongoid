require File.join(File.dirname(__FILE__),'teststrap')

context "has_validation macro" do
  setup do
    mock_model do
      field :name, :type => String
      field :rad,  :type => Boolean, :default => false
      field :surname, :type => String

      validates_presence_of :name, :surname
      validates_length_of :surname, :within => 4..40
      validates_uniqueness_of :rad
    end
  end

  asserts "passes when the validation is specified" do
    RiotMongoid::HasValidationAssertion.new.evaluate(topic, :validates_presence_of, :name).first
  end.equals(:pass)

  asserts "passes when the validation is specified" do
    RiotMongoid::HasValidationAssertion.new.evaluate(topic, :validates_presence_of, :surname).first
  end.equals(:pass)

  asserts "returns useful message" do
    RiotMongoid::HasValidationAssertion.new.evaluate(topic, :validates_presence_of, :name).last
  end.matches(/has 'validates_presence_of' validation 'name'/)

  asserts "passes when the validation options is specified" do
    RiotMongoid::HasValidationAssertion.new.evaluate(topic, :validates_length_of, :surname, :within => 4..40).last
  end

  asserts "fails when invalid field options are specified" do
    RiotMongoid::HasValidationAssertion.new.evaluate(topic, :validates_length_of, :type => Date).first
  end.equals(:fail)

  asserts "passes when another validation is specified" do
    RiotMongoid::HasValidationAssertion.new.evaluate(topic, :validates_uniqueness_of, :rad).first
  end.equals(:pass)
end

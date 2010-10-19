require File.join(File.dirname(__FILE__),'teststrap')

context "has_validation macro" do
  setup do
    mock_model do
      field :name,    :type => String
      field :rad,     :type => Boolean, :default => false
      field :surname, :type => String
      field :caption, :type => String
      field :role,    :with => /[A-Za-z]/

      validates_presence_of   :name,     :surname
      validates_length_of     :surname,  :within  => 4..40
      validates_length_of     :caption,  :minimum => 2
      validates_format_of     :role,     :with    => /[A-Za-z]/
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

  asserts "passes when the validation options is specified using within" do
    RiotMongoid::HasValidationAssertion.new.evaluate(topic, :validates_length_of, :surname, :within => 4..40).first
  end.equals(:pass)

  asserts "passes when validation_length_of has an option" do 
    RiotMongoid::HasValidationAssertion.new.evaluate(topic, :validates_length_of, :caption, :minimum => 2).first
  end.equals(:pass)

  asserts "passes when the validation options is specified" do
    RiotMongoid::HasValidationAssertion.new.evaluate(topic, :validates_format_of, :role, :with => /[A-Za-z]/).first
  end.equals(:pass)
  
  asserts "passes when the validation options is specified and doesn't match" do
    RiotMongoid::HasValidationAssertion.new.evaluate(topic, :validates_format_of, :role, :with => //).first
  end.equals(:fail)

  asserts "fails when invalid field options are specified" do
    RiotMongoid::HasValidationAssertion.new.evaluate(topic, :validates_length_of, :name, :type => Date).first
  end.equals(:fail)

  asserts "passes when another validation is specified" do
    RiotMongoid::HasValidationAssertion.new.evaluate(topic, :validates_uniqueness_of, :rad).first
  end.equals(:pass)
end

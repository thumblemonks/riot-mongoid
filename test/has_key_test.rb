require File.join(File.dirname(__FILE__),'teststrap')

context "has_key macro" do
  setup do
    mock_model do
      field :name, :type => String
      field :rad,  :type => Boolean, :default => false
      field :surname, :type => String

      key :name, :rad, :surname
    end
  end

  asserts "passes when the key is specified" do
    RiotMongoid::HasKeyAssertion.new.evaluate(topic, :name, :rad, :surname).first
  end.equals(:pass)
  
  asserts "fails when the key doesn't match" do 
    RiotMongoid::HasKeyAssertion.new.evaluate(topic, :name, :surname).first
  end.equals(:fail)
  
  asserts "returns a helpful message" do 
    RiotMongoid::HasKeyAssertion.new.evaluate(topic, :name, :rad, :surname).last
  end.matches %r{has key name-rad-surname}

end

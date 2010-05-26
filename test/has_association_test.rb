require File.join(File.dirname(__FILE__),'teststrap')

context "has_association" do
  setup do
    test = mock_model do
      embeds_many :things
      embedded_in :another_thing, :inverse_of => :word
      has_many_related :relations
    end
  end

  asserts "the macro passes when the association options are specified for a has_many" do
    RiotMongoid::HasAssociationAssertion.new.evaluate(topic, :embeds_many, :things).first
  end.equals(:pass)

  asserts "the macro passes when the association options are specified for a belongs_to" do
    RiotMongoid::HasAssociationAssertion.new.evaluate(topic, :embedded_in, :another_thing, :inverse_of => :word).first
  end.equals(:pass)

  asserts "the macro pass message is useful" do
    RiotMongoid::HasAssociationAssertion.new.evaluate(topic, :embedded_in, :another_thing, :inverse_of => :word).last
  end.matches(/has 'embedded_in' association 'another_thing' with options \{:inverse_of=>:word\}/)

  asserts "the macro passes when the association options are specified for a has_many_related" do
    RiotMongoid::HasAssociationAssertion.new.evaluate(topic, :has_many_related, :relations).first
  end.equals(:pass)

  asserts "the macro fails when no association name is specified" do
    RiotMongoid::HasAssociationAssertion.new.evaluate(topic, :has_many).first
  end.equals(:fail)

end

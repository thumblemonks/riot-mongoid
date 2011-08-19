require File.join(File.dirname(__FILE__),'teststrap')

context "has_association macro" do
  setup do
    test = mock_model do
      embeds_many :things
      embedded_in :another_thing, :inverse_of => :word
      references_many :relations, :class_name => "Relation"
    end
  end

  asserts "passes when the association options are specified for a embeds_many" do
    RiotMongoid::HasAssociationAssertion.new.evaluate(topic, :embeds_many, :things).first
  end.equals(:pass)

  asserts "passes when the association options are specified for a embedded_in" do
    RiotMongoid::HasAssociationAssertion.new.evaluate(topic, :embedded_in, :another_thing, :inverse_of => :word).first
  end.equals(:pass)

  asserts "returns useful message" do
    RiotMongoid::HasAssociationAssertion.new.evaluate(topic, :embedded_in, :another_thing, :inverse_of => :word).last
  end.matches(/Class has association 'embedded_in :another_thing' with options \{:inverse_of=>:word\}/)

  asserts "passes when the association options are specified for a references_many" do
    RiotMongoid::HasAssociationAssertion.new.evaluate(topic, :references_many, :relations, :class_name => "Relation").first
  end.equals(:pass)
end

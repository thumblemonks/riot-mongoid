require 'teststrap'

context "riot-mongoid" do

  setup do
    test_class = Class.new
    test_class.class_eval do
      include Mongoid::Document
      field :name, :type => String
      field :rad,  :type => Boolean, :default => false

      has_many :things
      belongs_to :another_thing, :inverse_of => :word
      has_many_related :relations
    end
    test_class
  end

  context "has_field" do
    asserts "the macro passes when the field options are specified" do
      RiotMongoid::HasFieldAssertion.new.evaluate(topic, :name, :type => String).first
    end.equals(:pass)

    asserts "the macro pass message is useful" do
      RiotMongoid::HasFieldAssertion.new.evaluate(topic, :name, :type => String).last
    end.matches(/has field 'name' with options \{:type=>String\}/)

    asserts "the macro fails when the field options are not specified" do
      RiotMongoid::HasFieldAssertion.new.evaluate(topic, :name).first
    end.equals(:fail)

    asserts "the macro fails when invalid field options are specified" do
      RiotMongoid::HasFieldAssertion.new.evaluate(topic, :name, :type => Date).first
    end.equals(:fail)

    asserts "the macro passes with a slightly more complex field setup" do
      RiotMongoid::HasFieldAssertion.new.evaluate(topic, :rad, :type => Boolean, :default => false).first
    end.equals(:pass)

    asserts "the macro fails with a slightly more complex field setup and a bad assertion" do
      RiotMongoid::HasFieldAssertion.new.evaluate(topic, :rad, :type => Boolean, :default => true).first
    end.equals(:fail)
  end # has_field

  context "has_association" do

    asserts "the macro passes when the association options are specified for a has_many" do
      RiotMongoid::HasAssociationAssertion.new.evaluate(topic, :has_many, :things).first
    end.equals(:pass)

    asserts "the macro passes when the association options are specified for a belongs_to" do
      RiotMongoid::HasAssociationAssertion.new.evaluate(topic, :belongs_to, :another_thing, :inverse_of => :word).first
    end.equals(:pass)

    asserts "the macro pass message is useful" do
      RiotMongoid::HasAssociationAssertion.new.evaluate(topic, :belongs_to, :another_thing, :inverse_of => :word).last
    end.matches(/has 'belongs_to' association 'another_thing' with options \{:inverse_of=>:word\}/)

    asserts "the macro passes when the association options are specified for a has_many_related" do
      RiotMongoid::HasAssociationAssertion.new.evaluate(topic, :has_many_related, :relations).first
    end.equals(:pass)

    asserts "the macro fails when no association name is specified" do
      RiotMongoid::HasAssociationAssertion.new.evaluate(topic, :has_many).first
    end.equals(:fail)

  end # has_association
end   # riot-mongoid

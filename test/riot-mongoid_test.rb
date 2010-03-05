require 'teststrap'

context "riot-mongoid" do

  setup do
    test_class = Class.new
    test_class.class_eval do
      include Mongoid::Document
      field :name, :type => String
      field :rad,  :type => Boolean, :default => false
    end
    test_class
  end

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
end

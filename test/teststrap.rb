require 'rubygems'
require 'riot'
require 'mongoid'
require File.join(File.dirname(__FILE__),'..','lib','riot-mongoid')


class Riot::Situation
  def mock_model(&block)
    mock = Class.new
    mock.class_eval { include Mongoid::Document }
    mock.class_eval(&block)
    mock
  end
end

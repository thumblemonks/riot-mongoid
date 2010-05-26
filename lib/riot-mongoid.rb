require 'riot'
require 'mongoid'

Dir[File.dirname(__FILE__) + '/riot-mongoid/*.rb'].each {|file| require file }
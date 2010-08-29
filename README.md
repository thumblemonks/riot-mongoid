# riot-mongoid

Riot assertions for Mongoid

## Examples

    context "Photo Model" do

      context 'definition' do
        setup { Photo.new }
        
        # field associations
        asserts_topic.has_field :title,       :type => String
        asserts_topic.has_field :caption,     :type => String, :default => ""

        # association assertions
        asserts_topic.has_association :belongs_to_related, :account
        asserts_topic.has_association :has_many_related, :comments
        asserts_topic.has_association :embedded_in, :person, :inverse_of => :address
        
        # validation assertions
        asserts_topic.has_validation :validates_presence_of, :caption
        
        # key assertions
        asserts_topic.has_key :title, :caption
      end
    end
    

## Mongoid 1.9.1/ Mongoid2.0.0beta+

To use riot-mongoid with Mongoid 1.9.1 do:

    gem install riot-mongoid
    
or check out the [legacy branch](http://github.com/thumblemonks/riot-mongoid/tree/legacy)
    
To use riot-mongoid with Mongoid 2.0.0.beta+ do:

    gem install riot-mongoid --pre

or check out the [master branch](http://github.com/thumblemonks/riot-mongoid)


## Note on Patches/Pull Requests
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2010 gabrielg. See LICENSE for details.

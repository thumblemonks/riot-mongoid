# riot-mongoid

Riot assertions for Mongoid

## Examples

The best way to explain is always with an example.

So given a model like:

```ruby
class Photo
  include Mongoid::Document

  field :title,   :type => String
  field :caption, :type => String, :default => ""

  referenced_in,   :account
  references_many, :comments
  embedded_in,     :customer, :class_name => "Person"

  validates_presence_of :caption

  validates :states, :inclusion_of_set => { :in => [1, 2, 3] }

  key :title, :caption
end
```

Your riot test would look something like:

```ruby
context "Photo Model" do

  context 'definition' do
    setup { Photo }

    # field associations
    asserts_topic.has_field :title,   :type => String
    asserts_topic.has_field :caption, :type => String, :default => ""

    # association assertions
    asserts_topic.has_association :referenced_in,   :account
    asserts_topic.has_association :references_many, :comments
    asserts_topic.has_association :embedded_in,     :customer, :class_name => "Person"

    # validation assertions
    asserts_topic.has_validation :validates_presence_of, :caption

    # support for custom validators, see the tests for a complete example
    asserts_topic.has_validation :validates, :states, :inclusion_of_set => { :in => [1, 2, 3] }

    # key assertions
    asserts_topic.has_key :title, :caption
  end
end
```


## Mongoid 1.9.1

To use riot-mongoid with Mongoid 1.9.1 check out the [legacy branch](http://github.com/thumblemonks/riot-mongoid/tree/legacy)

## Mongoid 2.1.x

To use riot-mongoid with Mongoid 2.1.x do:

    gem install riot-mongoid

or check out the [master branch](http://github.com/thumblemonks/riot-mongoid/tree/beta20)


## Note on Patches/Pull Requests

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2011 gabrielg, Arthur Chiu. See LICENSE for details.

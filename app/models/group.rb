class Group
  include Mongoid::Document
  include Mongoid::Ancestry
  has_ancestry
  
  field :name, :type => String
  has_and_belongs_to_many :users, :autosave => true, :index => true, :unique => true
  
  alias :to_s :name
end

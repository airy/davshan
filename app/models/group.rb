class Group
  include Mongoid::Document
  include Mongoid::Ancestry
  has_ancestry
  
  field :name, :type => String
end

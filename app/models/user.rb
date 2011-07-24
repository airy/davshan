class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  field :username
  key :username
  
  field :firstname
  field :lastname
  field :twitter
  field :website

  validates :username, :presence => true, :uniqueness => true, :length => { :within => 4..20 }, :format => { :with => /[A-Za-z0-9]+/ }
  validates :email, :presence => true, :uniqueness => true, :length => {:maximum => 254}, :format => {:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i}
  
  has_and_belongs_to_many :groups, :autosave => true, :index => true, :unique => true

end

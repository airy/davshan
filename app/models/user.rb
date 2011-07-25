class User
  include Mongoid::Document
  include Stateflow

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

  # monkey patch for https://github.com/plataformatec/devise/issues/240
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at, :type => Time
  
  validates :username, :presence => true, :uniqueness => true, :length => { :within => 4..20 }, :format => { :with => /[A-Za-z0-9]+/ }
  validates :email, :presence => true, :uniqueness => true, :length => {:maximum => 254}, :format => {:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i}
  
  has_and_belongs_to_many :groups, :autosave => true, :index => true, :unique => true

  field :role
  
  def role? name
    self.role == name.to_s
  end
  
  stateflow do
    state_column :role
    initial :user
    
    state :user, :moderator, :admin
    
    event :promote do
      transitions :from => :user, :to => :moderator
      transitions :from => :moderator, :to => :admin
    end

    event :demote do
      transitions :from => :admin, :to => :moderator
      transitions :from => :moderator, :to => :user
    end
  end
  
  def avatar_url(size = 64)
    gravatar_id = Digest::MD5.hexdigest(self.email.downcase)
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
  end
  
  alias :to_s :username

end

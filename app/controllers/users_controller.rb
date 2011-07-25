class UsersController < InheritedResources::Base
  actions :all, :except => [:new, :create, :destroy]
  
  def promote
    resource.promote!
    redirect_to resource, :notice => "User promoted!"
  end

  def demote
    resource.demote!
    redirect_to resource, :notice => "User demoted!"
  end
end

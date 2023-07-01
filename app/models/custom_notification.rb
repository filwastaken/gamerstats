class CustomNotification
  attr_accessor :id, :email, :isuser

  def initialize(id, email)
    @id = id
    @email = email
    @isuser = true
  end
end
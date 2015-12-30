class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  validate :email_is_unique, on: :create
  after_create :create_account
  def confirmation_required?
    false
  end

  private
  def create_account
    account = Account.new(email: email)
    account.save!
  end

  # email should be unique in Account model
  def email_is_unique
    # Do not validate email if errors already present
    return false unless self.errors[:email].nil?

    unless Account.find_by(email: email).nil?
      errors.add(:email, 'is already registered')
    end
  end
end

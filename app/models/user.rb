class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :jogging_times

  def self.ransackable_attributes(auth_object = nil)
       ["email"]
     end

       enum role: [:user, :moderator, :admin]
       after_initialize :set_default_role, :if => :new_record?
       def set_default_role
        self.role ||= :admin
       end

end

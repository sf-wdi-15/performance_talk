class User < ActiveRecord::Base

  has_many :articles

  has_secure_password

  validates :email, 
            uniqueness: true,
            confirmation: true

  validates :password_confirmation,
            :presence => true,
            :length => { :minimum => 8},
            # password must not be all lowercase letters
            :format => { :without => /\A[a-z]+\z/ },
            :if => :password_required? 

  validates :email_confirmation, 
            format: { with: /.+@.+/ },
            presence: true,
            if: :email_conf_required?


  def self.confirm(email_param, password_param)
    user = find_by({email: email_param})
    user.try(:authenticate, password_param)
  end

  ## These need tests too

  def password_required?
     self.new_record? or !self.password.nil?
  end

  def email_conf_required?
     self.new_record? or self.email_changed?
  end
end

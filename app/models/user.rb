class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  has_many :authentications, dependent: :delete_all
  def apply_omniauth(omniauth)
    self.username = omniauth['info']['nickname'] if username.blank?
    self.email = omniauth['info']['email'] if email.blank?

    authentications.build(:provider => omniauth['provider'],
                        :uid => omniauth['uid'],
                        :token => omniauth['credentials'].token,
                        :token_secret => omniauth['credentials'].secret)
  end

  def password_required?
    (authentications.empty? || !password.blank?) && super
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end
end

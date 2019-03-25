class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:vkontakte, :twitter, :facebook, :google, :yandex]

  has_many :answers
  has_many :questions
  has_many :votes
  has_many :comments
  has_many :authorizations

  # AVATAR_SIZES = {
  #     micro: 16,
  #     thumb: 32,
  #     medium: 128,
  #     large: 512
  # }
  #
  # def gravatar_url(size)
  #   size = avatar_size(size)
  # end
  #
  # def avatar_size(size)
  #   AVATAR_SIZES[size]
  # end

  def self.find_for_oauth(auth)
    authorization = Authorization.where(provider: auth.provider, uid: auth.uid.to_s).first
    return authorization.user if authorization

    email = auth.info[:email]
    user = User.where(email: email).first
    if user
      user.create_authorization(auth)
    else
      password = Devise.friendly_token[0, 20]
      user = User.create!(email: email, password: password, password_confirmation: password )
      user.create_authorization(auth)
    end
    user
  end

  def create_authorization(auth)
    self.authorizations.create(provider: auth.provider, uid: auth.uid)
  end
end

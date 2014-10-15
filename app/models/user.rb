  class User < ActiveRecord::Base

    has_secure_password

    LEVEL = {
      super_admin: LEVEL_SUPER_ADMIN = 1, 
      store_keeper: LEVEL_STORE_KEEPER = 2, 
      customer: LEVEL_CUSTOMER = 3
    }
    VALID_EMAIL_REGEX=/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

    has_many :orders

    before_save { self.email = email.downcase }
    before_create :create_remember_token

    validates :name,presence:true,length:{maximum:50}
    validates :email, presence:true,
              format:{with:VALID_EMAIL_REGEX},
              uniqueness:{case_sensitive:false}
    validates :password, length: { minimum: 6 }

    def User.new_remember_token
      SecureRandom.urlsafe_base64
    end

    def User.hash(token)
      Digest::SHA1.hexdigest(token.to_s)
    end


    private

    def create_remember_token
      self.remember_token = User.hash(User.new_remember_token)
    end

  end

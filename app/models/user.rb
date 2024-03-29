class User < ActiveRecord::Base
   attr_accessor :remember_token
   
   validates :email, presence: true, uniqueness: { case_sensitive: false }

  has_secure_password

  # Returns the hash digest of the given string.
   def User.digest(string)
     cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                   BCrypt::Engine.cost
     BCrypt::Password.create(string, cost: cost)
   end

   # Returns a random token.
   def User.new_token
     SecureRandom.urlsafe_base64
   end

   # Remembers a user in the database for use in persistent sessions.
   def remember
     self.remember_token = User.new_token
     self.remember_digest = User.digest(remember_token)
     update_attribute(:remember_digest, User.digest(remember_token))
   end

   # Returns true if the given token matches the digest.
   def authenticated?(remember_token)
     return false if remember_digest.nil?
     BCrypt::Password.new(remember_digest).is_password?(remember_token)
   end

   # Forgets a user.
   def forget
     update_attribute(:remember_digest, nil)
   end

 end

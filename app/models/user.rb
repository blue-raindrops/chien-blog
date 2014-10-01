class User < ActiveRecord::Base
	default_scope -> {order('created_at DESC')}
	def name
		"#{ self.first_name } #{ self.last_name }"
	end

	def as_json(options)
		super(
			except: [:password_digest, :first_name, :last_name]).merge({name: self.name})
	end

  has_many :comments, dependent: :destroy
	has_secure_password
end

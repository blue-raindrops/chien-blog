class User < ActiveRecord::Base
	def name
		"#{ self.first_name } #{ self.last_name }"
	end

	has_secure_password
end

class Session < ActiveRecord::Base
	belongs_to :user

	def save_with_session_code
		self.session_code = SecureRandom.urlsafe_base64 unless self.session_code
		self.save
	end


end

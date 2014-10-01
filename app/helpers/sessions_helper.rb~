module SessionsHelper
	def current_user(*args)
		remember_token = User.encrypt(cookies[:remember_token])
		if args.nil?
			@current_user = User.find_by(remember_token: remember_token)
		else
			@current_user = User.includes(args).find_by(remember_token: remember_token)
		end
	end
end

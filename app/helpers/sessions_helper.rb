module SessionsHelper
	def current_user(*args)
		x = Session.includes([:user => (args.nil? ? [] : args)]).find_by(:session_code => cookies[:session_code])
    @current_user = x.nil? ? nil : x.user
  end
end

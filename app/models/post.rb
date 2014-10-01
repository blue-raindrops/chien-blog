class Post < ActiveRecord::Base
	default_scope -> {order('created_at DESC')}
	validates_presence_of :title
	validates_presence_of :body

  has_many :comments, dependent: :destroy
end

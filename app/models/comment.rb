class Comment < ActiveRecord::Base
    validates_presence_of :body

    belongs_to :post
    belongs_to :user

    
    def as_json(options={})
      super(options).merge({ user_name: self.user.name })
    end
end

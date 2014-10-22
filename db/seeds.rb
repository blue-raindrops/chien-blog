x = "0"
until x.next! == "500"
  Post.create(user_id: User.all.sample.id, title: "Post #{x}", body: "This is post #{x}")
end


User.all.each do |user|
  Post.all.each do |post|
    Comment.create(post_id: post.id, user_id: user.id, body: "I, #{user.name}, great lord of the darkness, am commenting on #{post.title}. Mwahahahahahahahaha!")
  end
end

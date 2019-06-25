@user = User.create!(
  email: "test@test.com",
  password: "password",
  password_confirmation: "password",
  first_name: "Jon",
  last_name: "Snow"
)

50.times do |index|
  Post.create!(date: Date.today, rationale: "#{index} rationale content", user_id: @user.id)
end
puts '50 posts have been created'

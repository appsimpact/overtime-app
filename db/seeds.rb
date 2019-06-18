50.times do |index|
  Post.create!(date: Date.today, rationale: "#{index} rationale content")
end
puts '50 posts have been created'

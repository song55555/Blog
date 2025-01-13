categories = [
  "東京", "大阪", "京都", "神戸", "福岡", "名古屋", "仙台", "沖縄", "北海道", "富士山"
]

categories.each do |category_name|
  Category.find_or_create_by(name: category_name)
end

User.find_or_create_by(email: "daybreak0819@gmail.com") do |user|
    user.nickname = "SONG JONGWON"
    user.password = "1234"
    user.password_confirmation = "1234" 
  end

puts "Categories have been added successfully!"
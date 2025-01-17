categories = [
  "東京", "大阪", "京都", "神戸", "福岡", "名古屋", "仙台", "沖縄", "北海道", "富士山"
]

categories.each do |category_name|
  Category.find_or_create_by(name: category_name)
end

user = User.find_or_create_by(email: "daybreak0819@gmail.com") do |user|
  user.nickname = "SONG JONGWON"
  user.password = "1234"
  user.password_confirmation = "1234"
end

puts "Categories and User have been added successfully!"

posts = [
  {
    title: "東京旅行1",
    content: "東京旅行 ![東京1](/img/東京1.jpg)",
    category_name: "東京",
    user_id: user.id 
  },
  {
    title: "大阪旅行1",
    content: "大阪旅行 ![大阪1](/img/大阪1.jpg)",
    category_name: "大阪",
    user_id: user.id 
  },
  {
    title: "京都旅行1",
    content: "京都旅行 ![京都1](/img/京都1.jpg)",
    category_name: "京都",
    user_id: user.id 
  },
  {
    title: "神戸旅行1",
    content: "神戸旅行 ![神戸1](/img/神戸1.jpg)",
    category_name: "神戸",
     user_id: user.id 
  },
  {
    title: "福岡旅行1",
    content: "福岡旅行 ![福岡1](/img/福岡1.jpg)",
    category_name: "福岡",
     user_id: user.id 
  },
  {
    title: "名古屋旅行1",
    content: "名古屋旅行 ![名古屋1](/img/名古屋1.jpg)",
    category_name: "名古屋",
     user_id: user.id 
  },
  {
    title: "仙台旅行1",
    content: "仙台旅行 ![仙台1](/img/仙台1.jpg)",
    category_name: "仙台",
     user_id: user.id 
  },
  {
    title: "沖縄旅行1",
    content: "沖縄旅行 ![沖縄1](/img/沖縄1.jpg)",
    category_name: "沖縄",
     user_id: user.id 
  },
  {
    title: "北海道旅行1",
    content: "北海道旅行 ![北海道1](/img/北海道1.jpg)",
    category_name: "北海道",
     user_id: user.id 
  },
  {
    title: "富士山旅行1",
    content: "富士山旅行 ![富士山1](/img/富士山1.jpg)",
    category_name: "富士山",
     user_id: user.id 
  }
]

posts.each do |post_data|
  category = Category.find_by(name: post_data[:category_name])
  Post.find_or_create_by(title: post_data[:title]) do |post|
    post.content = post_data[:content]
    post.category = category
    post.user_id = post_data[:user_id]  
  end
end

puts "Posts have been added successfully!"
puts "Deleting data..."

# puts "Deleting USERS..."
# User.destroy_all

puts "Deleting POSTS"
Post.destroy_all

User.find_or_initialize_by(email: 'DonaldGMiller@example.com').update({
  first_name: 'Donald',
  last_name: 'Miller',
  password: 'eeMaev2shai'
})

User.find_or_initialize_by(email: 'LawrenceWGrant@example.com').update({
  first_name: 'Lawrence',
  last_name: 'Grant',
  password: 'ahR7iecai'
})

User.find_or_initialize_by(email: 'MargeRWilliams@example.com').update({
  first_name: 'Marge',
  last_name: 'Williams',
  password: 'Aechugh1ie'
})

puts '🌱 users Done!'

require 'json'
require 'open-uri'

url = 'https://hacker-news.firebaseio.com/v0/topstories.json'
post_ids = URI.open(url).read
posts = JSON.parse(post_ids)

20.times do |i|
  post_id = posts[i]
  url_post = "https://hacker-news.firebaseio.com/v0/item/#{post_id}.json"
  post_info = URI.open(url_post).read
  post = JSON.parse(post_info)
  post = Post.create(
    title: post['title'],
    username: post['by'],
    votes: post['score'],
    url: post['url'],
    post_id: post['id']
  )
end

puts '🌱 posts Done!'

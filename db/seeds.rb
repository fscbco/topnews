User.find_or_initialize_by(email: 'DonaldGMiller@example.com').update({
  first_name: 'Donald',
  last_name: 'Miller',
  password: 'eeMaev2shai'
})

user_one_id = User.id.last

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

Story.find_or_initialize_by(hackernewsid: 41184365).update({
  author: 'etiam',
  title: 'Prevention of HIV',
  url: 'https://www.science.org/content/blog-post/prevention-hiv',
  hn_created_at: '2024-08-07 19:11:39'
})

Story.find_or_initialize_by(hackernewsid: 41183115).update({
  author: 'ndiddy',
  title: 'Tony Hawk\'s Pro Strcpy',
  url: 'https://icode4.coffee/?p=954',
  hn_created_at: '2024-08-07 16:48:42'
})

Story.find_or_initialize_by(hackernewsid: 41182847).update({
  author: 'cpeterso',
  title: 'Puppeteer Support for Firefox',
  url: 'https://hacks.mozilla.org/2024/08/puppeteer-support-for-firefox/',
  hn_created_at: '2024-08-07 16:19:06'
})

Like.find_or_initialize_by(user_id: User.where(email: 'MargeRWilliams@example.com'.downcase).last.id).update({
  story_id: Story.where(hackernewsid: 41184365).last.id
})

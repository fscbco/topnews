user_1 = User.find_or_initialize_by(email: 'DonaldGMiller@example.com').update({
  first_name: 'Donald',
  last_name: 'Miller',
  password: 'eeMaev2shai'
})

user_2 = User.find_or_initialize_by(email: 'LawrenceWGrant@example.com').update({
  first_name: 'Lawrence',
  last_name: 'Grant',
  password: 'ahR7iecai'
})

User.find_or_initialize_by(email: 'MargeRWilliams@example.com').update({
  first_name: 'Marge',
  last_name: 'Williams',
  password: 'Aechugh1ie'
})

Story.find_or_initialize_by(title: 'Venture Capital in the 1980s' ).update({
  url: 'http://reactionwheel.net/2015/01/80s-vc.html'
})

Story.find_or_initialize_by(title: 'BIT Poised to Become Publicly Traded Bitcoin Fund' ).update({
  url: 'http://www.wsj.com/articles/bitcoin-investment-trust-gets-finras-ok-to-become-public-bitcoin-fund-1425242094'
})

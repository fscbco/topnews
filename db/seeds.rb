User.find_or_initialize_by(email: 'dmiller@example.com').update({
  first_name: 'Donald',
  last_name: 'Miller',
  password: 'password'
})

User.find_or_initialize_by(email: 'lgrant@example.com').update({
  first_name: 'Lawrence',
  last_name: 'Grant',
  password: 'password'
})

User.find_or_initialize_by(email: 'mwilliams@example.com').update({
  first_name: 'Marge',
  last_name: 'Williams',
  password: 'password'
})

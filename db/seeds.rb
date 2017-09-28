admin = Role.create!(name: :admin)
Role.create!(name: :copyriter)
User.create!(email: 'admin@blog.com', password: 'admin123', roles: [admin])

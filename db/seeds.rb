admin = Role.create!(name: :admin)
copyriter = Role.create!(name: :copyriter)
User.create!(email: 'admin@blog.com', password: 'admin123', roles: [admin, copyriter])

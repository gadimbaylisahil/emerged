# Categories
category = Category.create(name: 'Music')

# Users
user = User.create(email: 'sahil.gadimbay@gmail.com', password: '123456', password_confirmation: '123456', first_name: 'Sahil', last_name: 'Gadimbayli')

# Second User
second_user = User.create(email: 'gadimbayli@gmail.com', password: '123456', password_confirmation: '123456', first_name: 'Tom', last_name: 'Johnes')

# Creations
creation = Creation.create(user: user, title: 'lorem ipsum lorem ipsum', content: 'some random content', license_id: 1, category: category)

# Stories
story = Story.create(user: user, title: 'lorem ipsum lorem ipsum', content: 'some random content', category: category)
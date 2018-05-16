# Categories
category = Category.create!(name: 'Music')
Category.create!(name: 'Photography')

# Licenses
license = License.create!(name: 'MIT License',
                          description: 'Open Sourced, Free to Use')

# Users
user = User.create!(email: 'sahil.gadimbay@gmail.com',
                    password: '123456',
                    password_confirmation: '123456',
                    first_name: 'Sahil',
                    last_name: 'Gadimbayli')

User.create!(email: 'gadimbayli@gmail.com',
             password: '123456',
             password_confirmation: '123456',
             first_name: 'Tom',
             last_name: 'Johnes')

# Creations
Creation.create!(user: user,
                 title: 'lorem ipsum lorem ipsum',
                 content: 'some random content',
                 license_id: license,
                 category: category,
                 published: true)

# Stories
Story.create!(user: user,
              title: 'lorem ipsum lorem ipsum',
              content: 'some random content',
              category: category,
              published: true)

# Rewards
reward = Reward.create!(user: user,
                        title: 'Seeded Reward',
                        visible: true,
                        description: 'Great Seeded Song',
                        reward_type: 'Digital',
                        category: category,
                        price_cents: 30000,
                        shipping_cost_cents: 0)
# Carts



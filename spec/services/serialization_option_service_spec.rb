require 'rails_helper'
describe SerializationOption do
	context 'when resources, limit fields and links are given' do
		
		let(:resources){
			{
				user: {
						fields: %i[first_name last_name]
				},
				category: {
						fields: %i[name]
				}
			}
		}
		
		let(:links){
			{
					self: 'self@self.com',
					next: 'next@next.com',
					prev: 'prev@prev.com'
			}
		}
		
		subject {
			SerializationOption.run(resources, links)
		}
		
		it 'returns an option hash with correct keys and values' do
			expected_result = {
					include: %i[user category],
					fields: {
						user: %i[first_name last_name],
						category: %i[name]
					},
					links: {
							self: links[:self],
							next: links[:next],
							prev: links[:prev]
					}
			}
			expect(subject).to eq(expected_result)
		end
	end
end
FactoryBot.define do
  factory :message do
    content {Faker::Lorem.sentence}

    # generates a user and a room to go with the message since those two are a given
    association :user
    association :room

    after(:build) do |message|
      message.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
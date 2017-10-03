FactoryGirl.define do
  factory :copyriter, class: User do
    email { FFaker::Internet.email }
    password FFaker::Internet.password
    roles { [create(:copyriter_role)] }
  end

  factory :invalid_copyriter, class: User do
    email nil
    password nil
    roles { [create(:copyriter_role)] }
  end

  factory :admin, class: User do
    email FFaker::Internet.email
    password FFaker::Internet.password
    roles { [create(:admin_role)] }
  end
end

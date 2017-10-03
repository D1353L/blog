FactoryGirl.define do
  factory :admin_role, class: Role do
    name 'admin'
  end

  factory :copyriter_role, class: Role do
    name 'copyriter'
  end
end

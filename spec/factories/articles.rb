FactoryGirl.define do
  factory :article do
    title "MyString"
    text "MyText"
    views_count 1
    user nil
  end
end

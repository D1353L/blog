FactoryGirl.define do
  factory :article, class: Article do
    title { FFaker::Book.title }
    text { FFaker::Book.description }
    views_count 0
    user nil
  end

  factory :invalid_article, class: Article do
    title nil
    text nil
    views_count nil
    user nil
  end
end

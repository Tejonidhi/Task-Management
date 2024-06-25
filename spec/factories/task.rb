FactoryBot.define do
  factory :task do
    association :user
    title { "Test Task" }
    description { "This is a test task." }
    status { "in_progress" }
    deadline { 2.days.from_now }
  end
end

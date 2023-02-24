FactoryBot.define do
  factory :shift do
    start_time { "10:00" }
    end_time { "11:00" }
    job
  end
end

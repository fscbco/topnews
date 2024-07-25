FactoryBot.define do
    factory :user do
        first_name {:foo}
        last_name { :bar }
        email { "f@b.c" }
        password { 'foobar123' }
    end
end
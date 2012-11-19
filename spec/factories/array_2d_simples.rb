FactoryGirl.define do

  factory :array_2d_simple do
    height 2
    width 8
    
    initialize_with { new(attributes) }
  end

 
end
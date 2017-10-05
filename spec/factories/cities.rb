# frozen_string_literal: true

# == Schema Information
#
# Table name: cities
#
#  id          :integer          not null, primary key
#  city        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :city do
    city "MyString"
    description "MyText"
  end
end

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

require "csv"

class City < ApplicationRecord
  validates :city, presence: true

  # This skips validation.
  def self.import_csv(file_path)
    imported_cities = City::ImportCsv.new.import(file_path)

    transaction do
      imported_cities.each do |imported_city|
        record = City.find_or_create_by!(city: imported_city[:city])
        record.update!(description: imported_city[:description])
      end
    end

    imported_cities.count
  rescue StandardError => exception
    Rails.env.test? ? raise(exception) : logger.error(exception)
    false
  end

  def self.to_csv
    attribute_names = %w[city description]
    CSV.generate(headers: true) do |csv|
      # Add attribute names to the first row.
      csv << attribute_names

      # Add attribute values to the following rows for each record.
      # NOTE: Previously defined scopes will still be effective here.
      all.find_each do |city|
        csv << city.attributes.values_at(*attribute_names)

        # Getting attribute values
        #   csv << user.attributes.values_at(*attribute_names)    # Pattern A: attributes that exist in database
        #   csv << attribute_names.map { |attr| user.send(attr) } # Pattern B: attributes that exist in database + virtual attributes
      end
    end
  end
end

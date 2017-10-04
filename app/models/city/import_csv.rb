# frozen_string_literal: true

require "csv"

# Responsible for importing a csv file and converting it into array of hashes.
# First col: city
# Second col: description
class City::ImportCsv
  def import(file_path = Rails.root.join("db", "cities.csv"))
    options = {
      headers: true,
      encoding: "iso-8859-1:utf-8",
      header_converters: ->(f) { f.strip.downcase.parameterize(separator: "_") },
      converters: ->(f) { f ? f.strip : nil }
    }

    imported_cities = []
    CSV.foreach(file_path, options) do |row|
      imported_cities << row.to_hash.symbolize_keys
    end
    imported_cities
  rescue StandardError => exception
    Rails.env.test? ? raise(exception) : logger.error(exception)
    nil
  end
end

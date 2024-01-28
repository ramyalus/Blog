require 'csv'

CSV.open("export.csv", 'w') do |csv|
	csv << ["sl no", "name"]
	csv << ["1", "Ramya"]
end
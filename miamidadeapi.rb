require 'httparty'

def costs_by_category(category_number)
  data = HTTParty.get('https://opendata.miamidade.gov/resource/awsz-tanw.json?$limit=40000')
  matches = []
  data.each do |permit|
  	matches << permit["estimatedvalue"].to_i if permit["categories"] == category_number.to_s && permit["estimatedvalue"].to_i != 0
  end
  return matches.sort
end

def average_cost_by_category(category_number)
  all_costs = costs_by_category(category_number)
  all_costs.map(&:to_i).inject(:+) / all_costs.count
end

category_number = 55
puts average_cost_by_category(category_number)
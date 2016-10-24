require 'csv'
require 'date'
require 'time'
require 'awesome_print'
require 'json'

# 7 places
data = {
  "timetable" => {
    "sorami" => [],
    "B3" => [],
    "3F9" => [],
    "4F5" => [],
    "hiroba" => [],
    "sky" => [],
    "f350" => []
  }
}

places = ["sorami","B3","3F9","4F5","hiroba","sky","f350"]

id = 1

CSV.foreach("./20151205.csv") do |row|
  s, e = row[1].split('〜')

  obj = {
    "id" => id,
    "start_time" => (Time.new(2015, 12, 5, s.split(":")[0], s.split(":")[1])).to_s.gsub('-','/'),
    "end_time" => (Time.new(2015, 12, 5, e.split(":")[0], e.split(":")[1])).to_s.gsub('-','/'),
    "band" => row[2],
    "circle" => row[3]
  }
  puts places[row[0].to_i]
  data["timetable"][places[row[0].to_i]] << obj
  id += 1
end
CSV.foreach("./20151206.csv") do |row|
  s, e = row[1].split('〜')
  obj = {
    "id" => id,
    "start_time" => (Time.new(2015, 12, 6, s.split(":")[0], s.split(":")[1])).to_s.gsub('-','/'),
    "end_time" => (Time.new(2015, 12, 6, e.split(":")[0], e.split(":")[1])).to_s.gsub('-','/'),
    "band" => row[2],
    "circle" => row[3]
  }

  data["timetable"][places[row[0].to_i]]<<obj
  id += 1
end

File.write("sas.json", data.to_json)

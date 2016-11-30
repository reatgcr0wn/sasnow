require 'csv'
require 'date'
require 'time'
require 'awesome_print'
require 'json'

# 7 places
data = {
  "timetable" => {
    "hiroba" => [],
    "sorami" => [],
    "sky" => [],
    "B3" => [],
    "2F10" => [],
    "3F12" => [],
    "s634" => [],
    "f350" => []
  }
}

places = ["hiroba","sorami","sky","B3","2F10","3F12","s634","f350"]

id = 1

CSV.foreach("./20161203.csv") do |row|
  s, e = row[1].split('〜')
  obj = {
    "id" => id,
    "start_time" => (Time.new(2016, 12, 3, s.split(":")[0], s.split(":")[1])).to_s.gsub('-','/'),
    "end_time" => (Time.new(2016, 12, 3, e.split(":")[0], e.split(":")[1])).to_s.gsub('-','/'),
    "band" => row[2],
    "circle" => row[3]
  }
  puts places[row[0].to_i]
  data["timetable"][places[row[0].to_i]] << obj
  id += 1
end
CSV.foreach("./20161204.csv") do |row|
  s, e = row[1].split('〜')
  obj = {
    "id" => id,
    "start_time" => (Time.new(2016, 12, 4, s.split(":")[0], s.split(":")[1])).to_s.gsub('-','/'),
    "end_time" => (Time.new(2016, 12, 4, e.split(":")[0], e.split(":")[1])).to_s.gsub('-','/'),
    "band" => row[2],
    "circle" => row[3]
  }

  data["timetable"][places[row[0].to_i]]<<obj
  id += 1
end

File.write("sas.json", data.to_json)

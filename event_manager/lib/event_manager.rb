require 'csv'
require 'sunlight/congress'
require 'erb'

puts "EventManager Initialized!"
file_name =  Dir.glob('../event_attendees.csv').first
template_letter_name=Dir.glob('../form_letter.erb').first


contents = File.read(file_name)
puts contents

puts "------------------------------------------------------------------------------------------------------------------"
lines = File.readlines(file_name)
lines.each do |line|
  puts line
end

puts "------------------------------------------------------------------------------------------------------------------"

lines = File.readlines(file_name)
lines.each do |line|
  columns = line.split(",")
  puts columns
end

puts "------------------------------------------------------------------------------------------------------------------"

lines = File.readlines(file_name)
lines.each do |line|
  columns = line.split(",")
  name = columns[2]
  puts name
end

puts "------------------------------------------------------------------------------------------------------------------"


lines = File.readlines(file_name)
lines.each do |line|
  next if line == " ,RegDate,first_Name,last_Name,Email_Address,HomePhone,Street,City,State,Zipcode\n"
  columns = line.split(",")
  name = columns[2]
  puts name
end

puts "------------------------------------------------------------------------------------------------------------------"
lines = File.readlines(file_name)
row_index=0
lines.each do |line|
  row_index+=1
  next if row_index=1
  columns = lines.split(",")
  name =columns[2]
  puts name
end

puts "------------------------------------------------------------------------------------------------------------------"
lines=File.readlines(file_name)
lines.each_with_index do |line,index|
  next if index == 0
  columns = line.split(",")
  name = columns[2]
  puts name
end

puts "------------------------------------------------------------------------------------------------------------------"

contents=CSV.open file_name, headers: true
contents.each do |row|
  name=row[2]
  puts name
end

puts "------------------------------------------------------------------------------------------------------------------"
contents=CSV.open file_name, headers: true, header_converters: :symbol
contents.each do |row|
  name=row[:first_name]
  puts name
end

puts "------------------------------------------------------------------------------------------------------------------"
contents=CSV.open file_name, headers: true, header_converters: :symbol
contents.each do |row|
  name = row[:first_name]
  zipcode = row [:zipcode]
  puts "#{name}: #{zipcode}"
end

puts "------------------------------------------------------------------------------------------------------------------"
contents=CSV.open file_name, headers: true, header_converters: :symbol
contents.each do |row|
  name = row[:first_name]
  zipcode=row[:zipcode]
  if zipcode.nil?
    zipcode = "00000"
  elsif zipcode.length  < 5
    zipcode=zipcode.rjust(5,"0")
  elsif zipcode.length >5
    zipcode=zipcode[0..4]
  end
  puts "#{name}: #{zipcode}"
end

puts "------------------------------------------------------------------------------------------------------------------"

def clean_zipcode(zipcode)
  case
    when zipcode.nil?
      zipcode="00000"
    when zipcode.length>5
      zipcode=zipcode[0..4]
    when zipcode.length<5
      zipcode=zipcode.rjust(5,"0")
  end
  zipcode
end

contents = CSV.open file_name, headers:true, header_converters: :symbol
contents.each do |row|
  name = row[:first_name]
  zipcode = row[:zipcode]
  zipcode=clean_zipcode(zipcode)
  puts "#{name}: #{zipcode}"
end
puts "------------------------------------------------------------------------------------------------------------------"
Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"
def clean_zipcode1(zipcode)
  zipcode.to_s.rjust(5,"0")[0..4]
end
puts "EventManager initialized"
contents = CSV.open file_name, headers: true, header_converters: :symbol
contents.each do |row|
  name = row[:first_name]
  zipcode=row[:zipcode]
  zipcode=clean_zipcode1(zipcode)
  legislators = Sunlight::Congress::Legislator.by_zipcode(zipcode)
  puts "#{name}: #{zipcode}, #{legislators}"
end

puts "------------------------------------------------------------------------------------------------------------------"
Sunlight::Congress.api_key="e179a6973728c4dd3fb1204283aaccb5"
def clean_zipcode3(zipcode)
  zipcode.to_s.rjust(5,"0")[0..4]
end
contents = CSV.open file_name, headers: true , header_converters: :symbol
contents.each do |row|
  name = row[:first_name]
  zipcode = row[:zipcode]
  zipcode=clean_zipcode3(zipcode)
  legislators = Sunlight::Congress::Legislator.by_zipcode(zipcode)
  legislators_names =legislators.collect do |legislator|
    "#{legislator.first_name} #{legislator.last_name}"
  end
  legislators_string= legislators_names.join(", ")
  puts "#{name}: #{zipcode}, #{legislators_string}"
end

puts "------------------------------------------------------------------------------------------------------------------"

def clean_zipcode4(zipcode)
  zipcode.to_s.rjust(5,"0")[0..4]
end

def legislators_by_zipcode(zipcode)
  legislators= Sunlight::Congress::Legislator.by_zipcode(zipcode)
  legislators_names = legislators.collect {|legislator_name|
    "#{legislator_name.first_name} #{legislator_name.last_name}"}
  legislators_names.join(", ")
end

contents = CSV.open file_name, headers: true, header_converters: :symbol
contents.each do |row|
  name=row[:first_name]
  zipcode=clean_zipcode4(row[:zipcode])
  legistators = legislators_by_zipcode(zipcode)

  puts "#{name} #{zipcode} #{legistators}"
end
puts "------------------------------------------------------------------------------------------------------------------"

Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"

def clean_zipcode5(zipcode)
  zipcode.to_s.rjust(5,"0")[0..4]
end

def legislators_by_zipcode6(zipcode)
  Sunlight::Congress::Legislator.by_zipcode(zipcode)
end

puts "EventManager initialized."

contents = CSV.open file_name, headers: true, header_converters: :symbol

template_letter = File.read template_letter_name
erb_template = ERB.new template_letter

contents.each do |row|
  id= row[0]
  name = row[:first_name]

  zipcode = clean_zipcode5(row[:zipcode])

  legislators = legislators_by_zipcode6(zipcode)

  form_letter = erb_template.result(binding)
  Dir.mkdir("output") unless Dir.exist?"output"
  filename="output/thanks_#{id}.html"
  File.open(filename,'w') do |file|
    file.puts form_letter
  end
  puts form_letter
end

puts "------------------------------------------------------------------------------------------------------------------"

meaning_of_life = 42

question = "The Answer to the Ultimate Question of Life, the Universe, and Everything is <%= meaning_of_life %>"
template = ERB.new(question)

results = template.result(binding)
puts results


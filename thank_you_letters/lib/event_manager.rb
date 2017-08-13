require 'csv'
require 'sunlight/congress'
require 'erb'

attendees_filename = Dir.glob("../event_attendees.csv").first
Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"
template_latter_filename = Dir.glob("../form_letter.erb").first

def formating_zipcode(zipcode)
  zipcode.to_s.rjust(5,"0")[0..4]
end

def legislator_by_zipcode(zipcode)
  legislators = Sunlight::Congress::Legislator.by_zipcode(zipcode)
end

def save_thank_you_letters(id, form_letter)
  Dir.mkdir "saved_letters" unless Dir.exist?"saved_letters"
  filename = "saved_letters/thanks_#{id}.html"
  File.open(filename,'w') do |file|
    file.puts(form_letter)
  end
end

attendees = CSV.open attendees_filename, headers: true, header_converters: :symbol
template_latter = File.read(template_latter_filename)
erb_template_latter = ERB.new template_latter

attendees.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = formating_zipcode(row[:zipcode])
  legislators = legislator_by_zipcode(zipcode)
  form_letter = erb_template_latter.result(binding)
  save_thank_you_letters(id,form_letter)
end



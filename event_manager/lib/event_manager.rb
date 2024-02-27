require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'
require 'time'

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, '0')[0..4]
end

def legislators_by_zipcode(zipcode)
  # according to https://github.com/googleapis/google-api-ruby-client/blob/main/docs/usage-guide.md
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    civic_info.representative_info_by_address(
      address: zipcode,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    ).officials
  rescue
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

def save_thank_you_letter(id, form_letter)
  Dir.mkdir('output') unless Dir.exist?('output')

  file_path = "output/thanks_#{id}.html"
  File.open(file_path, 'w') do |file|
    file.puts form_letter
  end
end

def clean_phone(phone)
  is_number = -> (string) { string.to_i.to_s == string }
  cleaned_phone = phone.split("").filter(&is_number).join

  return cleaned_phone if cleaned_phone.length == 10
  if cleaned_phone.length == 11 && cleaned_phone[0] == '1'
    return cleaned_phone[1..]
  end
  nil
end

def create_thank_you_letter(contents, erb_template)
  contents.each do |row|
    p row
    id = row[0]
    name = row[:first_name]
    phone = clean_phone(row[:homephone])
    zipcode = clean_zipcode(row[:zipcode])

    legislators = legislators_by_zipcode(zipcode)

    form_letter = erb_template.result(binding)

    save_thank_you_letter(id, form_letter)
  end
end

def find_peak_registration_hours(contents)
  contents.reduce({}) do |acc, row|
    date = Time.strptime(row[:regdate], "%m/%d/%Y %H:%M") { |y| y + 2000 }
    acc[date.hour] = acc[date.hour].to_i + 1
    acc
  end
end

puts 'Event Manager Initialized!'

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

template_letter = File.read('form_letter.erb')
erb_template = ERB.new template_letter

# create_thank_you_letter(contents, erb_template)
p find_peak_registration_hours(contents)

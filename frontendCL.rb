require "unirest"

system "clear"

puts "Choose a contact"
puts "[1] Apple"
puts "[2] Banana"
puts "[3] Orange"

input_option = gets.chomp

if input_option == "1"
  response1 = Unirest.get("http://localhost:3000/v1/Kevin")
  contact1 = response1.body
  puts JSON.pretty_generate(contact1)

elsif input_option == "2"
  response2 = Unirest.get("http://localhost:3000/v1/Abner")
  contact2 = response2.body
  puts JSON.pretty_generate(contact2)

elsif input_option == "3"
  response3 = Unirest.get("http://localhost:3000/v1/David")
  contact3 = response3.body
  puts JSON.pretty_generate(contact3)

elsif puts "Not a valid input."
end
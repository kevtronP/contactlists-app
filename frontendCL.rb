require "unirest"

system "clear"

puts "Select an option"
puts "[1] Show all contacts"
puts "[2] Show one contact"
puts "[3] Create a new contact"
puts "[4] Update existing contact"
puts "[5] Delete existing contact"

input_option = gets.chomp

if input_option == "1"
  response = Unirest.get("http://localhost:3000/v1/contacts")
  contacts = response.body
  puts JSON.pretty_generate(contacts)

  elsif input_option == "2"
    print "Please enter the ID of the contact: "
    contact_id = gets.chomp
    response = Unirest.get("http://localhost:3000/v1/contacts/#{contact_id}")
    contact = response.body
    puts JSON.pretty_generate(contact)

  elsif input_option == "3"
    params = {}
    print "Please enter contact's first name: "
    params["first_name"] = gets.chomp
    print "Please enter contact's last name: "
    params["last_name"] = gets.chomp
    print "Please enter contact's email"
    params["email"] = gets.chomp
    print ["Please enter contact's phone number"]
    params["phone_number"] = gets.chomp
    response = Unirest.post("http://localhost:3000/v1/contacts/", paramaters: params)
    contact = response.body
    puts JSON.pretty_generate(contact)

  elsif input_option == "4"
    print "Please input a contact ID to update"
    contact_id = gets.chomp
    response = Unirest.get("http://localhost:3000/v1/contacts#{contact_id}")
    params = {}
    print "Please enter the updated first name (#{contact[first_name]})"
    params["first_name"] = gets.chomp
    print "Please enter the updated last name (#{contact[last_name]})"
    params["last_name"] = gets.chomp
    print "Please enter the updated email"
    params["email"] = gets.chomp
    print "Please enter the updated phone number (#{contact[phone_number]})"
    params["phone_number"] = gets.chomp
    params.delete_if { |_key, value| value.empty? }
    updated_contact = response.body
    puts JSON.pretty_generate(updated_contact)

  elsif input_option == "5"
    print "Please enter a contact ID to delete"
    contact_id = gets.chomp
    response = Unirest.delete("http://localhost:3000/v1/contacts#{contact_id}")
    contact = response.body
    puts JSON.pretty_generate(contact)
    
  elsif puts "Not a valid input."
end
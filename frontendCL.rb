require "unirest"

system "clear"
puts "Welcome to the Contacts app! Choose an option:"
puts "[signup] Signup (create a user)"
puts "[login] Login (create a JSON web token)"
puts "[logout] Logout (delete the JSON web token)"

input_option = gets.chomp

if input_option == "signup"
  print "Please enter your name: "
  input_name = gets.chomp
  print "Please enter your email: "
  input_email = gets.chomp
  print "Please enter a password: "
  input_password = gets.chomp
  print "Please confirm your password: "
  input_password_confirmation = gets.chomp

  params = 
  {
    name: "#{input_name}",
    email: "#{input_email}",
    password: "#{input_password}",
    password_confirmation: "#{input_password_confirmation}"
  }
  response = Unirest.post("http://localhost:3000/v1/users", parameters: params)
  p response.body

elsif input_option == "login"
  print "Please enter your login email: "
  input_email = gets.chomp
  print "Please enter your login password: "
  input_password = gets.chomp
  response = Unirest.post(
    "http://localhost:3000/user_token",
    parameters: {
      auth: {
        email: "#{input_email}",
        password: "#{input_password}"
      }
    }
  )
  jwt = response.body["jwt"]
  Unirest.default_header("Authorization", "Bearer #{jwt}")

elsif input_option == "logout"
  jwt = ""
  Unirest.clear_default_headers()
end
    

system "clear"

p jwt
puts "Select an option"
puts "[1] Show all contacts"
puts "[1b] Search for contact by first name (Kevin)"
puts "[2] Show one contact"
puts "[3] Create a new contact"
puts "[4] Update existing contact"
puts "[5] Delete existing contact"

input_option = gets.chomp

if input_option == "1"
  response = Unirest.get("http://localhost:3000/v1/contacts")
  contacts = response.body
  puts JSON.pretty_generate(contacts)

elsif input_option == "1b"
  q = gets.chomp
  response = Unirest.get("http://localhost:3000/v1/contacts?q=#{q}")
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
  print "Please enter contact's middle name: "
  params["middle_name"] = gets.chomp
  print "Please enter contact's last name: "
  params["last_name"] = gets.chomp
  print "Please enter contact's email: "
  params["email"] = gets.chomp
  print "Please enter contact's phone number: "
  params["phone_number"] = gets.chomp
  print "Please enter a bio for the contact: "
  params["bio"] = gets.chomp
  response = Unirest.post("http://localhost:3000/v1/contacts/", parameters: params)
  contact = response.body
  if contact["errors"]
    puts "Uh Oh! Something went wrong..."
    p contact["errors"]
  else 
    puts "Here is your contact info"
    puts JSON.pretty_generate(contact)
  end

elsif input_option == "4"
  print "Please input a contact ID to update: "
  contact_id = gets.chomp
  response = Unirest.get("http://localhost:3000/v1/contacts/#{contact_id}")
  contact = response.body
  params = {}
  print "Please enter the updated first name (#{contact["first_name"]}): "
  params["first_name"] = gets.chomp
  print "Please enter the updated middle name (#{contact["middle_name"]}): "
  params["middle_name"] = gets.chomp
  print "Please enter the updated last name (#{contact["last_name"]}): "
  params["last_name"] = gets.chomp
  print "Please enter the updated email (#{contact["email"]}): "
  params["email"] = gets.chomp
  print "Please enter the updated phone number (#{contact["phone_number"]}): "
  params["phone_number"] = gets.chomp
  print "Please enter an updated bio for this contact (#{contact["bio"]}): "
  params["bio"] = gets.chomp
  params.delete_if { |_key, value| value.empty? }
  response = Unirest.patch("http://localhost:3000/v1/contacts/#{contact_id}", parameters: params)
  updated_contact = response.body
  if updated_contact["errors"]
    puts "Uh Oh! Something went wrong..."
    p updated_contact["errors"]
  else 
    puts "Here is your contact info"
    puts JSON.pretty_generate(updated_contact)
  end

elsif input_option == "5"
  print "Please enter a contact ID to delete"
  contact_id = gets.chomp
  response = Unirest.delete("http://localhost:3000/v1/contacts/#{contact_id}")
  contact = response.body
  puts JSON.pretty_generate(contact)

elsif puts "Not a valid input."
end
class V1::ContactsController < ApplicationController

  def index
    contacts = Contact.all
    render json: contacts.as_json
  end

  def show
    contact = Contact.find_by(id: params["id"])
    render json: contact.as_json
  end

  def create
    contact = Contact.new(
      first_name: params[:first_name],
      middle_name: params[:middle_name],
      last_name: params[:last_name],
      email: params[:email],
      phone_number: params[:phone_number],
      bio: params[:bio]
    )
    if contact.save
      render json: contact.as_json
    else render json: {errors: contact.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def update
    contact = Contact.find_by(id: params[:id])
    contact.first_name = params[:first_name] || contact.first_name
    contact.middle_name = params[:middle_name] || contact.middle_name
    contact.last_name = params[:last_name] || contact.last_name
    contact.email = params[:email] || contact.email
    contact.phone_number = params[:phone_number] || contact.phone_number
    contact.bio = params[:bio] || contact.bio
    if contact.save
      render json: contact.as_json
    else render json: {errors: contact.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def destroy
    contact = Contact.find_by(id: params["id"])
    contact.destroy
    render json: {message: "Contact has been deleted."}
  end
end
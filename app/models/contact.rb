class Contact < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true, format: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

  def friendly_updated_at
    updated_at.strftime("%B %e, %Y")
  end

  def full_name
    full_name = ""
    full_name += "#{first_name} "
    full_name += "#{middle_name}"
    full_name += "#{last_name}"
    full_name
  end

  def japan_phone_code
    jphone_number = ""
    jphone_number += "+81 "
    jphone_number += "#{phone_number}"
    jphone_number
  end

  def as_json
    {
      id: id,
      first_name: first_name,
      middle_name: middle_name,
      last_name: last_name,
      full_name: full_name,
      email: email,
      phone_number: japan_phone_code,
      bio: bio,
      updated_at: friendly_updated_at
    }
  end

end
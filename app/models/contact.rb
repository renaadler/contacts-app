class Contact < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: true
  belongs_to :user
  has_many :contact_groups
  has_many :groups, through: :contact_groups
  
  def friendly_created_at
    created_at.strftime("%B %e, %Y")
  end

  def full_name
    "#{first_name} #{middle_name} #{last_name}"
  end

  def racist
    " +81 " + phone_number.to_s
  end
end

class Phone < ApplicationRecord
  belongs_to :user, optional: true
  validates :phone, presence: true, uniqueness: true
  validates :country, presence: true
  validate :valid

  def valid
    errors.add(:phone, 'Phone is not valid for country!') unless TelephoneNumber.parse(self.phone, self.country).valid?
  end
end

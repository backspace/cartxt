class Txt < ActiveRecord::Base
  belongs_to :originator, class_name: "Txt"
  has_many :responses, foreign_key: "originator_id", class_name: "Txt"

  scope :originals, ->{ where(originator_id: nil) }
end

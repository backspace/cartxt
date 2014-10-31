class Txt < ActiveRecord::Base
  belongs_to :originator, class_name: "Txt"
end

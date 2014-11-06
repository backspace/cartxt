class Transaction < ActiveRecord::Base
  belongs_to :origin, polymorphic: true
  belongs_to :sharer
end

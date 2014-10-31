class AddOriginatorToTxt < ActiveRecord::Migration
  def change
    add_reference :txts, :originator, index: true
  end
end

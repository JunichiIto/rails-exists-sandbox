class AddParentReferenceToChildren < ActiveRecord::Migration[6.1]
  def change
    add_reference :children, :parent, null: false, foreign_key: true
  end
end

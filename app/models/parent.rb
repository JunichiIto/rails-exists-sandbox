class Parent < ApplicationRecord
  has_many :children

  # scope :children_name_with, -> (str) do
  #   left_outer_joins(:children).where("LOWER(children.name) LIKE ?", "%#{str.downcase}%").distinct
  # end

  scope :children_name_with, -> (str) do
    sql = <<~SQL
      EXISTS(
        SELECT *
        FROM children c
        WHERE c.parent_id = parents.id
        AND LOWER(c.name) LIKE ?
      )
    SQL
    where(sql, "%#{str}%")
  end
end

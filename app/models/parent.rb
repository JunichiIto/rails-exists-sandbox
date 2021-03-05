class Parent < ApplicationRecord
  has_many :children

  # scope :children_name_with, -> (str) do
  #   joins(:children).where("LOWER(children.name) LIKE ?", "%#{str.downcase}%").distinct
  # end

  # scope :children_name_with, -> (str) do
  #   ids = Child.where("LOWER(children.name) LIKE ?", "%#{str.downcase}%").select(:parent_id)
  #   where(id: ids)
  # end

  scope :children_name_with, -> (str) do
    # sql = <<~SQL
    #   EXISTS (
    #     SELECT *
    #     FROM children c
    #     WHERE c.parent_id = parents.id
    #     AND LOWER(c.name) LIKE ?
    #   )
    # SQL
    # where(sql, "%#{str.downcase}%")
    where(
      'EXISTS (:children)',
      children: Child.where(
        "children.parent_id = parents.id AND LOWER(children.name) LIKE ?",
        "%#{str.downcase}%"
      )
    )
  end

  # scope :without_children, -> do
  #   left_outer_joins(:children).where(children: { id: nil })
  # end

  scope :without_children, -> do
    # sql = <<~SQL
    #   NOT EXISTS (
    #     SELECT *
    #     FROM children c
    #     WHERE c.parent_id = parents.id
    #   )
    # SQL
    # where(sql)
    where('NOT EXISTS (:children)', children: Child.where("children.parent_id = parents.id"))
  end

  # scope :without_children, -> do
  #   ids = Child.select(:parent_id)
  #   where.not(id: ids)
  # end
end

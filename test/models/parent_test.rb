require "test_helper"

class ParentTest < ActiveSupport::TestCase
  test ".children_name_with" do
    parents = Parent.children_name_with('z').order(:name)
    assert_equal [parents(:namihei)], parents

    parents = Parent.children_name_with('k').order(:name)
    assert_equal [parents(:misae), parents(:namihei)], parents

    parents = Parent.children_name_with('r').order(:name)
    assert_equal [parents(:misae)], parents
  end
end

require "test_helper"

class ParentTest < ActiveSupport::TestCase
  test "zで検索" do
    # Sazaeが該当するのでNamiheiが返る
    parents = Parent.children_name_with('z').order(:name)
    assert_equal [parents(:namihei)], parents
  end

  test "kで検索" do
    # ShinnosukeとKatsuoとWakameが該当するのでMisaeとNamiheiが返る
    parents = Parent.children_name_with('k').order(:name)
    assert_equal [parents(:misae), parents(:namihei)], parents
  end

  test "rで検索" do
    # Himawariが該当するのでMisaeが返る
    parents = Parent.children_name_with('r').order(:name)
    assert_equal [parents(:misae)], parents
  end

  test ".without_children" do
    parents = Parent.without_children.order(:name)
    assert_equal [parents(:golgo13)], parents
  end
end

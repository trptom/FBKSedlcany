require 'test_helper'

class ArticleCategoryTest < ActiveSupport::TestCase
  test "create" do
    @ac = ArticleCategory.new
    @ac.name = "Example"
    @ac.desctiption = "fas fhdajsl fhjdalkhfjdla hfjdlahfjdklahfjkldahfl akjdh"

    assert @ac.save
  end
end

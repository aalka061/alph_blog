require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  def setup
    @category = Category.new(name: "sport")
  end 
  
  test "category_should_be_valid" do 
    assert @category.valid?
  end 
  
  
end
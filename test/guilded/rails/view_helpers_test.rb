require 'test_helper'

class ViewHelpersTest < Test::Unit::TestCase
  
  context "The browser detector view helpers" do
    setup do
      @view = ViewProxy.new
    end
    
    #should "output the correct browser name" do
    #  assert @view.browser_name == ''
    #end
    
    should "be true" do
      assert true
    end
  end
  
end

class ViewProxy
  include Guilded::Rails::ViewHelpers
end
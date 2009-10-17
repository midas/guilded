require 'test_helper'

class ViewHelpersTest < Test::Unit::TestCase
  
  context "The browser detector view helpers" do
    setup do
      @view = View.new
    end
    
    should "resolve the correct browser name" do
      assert_equal 'firefox', @view.g_browser_name
    end
    
    should "resolve the correct g_browser_version" do
      assert_equal '3.5.3', @view.g_browser_version
    end
    
    should "resolve the correct g_browser_full_name" do
      assert_equal 'Firefox 3.5.3', @view.g_browser_full_name
    end
    
    should "resolve the correct g_browser_version" do
      assert_equal '3.5.3', @view.g_browser_version
    end
    
    should "agree that the browser is :name => :firefox" do
      assert @view.g_browser_is?( :name => :firefox )
    end
    
    should "agree that the browser is :version => '3.5.3'" do
      assert @view.g_browser_is?( :version => '3.5.3' )
    end
    
    should "agree that the browser is :name => :firefox, :version => '3.5.3'" do
      assert @view.g_browser_is?( :name => :firefox, :version => '3.5.3' )
    end
    
    should "agree that the browser is :name => :firefox, :major_version => '3'" do
      assert @view.g_browser_is?( :name => :firefox, :major_version => '3' )
    end
    
    should "agree that the browser is :name => :firefox, :minor_version => '5'" do
      assert @view.g_browser_is?( :name => :firefox, :minor_version => '5' )
    end
    
    should "agree that the browser is :name => :firefox, :build_version => '3'" do
      assert @view.g_browser_is?( :name => :firefox, :build_version => '3' )
    end
    
    should "agree that the browser is :name => :firefox, :revision_version => '0'" do
      assert @view.g_browser_is?( :name => :firefox, :revision_version => '0' )
    end
    
    should "agree that the browser is :name => :firefox, :major_version => '3', :minor_version => '5'" do
      assert @view.g_browser_is?( :name => :firefox, :major_version => '3', :minor_version => '5' )
    end
    
    should "agree that the browser is :name => :firefox, :major_version => '3', :minor_version => '5', :build_version => '3'" do
      assert @view.g_browser_is?( :name => :firefox, :major_version => '3', :minor_version => '5', :build_version => '3' )
    end
    
    should "agree that the browser is :name => :firefox, :major_version => '3', :minor_version => '5', :build_version => '3', :revision_version => '0'" do
      assert @view.g_browser_is?( :name => :firefox, :major_version => '3', :minor_version => '5', :build_version => '3',
        :revision_version => '0' )
    end
    
    should "agree that the browser is :name => :firefox, :major_version => 3" do
      assert @view.g_browser_is?( :name => :firefox, :major_version => 3 )
    end
    
    should "agree that the browser is :name => :firefox, :minor_version => 5" do
      assert @view.g_browser_is?( :name => :firefox, :minor_version => 5 )
    end
    
    should "agree that the browser is :name => :firefox, :build_version => 3" do
      assert @view.g_browser_is?( :name => :firefox, :build_version => 3 )
    end
    
    should "agree that the browser is :name => :firefox, :revision_version => 0" do
      assert @view.g_browser_is?( :name => :firefox, :revision_version => 0 )
    end
    
    should "agree that the browser is :name => :firefox, :major_version => 3, :minor_version => 5" do
      assert @view.g_browser_is?( :name => :firefox, :major_version => 3, :minor_version => 5 )
    end
    
    should "agree that the browser is :name => :firefox, :major_version => 3, :minor_version => 5, :build_version => 3" do
      assert @view.g_browser_is?( :name => :firefox, :major_version => 3, :minor_version => 5, :build_version => 3 )
    end
    
    should "agree that the browser is :name => :firefox, :major_version => 3, :minor_version => 5, :build_version => 3, :revision_version => 0" do
      assert @view.g_browser_is?( :name => :firefox, :major_version => 3, :minor_version => 5, :build_version => 3,
        :revision_version => '0' )
    end
  end
  
end
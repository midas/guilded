require 'test_helper'

class BrowserDetectorTest < Test::Unit::TestCase
  context "The browser detector" do
    setup do
      @user_agents = { 
        :ie55 => 'Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 5.1)', 
        :ie60 => 'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)',
        :ie70 => 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1)',
        :ie80 => 'Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0)',
        :firefox2 => 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X; en-US; rv:1.8.1.17) Gecko/20080829 Firefox/2.0.0.17',
        :firefox3 => 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.0.11) Gecko/2009060214 Firefox/3.0.11',
        :firefox35 => 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.3) Gecko/20090824 Firefox/3.5.3',
        :firefox35win => 'Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.1.3) Gecko/20090824 Firefox/3.5.3 (.NET CLR 3.5.30729)',
        :opera10 => 'Opera/9.80 (Macintosh; Intel Mac OS X; U; en) Presto/2.2.15 Version/10.00'
      }
    end
    
    should "know all of its known browser ids" do
      assert_equal Guilded::BrowserDetector.all_browsers.sort.join( ' ' ), "chrome firefox ie55 ie60 ie70 ie80 konqueror netscape opera safari"
    end
    
    should "know all of its known mobile browser ids" do
      assert_equal Guilded::BrowserDetector.all_mobile_browsers.sort.join( ' ' ), "ie_ce4 iphone"
    end
    
    context "when given Firefox 2.0 user agent" do
      setup do
        @detector = Guilded::BrowserDetector.new( @user_agents[:firefox2] )
        assert !@detector.ua.nil?
      end
      
      should "agree that the browser name is 'firefox'" do
        assert_equal @detector.browser_name, 'firefox'
      end
      
      should "agree that the browser version is '2.0.0.17'" do
        assert_equal @detector.browser_version, '2.0.0.17'
      end
      
      should "agree that the browser major version is '2'" do
        assert_equal @detector.browser_version_major, '2'
      end
      
      should "agree that the browser minor version is '0'" do
        assert_equal @detector.browser_version_minor, '0'
      end
      
      should "have a browser id of 'firefox20017'" do
        assert_equal @detector.browser_id, 'firefox20017'
      end
      
      should "have a browser full name of 'Firefox 2.0.0.17'" do
        assert_equal @detector.browser_full_name, 'Firefox 2.0.0.17'
      end
      
      should "be able to use a png" do
        assert @detector.can_use_png?
      end
      
      should "agree that the browser is :browser => 'firefox'" do
        assert @detector.browser_is?( :name => 'firefox' )
      end
      
      should "agree that the browser is :browser => :firefox" do
        assert @detector.browser_is?( :name => :firefox )
      end
      
      should "agree that the browser is :version => '2.0.0.17'" do
        assert @detector.browser_is?( :version => '2.0.0.17' )
      end
      
      should "agree that the browser is :name => 'firefox' and :version => '2.0.0.17'" do
        assert @detector.browser_is?( :name => 'firefox', :version => '2.0.0.17' )
      end
      
      should "agree that the browser is :name => :firefox and :version => '2.0.0.17'" do
        assert @detector.browser_is?( :name => :firefox, :version => '2.0.0.17' )
      end
    end
    
    context "when given Firefox 3.0 user agent" do
      setup do
        @detector = Guilded::BrowserDetector.new( @user_agents[:firefox3] )
        assert !@detector.ua.nil?
      end
      
      should "agree that the browser name is 'firefox'" do
        assert_equal @detector.browser_name, 'firefox'
      end
      
      should "agree that the browser version is '3.0.11'" do
        assert_equal @detector.browser_version, '3.0.11'
      end
      
      should "agree that the browser major version is '3'" do
        assert_equal @detector.browser_version_major, '3'
      end
      
      should "agree that the browser minor version is '0'" do
        assert_equal @detector.browser_version_minor, '0'
      end
      
      should "have a browser id of 'firefox3011'" do
        assert_equal @detector.browser_id, 'firefox3011'
      end
      
      should "have a browser full name of 'Firefox 3.0.11'" do
        assert_equal @detector.browser_full_name, 'Firefox 3.0.11'
      end
      
      should "be able to use a png" do
        assert @detector.can_use_png?
      end
      
      should "agree that the browser is :browser => 'firefox'" do
        assert @detector.browser_is?( :name => 'firefox' )
      end
      
      should "agree that the browser is :browser => :firefox" do
        assert @detector.browser_is?( :name => :firefox )
      end
      
      should "agree that the browser is :version => '3.0.11'" do
        assert @detector.browser_is?( :version => '3.0.11' )
      end
      
      should "agree that the browser is :name => 'firefox' and :version => '3.0.11'" do
        assert @detector.browser_is?( :name => 'firefox', :version => '3.0.11' )
      end
      
      should "agree that the browser is :name => :firefox and :version => '3.0.11'" do
        assert @detector.browser_is?( :name => :firefox, :version => '3.0.11' )
      end
    end
    
    context "when given Firefox 3.5 user agent" do
      setup do
        @detector = Guilded::BrowserDetector.new( @user_agents[:firefox35] )
        assert !@detector.ua.nil?
      end
      
      should "agree that the browser name is 'firefox'" do
        assert_equal @detector.browser_name, 'firefox'
      end
      
      should "agree that the browser version is '3.5.3'" do
        assert_equal @detector.browser_version, '3.5.3'
      end
      
      should "agree that the browser major version is '3'" do
        assert_equal @detector.browser_version_major, '3'
      end
      
      should "agree that the browser minor version is '5'" do
        assert_equal @detector.browser_version_minor, '5'
      end
      
      should "have a browser id of 'firefox353'" do
        assert_equal @detector.browser_id, 'firefox353'
      end
      
      should "have a browser full name of 'Firefox 3.5.3'" do
        assert_equal @detector.browser_full_name, 'Firefox 3.5.3'
      end
      
      should "be able to use a png" do
        assert @detector.can_use_png?
      end
      
      should "agree that the browser is :browser => 'firefox'" do
        assert @detector.browser_is?( :name => 'firefox' )
      end
      
      should "agree that the browser is :browser => :firefox" do
        assert @detector.browser_is?( :name => :firefox )
      end
      
      should "agree that the browser is :version => '3.5.3'" do
        assert @detector.browser_is?( :version => '3.5.3' )
      end
      
      should "agree that the browser is :name => 'firefox' and :version => '3.5.3'" do
        assert @detector.browser_is?( :name => 'firefox', :version => '3.5.3' )
      end
      
      should "agree that the browser is :name => :firefox and :version => '3.5.3'" do
        assert @detector.browser_is?( :name => :firefox, :version => '3.5.3' )
      end
    end
    
    context "when given Firefox 3.5 Windows user agent" do
      setup do
        @detector = Guilded::BrowserDetector.new( @user_agents[:firefox35win] )
        assert !@detector.ua.nil?
      end
      
      should "agree that the browser name is 'firefox'" do
        assert_equal @detector.browser_name, 'firefox'
      end
      
      should "agree that the browser version is '3.5.3'" do
        assert_equal @detector.browser_version, '3.5.3'
      end
      
      should "agree that the browser major version is '3'" do
        assert_equal @detector.browser_version_major, '3'
      end
      
      should "agree that the browser minor version is '5'" do
        assert_equal @detector.browser_version_minor, '5'
      end
      
      should "have a browser id of 'firefox353'" do
        assert_equal @detector.browser_id, 'firefox353'
      end
      
      should "have a browser full name of 'Firefox 3.5.3'" do
        assert_equal @detector.browser_full_name, 'Firefox 3.5.3'
      end
      
      should "be able to use a png" do
        assert @detector.can_use_png?
      end
      
      should "agree that the browser is :browser => 'firefox'" do
        assert @detector.browser_is?( :name => 'firefox' )
      end
      
      should "agree that the browser is :browser => :firefox" do
        assert @detector.browser_is?( :name => :firefox )
      end
      
      should "agree that the browser is :version => '3.5.3'" do
        assert @detector.browser_is?( :version => '3.5.3' )
      end
      
      should "agree that the browser is :name => 'firefox' and :version => '3.5.3'" do
        assert @detector.browser_is?( :name => 'firefox', :version => '3.5.3' )
      end
      
      should "agree that the browser is :name => :firefox and :version => '3.5.3'" do
        assert @detector.browser_is?( :name => :firefox, :version => '3.5.3' )
      end
    end
    
    context "when given Opera 10.0 user agent" do
      setup do
        @detector = Guilded::BrowserDetector.new( @user_agents[:opera10] )
        assert !@detector.ua.nil?
      end
      
      should "agree that the browser name is 'opera'" do
        assert_equal @detector.browser_name, 'opera'
      end
      
      should "agree that the browser version is '10.00'" do
        assert_equal @detector.browser_version, '10.00'
      end
      
      should "agree that the browser major version is '10'" do
        assert_equal @detector.browser_version_major, '10'
      end
      
      should "agree that the browser minor version is '0'" do
        assert_equal @detector.browser_version_minor, '0'
      end
       
      should "have a browser id of 'opera1000'" do
        assert_equal @detector.browser_id, 'opera1000'
      end
      
      should "have a browser full name of 'Opera 10.00'" do
        assert_equal @detector.browser_full_name, 'Opera 10.00'
      end
       
      should "be able to use a png" do
        assert @detector.can_use_png?
      end

      should "agree that the browser is :browser => 'opera'" do
        assert @detector.browser_is?( :name => 'opera' )
      end
      
      should "agree that the browser is :browser => opera" do
        assert @detector.browser_is?( :name => :opera )
      end
 
      should "agree that the browser is :version => '10.00'" do
        assert @detector.browser_is?( :version => '10.00' )
      end

      should "agree that the browser is :name => 'opera' and :version => '10.00'" do
        assert @detector.browser_is?( :name => 'opera', :version => '10.00' )
      end
      
      should "agree that the browser is :name => :opera and :version => '10.00'" do
        assert @detector.browser_is?( :name => :opera, :version => '10.00' )
      end
    end
    
    context "when given IE 5.5 user agent" do
      setup do
        @detector = Guilded::BrowserDetector.new( @user_agents[:ie55] )
        assert !@detector.ua.nil?
      end
      
      should "agree that the browser name is 'ie'" do
        assert_equal @detector.browser_name, 'ie'
      end
      
      should "agree that the browser version is '5.5'" do
        assert_equal @detector.browser_version, '5.5'
      end
      
      should "agree that the browser major version is '5'" do
        assert_equal @detector.browser_version_major, '5'
      end
      
      should "agree that the browser minor version is '5'" do
        assert_equal @detector.browser_version_minor, '5'
      end
      
      should "have a browser id of 'ie55'" do
        assert_equal @detector.browser_id, 'ie55'
      end
      
      should "have a browser full name of 'Internet Explorer 5.5'" do
        assert_equal @detector.browser_full_name, 'Internet Explorer 5.5'
      end
      
      should "not be able to use a png" do
        assert !@detector.can_use_png?
      end
      
      should "agree that the browser is :browser => 'ie'" do
        assert @detector.browser_is?( :name => 'ie' )
      end
      
      should "agree that the browser is :browser => :ie" do
        assert @detector.browser_is?( :name => :ie )
      end
      
      should "agree that the browser is :version => '5.5'" do
        assert @detector.browser_is?( :version => '5.5' )
      end
      
      should "agree that the browser is :name => 'ie' and :version => '5.5'" do
        assert @detector.browser_is?( :name => 'ie', :version => '5.5' )
      end
      
      should "agree that the browser is :name => :ie and :version => '5.5'" do
        assert @detector.browser_is?( :name => :ie, :version => '5.5' )
      end
    end
    
    context "when given IE 6.0 user agent" do
      setup do
        @detector = Guilded::BrowserDetector.new( @user_agents[:ie60] )
        assert !@detector.ua.nil?
      end
      
      should "agree that the browser name is 'ie'" do
        assert_equal @detector.browser_name, 'ie'
      end
      
      should "agree that the browser version is '6.0'" do
        assert_equal @detector.browser_version, '6.0'
      end
      
      should "agree that the browser major version is '6'" do
        assert_equal @detector.browser_version_major, '6'
      end
      
      should "agree that the browser minor version is '0'" do
        assert_equal @detector.browser_version_minor, '0'
      end
      
      should "have a browser id of 'ie60'" do
        assert_equal @detector.browser_id, 'ie60'
      end
      
      should "have a browser full name of 'Internet Explorer 6.0'" do
        assert_equal @detector.browser_full_name, 'Internet Explorer 6.0'
      end
      
      should "not be able to use a png" do
        assert !@detector.can_use_png?
      end
      
      should "agree that the browser is :browser => 'ie'" do
        assert @detector.browser_is?( :name => 'ie' )
      end
      
      should "agree that the browser is :browser => :ie" do
        assert @detector.browser_is?( :name => :ie )
      end
      
      should "agree that the browser is :version => '6.0'" do
        assert @detector.browser_is?( :version => '6.0' )
      end
      
      should "agree that the browser is :name => 'ie' and :version => '6.0'" do
        assert @detector.browser_is?( :name => 'ie', :version => '6.0' )
      end
      
      should "agree that the browser is :name => :ie and :version => '6.0'" do
        assert @detector.browser_is?( :name => :ie, :version => '6.0' )
      end
    end
    
    context "when given IE 7.0 user agent" do
      setup do
        @detector = Guilded::BrowserDetector.new( @user_agents[:ie70] )
        assert !@detector.ua.nil?
      end
      
      should "agree that the browser name is 'ie'" do
        assert_equal @detector.browser_name, 'ie'
      end
      
      should "agree that the browser version is '7.0'" do
        assert_equal @detector.browser_version, '7.0'
      end
      
      should "agree that the browser major version is '7'" do
        assert_equal @detector.browser_version_major, '7'
      end
      
      should "agree that the browser minor version is '0'" do
        assert_equal @detector.browser_version_minor, '0'
      end
      
      should "have a browser id of 'ie70'" do
        assert_equal @detector.browser_id, 'ie70'
      end
      
      should "have a browser full name of 'Internet Explorer 7.0'" do
        assert_equal @detector.browser_full_name, 'Internet Explorer 7.0'
      end
      
      should "be able to use a png" do
        assert @detector.can_use_png?
      end
      
      should "agree that the browser is :browser => 'ie'" do
        assert @detector.browser_is?( :name => 'ie' )
      end
      
      should "agree that the browser is :browser => :ie" do
        assert @detector.browser_is?( :name => :ie )
      end
      
      should "agree that the browser is :version => '7.0'" do
        assert @detector.browser_is?( :version => '7.0' )
      end
      
      should "agree that the browser is :name => 'ie' and :version => '7.0'" do
        assert @detector.browser_is?( :name => 'ie', :version => '7.0' )
      end
      
      should "agree that the browser is :name => :ie and :version => '7.0'" do
        assert @detector.browser_is?( :name => :ie, :version => '7.0' )
      end
    end
    
    context "when given IE 8.0 user agent" do
      setup do
        @detector = Guilded::BrowserDetector.new( @user_agents[:ie80] )
        assert !@detector.ua.nil?
      end
      
      should "agree that the browser name is 'ie'" do
        assert_equal @detector.browser_name, 'ie'
      end
      
      should "agree that the browser version is '8.0'" do
        assert_equal @detector.browser_version, '8.0'
      end
      
      should "agree that the browser major version is '8'" do
        assert_equal @detector.browser_version_major, '8'
      end
      
      should "agree that the browser minor version is '0'" do
        assert_equal @detector.browser_version_minor, '0'
      end
      
      should "have a browser id of 'ie80'" do
        assert_equal @detector.browser_id, 'ie80'
      end
      
      should "have a browser full name of 'Internet Explorer 8.0'" do
        assert_equal @detector.browser_full_name, 'Internet Explorer 8.0'
      end
      
      should "be able to use a png" do
        assert @detector.can_use_png?
      end
      
      should "agree that the browser is :browser => 'ie'" do
        assert @detector.browser_is?( :name => 'ie' )
      end
      
      should "agree that the browser is :browser => :ie" do
        assert @detector.browser_is?( :name => :ie )
      end
      
      should "agree that the browser is :version => '8.0'" do
        assert @detector.browser_is?( :version => '8.0' )
      end
      
      should "agree that the browser is :name => 'ie' and :version => '8.0'" do
        assert @detector.browser_is?( :name => 'ie', :version => '8.0' )
      end
      
      should "agree that the browser is :name => :ie and :version => '8.0'" do
        assert @detector.browser_is?( :name => :ie, :version => '8.0' )
      end
    end
    
  end
end
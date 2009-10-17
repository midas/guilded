require 'test_helper'

class GuilderTest < Test::Unit::TestCase
  context "The Guilder" do
    setup do
      @g = Guilded::Guilder.instance
    end
    
    should "return an instance" do
      assert_not_nil @g
    end
    
    should "be a singleton" do
      assert_equal @g.initialized_at, Guilded::Guilder.instance.initialized_at
    end
    
    should "have 1 css source after init" do
      assert_equal @g.combined_css_srcs.size, 1
    end
    
    should "have 3 js sources after init" do
      assert_equal @g.combined_js_srcs.size, 3
    end
    
    should "increase count by one when you add a component" do
      count = @g.count
      @g.add( 'grid', { :id => 'grid' } )
      assert_equal @g.count, count + 1
    end
    
    should "respond to add" do
      assert @g.respond_to? :add
    end
    
    should "respond to count" do
      assert @g.respond_to? :count
    end

    should "respond to reset!" do
      assert @g.respond_to? :reset!
    end

    should "respond to apply" do
      assert @g.respond_to? :apply
    end
    
    should "respond to generate_javascript_init" do
      assert @g.respond_to? :generate_javascript_init
    end

    should "respond_to js_cache_name" do
      assert @g.respond_to? :js_cache_name
    end

    should "respond_to css_cache_name" do
      assert @g.respond_to? :css_cache_name
    end
    
    should "respond_to generate_js_cache_name" do
      assert @g.respond_to? :generate_js_cache_name
    end

    should "respond_to generate_css_cache_name" do
      assert @g.respond_to? :generate_css_cache_name
    end

    should "respond_to combined_css_srcs" do
      assert @g.respond_to? :combined_css_srcs
    end

    should "respond_to combined_js_srcs" do
      assert @g.respond_to? :combined_js_srcs
    end

    should "respond_to initialized_at" do
      assert @g.respond_to? :initialized_at
    end
  end
end
require File.dirname(__FILE__) + '/../spec_helper.rb'

describe "Guilder" do
  
  before(:each) do
    @g = Guilded::Guilder.instance
  end
  
  it "should return an instance" do
    @g.should_not be_nil
  end

  it "should be a singleton" do
    @g.initialized_at.should eql Guilded::Guilder.instance.initialized_at
  end
  
  it "should have 1 css source after init" do
    @g.combined_css_srcs.size.should eql 1
  end
  
  it "should have 2 js sources after init" do
    @g.combined_js_srcs.size.should eql 2
  end
  
  it "should increase count by one when you add a component" do
    count = @g.count
    @g.add( 'grid', { :id => 'grid' } )
    @g.count.should eql( count + 1 )
  end

  it "should respond to add" do
    @g.should respond_to :add
  end
  
  it "should respond to count" do
    @g.should respond_to :count
  end
  
  it "should respond to reset!" do
    @g.should respond_to :reset!
  end
  
  it "should respond to apply" do
    @g.should respond_to :apply
  end
  
  it "should respond to generate_javascript_init" do
    @g.should respond_to :generate_javascript_init
  end
  
  it "should respond_to js_cache_name" do
    @g.should respond_to :js_cache_name
  end
  
  it "should respond_to css_cache_name" do
    @g.should respond_to :css_cache_name
  end
  
  it "should respond_to generate_js_cache_name" do
    @g.should respond_to :generate_js_cache_name
  end
  
  it "should respond_to generate_css_cache_name" do
    @g.should respond_to :generate_css_cache_name
  end
  
  it "should respond_to combined_css_srcs" do
    @g.should respond_to :combined_css_srcs
  end
  
  it "should respond_to combined_js_srcs" do
    @g.should respond_to :combined_js_srcs
  end
  
  it "should respond_to initialized_at" do
    @g.should respond_to :initialized_at
  end
  
end

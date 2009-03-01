require File.dirname(__FILE__) + '/../spec_helper.rb'

describe "ComponentDef" do
  
  before(:each) do
    @cd = Guilded::ComponentDef.new( 'grid' )
    @cd_exclude = Guilded::ComponentDef.new( 'grid', { :exclude_css => true, :exclude_js => true } )
  end
  
  it "should exclude css if specified" do
    @cd_exclude.should be_exclude_css
  end
  
  it "should exclude js if specified" do
    @cd_exclude.should be_exclude_js
  end
  
  it "should not exclude css unless specified" do
    @cd.should_not be_exclude_css
  end
  
  it "should not exclude js unless specified" do
    @cd.should_not be_exclude_js
  end
  
end
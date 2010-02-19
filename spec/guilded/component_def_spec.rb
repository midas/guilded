require File.expand_path( File.join( File.dirname(__FILE__), '..', 'spec_helper' ) )

describe Guilded::ComponentDef do
  before :each do
    @cd = Guilded::ComponentDef.new( 'grid' )
    @cd_exclude = Guilded::ComponentDef.new( 'grid', { :exclude_css => true, :exclude_js => true } )
  end
  
  it "should exclude css if specified" do
    @cd_exclude.exclude_css?.should be_true
  end
  
  it "should exclude js if specified" do
    @cd_exclude.exclude_js?.should be_true
  end

  it "should not exclude css unless specified" do
    @cd.exclude_css?.should be_false
  end

  it "should not exclude js unless specified" do
    @cd.exclude_js?.should be_false
  end
end
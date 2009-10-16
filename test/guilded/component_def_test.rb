require 'test_helper'

class ComponentDefTest < Test::Unit::TestCase
  context "The ComponentDef" do
    setup do
      @cd = Guilded::ComponentDef.new( 'grid' )
      @cd_exclude = Guilded::ComponentDef.new( 'grid', { :exclude_css => true, :exclude_js => true } )
    end

    should "exclude css if specified" do
      assert @cd_exclude.exclude_css?
    end
    
    should "exclude js if specified" do
      assert @cd_exclude.exclude_js?
    end

    should "not exclude css unless specified" do
      assert !@cd.exclude_css?
    end

    should "not exclude js unless specified" do
      assert !@cd.exclude_js?
    end
  end
end
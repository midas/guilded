require File.dirname(__FILE__) + '/../../spec_helper.rb'

describe "Guilded::Rails::Helpers" do
  
  before(:each) do
   class Thing
   end
   @thing = Thing.new
   @things = [Thing.new, Thing.new]
  end
  
  it "should have class method resolve_field_methods_and_titles" do
    Guilded::Rails::Helpers.should respond_to( :resolve_field_methods_and_titles )
  end
  
  it "should have class method resolve_rest_path_helpers" do
    Guilded::Rails::Helpers.should respond_to( :resolve_rest_path_helpers )
  end
  
  it "should resolve single level REST paths given ActiveRecord object" do
    path_helpers = Guilded::Rails::Helpers.resolve_rest_path_helpers( @thing )
    path_helpers[:index_rest_helper].should eql( 'things_path' )
    path_helpers[:index_rest_args].should eql( [] )
    path_helpers[:show_rest_helper].should eql( 'thing_path' )
    path_helpers[:show_rest_args].should eql( [@thing] )
    path_helpers[:new_rest_helper].should eql( 'new_thing_path' )
    path_helpers[:new_rest_args].should eql( [] )
    path_helpers[:edit_rest_helper].should eql( 'edit_thing_path' )
    path_helpers[:edit_rest_args].should eql( [@thing] )
    path_helpers[:delete_rest_helper].should eql( 'delete_thing_path' )
    path_helpers[:delete_rest_args].should eql( [@thing] )
  end
  
  it "should resolve single level REST paths given ActiveRecord collection" do
    path_helpers = Guilded::Rails::Helpers.resolve_rest_path_helpers( @things )
    path_helpers[:index_rest_helper].should eql( 'things_path' )
    path_helpers[:index_rest_args].should eql( [] )
    path_helpers[:show_rest_helper].should eql( 'thing_path' )
    path_helpers[:show_rest_args].should eql( [@things[0]] )
    path_helpers[:new_rest_helper].should eql( 'new_thing_path' )
    path_helpers[:new_rest_args].should eql( [] )
    path_helpers[:edit_rest_helper].should eql( 'edit_thing_path' )
    path_helpers[:edit_rest_args].should eql( [@things[0]] )
    path_helpers[:delete_rest_helper].should eql( 'delete_thing_path' )
    path_helpers[:delete_rest_args].should eql( [@things[0]] )
  end
  
end
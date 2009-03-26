require File.dirname(__FILE__) + '/../../spec_helper.rb'

describe "Guilded::Rails::Helpers" do
  
  before(:each) do
   class Thing
   end
   class Owner
   end
   class Parent
   end
   class Lookup
   end
   @thing = Thing.new
   @things = [Thing.new, Thing.new]
   @parent = Parent.new
   @owner = Owner.new
   @lookup = Lookup.new
   @lookups = [Lookup.new, Lookup.new]
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
    path_helpers[:show_rest_args].should eql( [] )
    path_helpers[:new_rest_helper].should eql( 'new_thing_path' )
    path_helpers[:new_rest_args].should eql( [] )
    path_helpers[:edit_rest_helper].should eql( 'edit_thing_path' )
    path_helpers[:edit_rest_args].should eql( [] )
    path_helpers[:delete_rest_helper].should eql( 'delete_thing_path' )
    path_helpers[:delete_rest_args].should eql( [] )
  end
  
  it "should resolve single level REST paths given ActiveRecord collection" do
    path_helpers = Guilded::Rails::Helpers.resolve_rest_path_helpers( @things )
    path_helpers[:index_rest_helper].should eql( 'things_path' )
    path_helpers[:index_rest_args].should eql( [] )
    path_helpers[:show_rest_helper].should eql( 'thing_path' )
    path_helpers[:show_rest_args].should eql( [] )
    path_helpers[:new_rest_helper].should eql( 'new_thing_path' )
    path_helpers[:new_rest_args].should eql( [] )
    path_helpers[:edit_rest_helper].should eql( 'edit_thing_path' )
    path_helpers[:edit_rest_args].should eql( [] )
    path_helpers[:delete_rest_helper].should eql( 'delete_thing_path' )
    path_helpers[:delete_rest_args].should eql( [] )
  end
  
  it "should resolve nested REST paths given ActiveRecord object and scoped by single object" do
    path_helpers = Guilded::Rails::Helpers.resolve_rest_path_helpers( @thing, :scoped_by => @parent )
    path_helpers[:index_rest_helper].should eql( 'parent_things_path' )
    path_helpers[:index_rest_args].should eql( [@parent] )
    path_helpers[:show_rest_helper].should eql( 'parent_thing_path' )
    path_helpers[:show_rest_args].should eql( [@parent] )
    path_helpers[:new_rest_helper].should eql( 'new_parent_thing_path' )
    path_helpers[:new_rest_args].should eql( [@parent] )
    path_helpers[:edit_rest_helper].should eql( 'edit_parent_thing_path' )
    path_helpers[:edit_rest_args].should eql( [@parent] )
    path_helpers[:delete_rest_helper].should eql( 'delete_parent_thing_path' )
    path_helpers[:delete_rest_args].should eql( [@parent] )
  end
  
  it "should resolve nested REST paths given ActiveRecord collection and scoped by single object" do
    path_helpers = Guilded::Rails::Helpers.resolve_rest_path_helpers( @things, :scoped_by => @parent )
    path_helpers[:index_rest_helper].should eql( 'parent_things_path' )
    path_helpers[:index_rest_args].should eql( [@parent] )
    path_helpers[:show_rest_helper].should eql( 'parent_thing_path' )
    path_helpers[:show_rest_args].should eql( [@parent] )
    path_helpers[:new_rest_helper].should eql( 'new_parent_thing_path' )
    path_helpers[:new_rest_args].should eql( [@parent] )
    path_helpers[:edit_rest_helper].should eql( 'edit_parent_thing_path' )
    path_helpers[:edit_rest_args].should eql( [@parent] )
    path_helpers[:delete_rest_helper].should eql( 'delete_parent_thing_path' )
    path_helpers[:delete_rest_args].should eql( [@parent] )
  end
  
  it "should resolve nested REST paths given ActiveRecord object and scoped by single object array" do
    path_helpers = Guilded::Rails::Helpers.resolve_rest_path_helpers( @thing, :scoped_by => [@parent] )
    path_helpers[:index_rest_helper].should eql( 'parent_things_path' )
    path_helpers[:index_rest_args].should eql( [@parent] )
    path_helpers[:show_rest_helper].should eql( 'parent_thing_path' )
    path_helpers[:show_rest_args].should eql( [@parent] )
    path_helpers[:new_rest_helper].should eql( 'new_parent_thing_path' )
    path_helpers[:new_rest_args].should eql( [@parent] )
    path_helpers[:edit_rest_helper].should eql( 'edit_parent_thing_path' )
    path_helpers[:edit_rest_args].should eql( [@parent] )
    path_helpers[:delete_rest_helper].should eql( 'delete_parent_thing_path' )
    path_helpers[:delete_rest_args].should eql( [@parent] )
  end
  
  it "should resolve nested REST paths given ActiveRecord collection and scoped by single object array" do
    path_helpers = Guilded::Rails::Helpers.resolve_rest_path_helpers( @things, :scoped_by => [@parent] )
    path_helpers[:index_rest_helper].should eql( 'parent_things_path' )
    path_helpers[:index_rest_args].should eql( [@parent] )
    path_helpers[:show_rest_helper].should eql( 'parent_thing_path' )
    path_helpers[:show_rest_args].should eql( [@parent] )
    path_helpers[:new_rest_helper].should eql( 'new_parent_thing_path' )
    path_helpers[:new_rest_args].should eql( [@parent] )
    path_helpers[:edit_rest_helper].should eql( 'edit_parent_thing_path' )
    path_helpers[:edit_rest_args].should eql( [@parent] )
    path_helpers[:delete_rest_helper].should eql( 'delete_parent_thing_path' )
    path_helpers[:delete_rest_args].should eql( [@parent] )
  end
  
  it "should resolve nested REST paths given ActiveRecord object and scoped by multiple object array" do
    path_helpers = Guilded::Rails::Helpers.resolve_rest_path_helpers( @thing, :scoped_by => [@owner, @parent] )
    path_helpers[:index_rest_helper].should eql( 'owner_parent_things_path' )
    path_helpers[:index_rest_args].should eql( [@owner, @parent] )
    path_helpers[:show_rest_helper].should eql( 'owner_parent_thing_path' )
    path_helpers[:show_rest_args].should eql( [@owner, @parent] )
    path_helpers[:new_rest_helper].should eql( 'new_owner_parent_thing_path' )
    path_helpers[:new_rest_args].should eql( [@owner, @parent] )
    path_helpers[:edit_rest_helper].should eql( 'edit_owner_parent_thing_path' )
    path_helpers[:edit_rest_args].should eql( [@owner, @parent] )
    path_helpers[:delete_rest_helper].should eql( 'delete_owner_parent_thing_path' )
    path_helpers[:delete_rest_args].should eql( [@owner, @parent] )
  end
  
  it "should resolve nested REST paths given ActiveRecord collection and scoped by multiple object array" do
    path_helpers = Guilded::Rails::Helpers.resolve_rest_path_helpers( @things, :scoped_by => [@owner, @parent] )
    path_helpers[:index_rest_helper].should eql( 'owner_parent_things_path' )
    path_helpers[:index_rest_args].should eql( [@owner, @parent] )
    path_helpers[:show_rest_helper].should eql( 'owner_parent_thing_path' )
    path_helpers[:show_rest_args].should eql( [@owner, @parent] )
    path_helpers[:new_rest_helper].should eql( 'new_owner_parent_thing_path' )
    path_helpers[:new_rest_args].should eql( [@owner, @parent] )
    path_helpers[:edit_rest_helper].should eql( 'edit_owner_parent_thing_path' )
    path_helpers[:edit_rest_args].should eql( [@owner, @parent] )
    path_helpers[:delete_rest_helper].should eql( 'delete_owner_parent_thing_path' )
    path_helpers[:delete_rest_args].should eql( [@owner, @parent] )
  end
  
  # Namespaced
  
  it "should resolve single level REST paths given ActiveRecord object and namespace symbol" do
    path_helpers = Guilded::Rails::Helpers.resolve_rest_path_helpers( @thing, :namespace => :admin )
    path_helpers[:index_rest_helper].should eql( 'admin_things_path' )
    path_helpers[:index_rest_args].should eql( [] )
    path_helpers[:show_rest_helper].should eql( 'admin_thing_path' )
    path_helpers[:show_rest_args].should eql( [] )
    path_helpers[:new_rest_helper].should eql( 'new_admin_thing_path' )
    path_helpers[:new_rest_args].should eql( [] )
    path_helpers[:edit_rest_helper].should eql( 'edit_admin_thing_path' )
    path_helpers[:edit_rest_args].should eql( [] )
    path_helpers[:delete_rest_helper].should eql( 'delete_admin_thing_path' )
    path_helpers[:delete_rest_args].should eql( [] )
  end
  
  it "should resolve single level REST paths given ActiveRecord object and namespace string" do
    path_helpers = Guilded::Rails::Helpers.resolve_rest_path_helpers( @thing, :namespace => 'admin' )
    path_helpers[:index_rest_helper].should eql( 'admin_things_path' )
    path_helpers[:index_rest_args].should eql( [] )
    path_helpers[:show_rest_helper].should eql( 'admin_thing_path' )
    path_helpers[:show_rest_args].should eql( [] )
    path_helpers[:new_rest_helper].should eql( 'new_admin_thing_path' )
    path_helpers[:new_rest_args].should eql( [] )
    path_helpers[:edit_rest_helper].should eql( 'edit_admin_thing_path' )
    path_helpers[:edit_rest_args].should eql( [] )
    path_helpers[:delete_rest_helper].should eql( 'delete_admin_thing_path' )
    path_helpers[:delete_rest_args].should eql( [] )
  end
  
  it "should resolve single level REST paths given ActiveRecord collection and namespace symbol" do
    path_helpers = Guilded::Rails::Helpers.resolve_rest_path_helpers( @things, :namespace => :admin )
    path_helpers[:index_rest_helper].should eql( 'admin_things_path' )
    path_helpers[:index_rest_args].should eql( [] )
    path_helpers[:show_rest_helper].should eql( 'admin_thing_path' )
    path_helpers[:show_rest_args].should eql( [] )
    path_helpers[:new_rest_helper].should eql( 'new_admin_thing_path' )
    path_helpers[:new_rest_args].should eql( [] )
    path_helpers[:edit_rest_helper].should eql( 'edit_admin_thing_path' )
    path_helpers[:edit_rest_args].should eql( [] )
    path_helpers[:delete_rest_helper].should eql( 'delete_admin_thing_path' )
    path_helpers[:delete_rest_args].should eql( [] )
  end
  
  it "should resolve single level REST paths given ActiveRecord collection and namespace string" do
    path_helpers = Guilded::Rails::Helpers.resolve_rest_path_helpers( @things, :namespace => 'admin' )
    path_helpers[:index_rest_helper].should eql( 'admin_things_path' )
    path_helpers[:index_rest_args].should eql( [] )
    path_helpers[:show_rest_helper].should eql( 'admin_thing_path' )
    path_helpers[:show_rest_args].should eql( [] )
    path_helpers[:new_rest_helper].should eql( 'new_admin_thing_path' )
    path_helpers[:new_rest_args].should eql( [] )
    path_helpers[:edit_rest_helper].should eql( 'edit_admin_thing_path' )
    path_helpers[:edit_rest_args].should eql( [] )
    path_helpers[:delete_rest_helper].should eql( 'delete_admin_thing_path' )
    path_helpers[:delete_rest_args].should eql( [] )
  end
  
  it "should resolve nested REST paths given ActiveRecord object and scoped by single object and namespace symbol" do
    path_helpers = Guilded::Rails::Helpers.resolve_rest_path_helpers( @thing, :scoped_by => @parent, :namespace => :admin )
    path_helpers[:index_rest_helper].should eql( 'admin_parent_things_path' )
    path_helpers[:index_rest_args].should eql( [@parent] )
    path_helpers[:show_rest_helper].should eql( 'admin_parent_thing_path' )
    path_helpers[:show_rest_args].should eql( [@parent] )
    path_helpers[:new_rest_helper].should eql( 'new_admin_parent_thing_path' )
    path_helpers[:new_rest_args].should eql( [@parent] )
    path_helpers[:edit_rest_helper].should eql( 'edit_admin_parent_thing_path' )
    path_helpers[:edit_rest_args].should eql( [@parent] )
    path_helpers[:delete_rest_helper].should eql( 'delete_admin_parent_thing_path' )
    path_helpers[:delete_rest_args].should eql( [@parent] )
  end
  
  it "should resolve nested REST paths given ActiveRecord object and scoped by single object and namespace string" do
    path_helpers = Guilded::Rails::Helpers.resolve_rest_path_helpers( @thing, :scoped_by => @parent, :namespace => 'admin' )
    path_helpers[:index_rest_helper].should eql( 'admin_parent_things_path' )
    path_helpers[:index_rest_args].should eql( [@parent] )
    path_helpers[:show_rest_helper].should eql( 'admin_parent_thing_path' )
    path_helpers[:show_rest_args].should eql( [@parent] )
    path_helpers[:new_rest_helper].should eql( 'new_admin_parent_thing_path' )
    path_helpers[:new_rest_args].should eql( [@parent] )
    path_helpers[:edit_rest_helper].should eql( 'edit_admin_parent_thing_path' )
    path_helpers[:edit_rest_args].should eql( [@parent] )
    path_helpers[:delete_rest_helper].should eql( 'delete_admin_parent_thing_path' )
    path_helpers[:delete_rest_args].should eql( [@parent] )
  end
  
  it "should resolve nested REST paths given ActiveRecord collection and scoped by single object and namespace symbol" do
    path_helpers = Guilded::Rails::Helpers.resolve_rest_path_helpers( @things, :scoped_by => @parent, :namespace => :admin )
    path_helpers[:index_rest_helper].should eql( 'admin_parent_things_path' )
    path_helpers[:index_rest_args].should eql( [@parent] )
    path_helpers[:show_rest_helper].should eql( 'admin_parent_thing_path' )
    path_helpers[:show_rest_args].should eql( [@parent] )
    path_helpers[:new_rest_helper].should eql( 'new_admin_parent_thing_path' )
    path_helpers[:new_rest_args].should eql( [@parent] )
    path_helpers[:edit_rest_helper].should eql( 'edit_admin_parent_thing_path' )
    path_helpers[:edit_rest_args].should eql( [@parent] )
    path_helpers[:delete_rest_helper].should eql( 'delete_admin_parent_thing_path' )
    path_helpers[:delete_rest_args].should eql( [@parent] )
  end
  
  it "should resolve nested REST paths given ActiveRecord collection and scoped by single object and namespace string" do
    path_helpers = Guilded::Rails::Helpers.resolve_rest_path_helpers( @things, :scoped_by => @parent, :namespace => 'admin' )
    path_helpers[:index_rest_helper].should eql( 'admin_parent_things_path' )
    path_helpers[:index_rest_args].should eql( [@parent] )
    path_helpers[:show_rest_helper].should eql( 'admin_parent_thing_path' )
    path_helpers[:show_rest_args].should eql( [@parent] )
    path_helpers[:new_rest_helper].should eql( 'new_admin_parent_thing_path' )
    path_helpers[:new_rest_args].should eql( [@parent] )
    path_helpers[:edit_rest_helper].should eql( 'edit_admin_parent_thing_path' )
    path_helpers[:edit_rest_args].should eql( [@parent] )
    path_helpers[:delete_rest_helper].should eql( 'delete_admin_parent_thing_path' )
    path_helpers[:delete_rest_args].should eql( [@parent] )
  end
  
  it "should resolve nested REST paths given ActiveRecord object and scoped by single object array and namespace symbol" do
    path_helpers = Guilded::Rails::Helpers.resolve_rest_path_helpers( @thing, :scoped_by => [@parent], :namespace => :admin )
    path_helpers[:index_rest_helper].should eql( 'admin_parent_things_path' )
    path_helpers[:index_rest_args].should eql( [@parent] )
    path_helpers[:show_rest_helper].should eql( 'admin_parent_thing_path' )
    path_helpers[:show_rest_args].should eql( [@parent] )
    path_helpers[:new_rest_helper].should eql( 'new_admin_parent_thing_path' )
    path_helpers[:new_rest_args].should eql( [@parent] )
    path_helpers[:edit_rest_helper].should eql( 'edit_admin_parent_thing_path' )
    path_helpers[:edit_rest_args].should eql( [@parent] )
    path_helpers[:delete_rest_helper].should eql( 'delete_admin_parent_thing_path' )
    path_helpers[:delete_rest_args].should eql( [@parent] )
  end
  
  it "should resolve nested REST paths given ActiveRecord object and scoped by single object array and namespace string" do
    path_helpers = Guilded::Rails::Helpers.resolve_rest_path_helpers( @thing, :scoped_by => [@parent], :namespace => 'admin' )
    path_helpers[:index_rest_helper].should eql( 'admin_parent_things_path' )
    path_helpers[:index_rest_args].should eql( [@parent] )
    path_helpers[:show_rest_helper].should eql( 'admin_parent_thing_path' )
    path_helpers[:show_rest_args].should eql( [@parent] )
    path_helpers[:new_rest_helper].should eql( 'new_admin_parent_thing_path' )
    path_helpers[:new_rest_args].should eql( [@parent] )
    path_helpers[:edit_rest_helper].should eql( 'edit_admin_parent_thing_path' )
    path_helpers[:edit_rest_args].should eql( [@parent] )
    path_helpers[:delete_rest_helper].should eql( 'delete_admin_parent_thing_path' )
    path_helpers[:delete_rest_args].should eql( [@parent] )
  end
  
  it "should resolve nested REST paths given ActiveRecord collection and scoped by single object array and namespace symbol" do
    path_helpers = Guilded::Rails::Helpers.resolve_rest_path_helpers( @things, :scoped_by => [@parent], :namespace => :admin )
    path_helpers[:index_rest_helper].should eql( 'admin_parent_things_path' )
    path_helpers[:index_rest_args].should eql( [@parent] )
    path_helpers[:show_rest_helper].should eql( 'admin_parent_thing_path' )
    path_helpers[:show_rest_args].should eql( [@parent] )
    path_helpers[:new_rest_helper].should eql( 'new_admin_parent_thing_path' )
    path_helpers[:new_rest_args].should eql( [@parent] )
    path_helpers[:edit_rest_helper].should eql( 'edit_admin_parent_thing_path' )
    path_helpers[:edit_rest_args].should eql( [@parent] )
    path_helpers[:delete_rest_helper].should eql( 'delete_admin_parent_thing_path' )
    path_helpers[:delete_rest_args].should eql( [@parent] )
  end
  
  it "should resolve nested REST paths given ActiveRecord collection and scoped by single object array and namespace string" do
    path_helpers = Guilded::Rails::Helpers.resolve_rest_path_helpers( @things, :scoped_by => [@parent], :namespace => 'admin' )
    path_helpers[:index_rest_helper].should eql( 'admin_parent_things_path' )
    path_helpers[:index_rest_args].should eql( [@parent] )
    path_helpers[:show_rest_helper].should eql( 'admin_parent_thing_path' )
    path_helpers[:show_rest_args].should eql( [@parent] )
    path_helpers[:new_rest_helper].should eql( 'new_admin_parent_thing_path' )
    path_helpers[:new_rest_args].should eql( [@parent] )
    path_helpers[:edit_rest_helper].should eql( 'edit_admin_parent_thing_path' )
    path_helpers[:edit_rest_args].should eql( [@parent] )
    path_helpers[:delete_rest_helper].should eql( 'delete_admin_parent_thing_path' )
    path_helpers[:delete_rest_args].should eql( [@parent] )
  end
  
  it "should resolve nested REST paths given ActiveRecord object and scoped by multiple object array and namespace symbol" do
    path_helpers = Guilded::Rails::Helpers.resolve_rest_path_helpers( @thing, :scoped_by => [@owner, @parent], :namespace => :admin )
    path_helpers[:index_rest_helper].should eql( 'admin_owner_parent_things_path' )
    path_helpers[:index_rest_args].should eql( [@owner, @parent] )
    path_helpers[:show_rest_helper].should eql( 'admin_owner_parent_thing_path' )
    path_helpers[:show_rest_args].should eql( [@owner, @parent] )
    path_helpers[:new_rest_helper].should eql( 'new_admin_owner_parent_thing_path' )
    path_helpers[:new_rest_args].should eql( [@owner, @parent] )
    path_helpers[:edit_rest_helper].should eql( 'edit_admin_owner_parent_thing_path' )
    path_helpers[:edit_rest_args].should eql( [@owner, @parent] )
    path_helpers[:delete_rest_helper].should eql( 'delete_admin_owner_parent_thing_path' )
    path_helpers[:delete_rest_args].should eql( [@owner, @parent] )
  end
  
  it "should resolve nested REST paths given ActiveRecord object and scoped by multiple object array and namespace string" do
    path_helpers = Guilded::Rails::Helpers.resolve_rest_path_helpers( @thing, :scoped_by => [@owner, @parent], :namespace => 'admin' )
    path_helpers[:index_rest_helper].should eql( 'admin_owner_parent_things_path' )
    path_helpers[:index_rest_args].should eql( [@owner, @parent] )
    path_helpers[:show_rest_helper].should eql( 'admin_owner_parent_thing_path' )
    path_helpers[:show_rest_args].should eql( [@owner, @parent] )
    path_helpers[:new_rest_helper].should eql( 'new_admin_owner_parent_thing_path' )
    path_helpers[:new_rest_args].should eql( [@owner, @parent] )
    path_helpers[:edit_rest_helper].should eql( 'edit_admin_owner_parent_thing_path' )
    path_helpers[:edit_rest_args].should eql( [@owner, @parent] )
    path_helpers[:delete_rest_helper].should eql( 'delete_admin_owner_parent_thing_path' )
    path_helpers[:delete_rest_args].should eql( [@owner, @parent] )
  end
  
  it "should resolve nested REST paths given ActiveRecord collection and scoped by multiple object array and namespace symbol" do
    path_helpers = Guilded::Rails::Helpers.resolve_rest_path_helpers( @things, :scoped_by => [@owner, @parent], :namespace => :admin )
    path_helpers[:index_rest_helper].should eql( 'admin_owner_parent_things_path' )
    path_helpers[:index_rest_args].should eql( [@owner, @parent] )
    path_helpers[:show_rest_helper].should eql( 'admin_owner_parent_thing_path' )
    path_helpers[:show_rest_args].should eql( [@owner, @parent] )
    path_helpers[:new_rest_helper].should eql( 'new_admin_owner_parent_thing_path' )
    path_helpers[:new_rest_args].should eql( [@owner, @parent] )
    path_helpers[:edit_rest_helper].should eql( 'edit_admin_owner_parent_thing_path' )
    path_helpers[:edit_rest_args].should eql( [@owner, @parent] )
    path_helpers[:delete_rest_helper].should eql( 'delete_admin_owner_parent_thing_path' )
    path_helpers[:delete_rest_args].should eql( [@owner, @parent] )
  end
  
  it "should resolve nested REST paths given ActiveRecord collection and scoped by multiple object array and namespace string" do
    path_helpers = Guilded::Rails::Helpers.resolve_rest_path_helpers( @things, :scoped_by => [@owner, @parent], :namespace => 'admin' )
    path_helpers[:index_rest_helper].should eql( 'admin_owner_parent_things_path' )
    path_helpers[:index_rest_args].should eql( [@owner, @parent] )
    path_helpers[:show_rest_helper].should eql( 'admin_owner_parent_thing_path' )
    path_helpers[:show_rest_args].should eql( [@owner, @parent] )
    path_helpers[:new_rest_helper].should eql( 'new_admin_owner_parent_thing_path' )
    path_helpers[:new_rest_args].should eql( [@owner, @parent] )
    path_helpers[:edit_rest_helper].should eql( 'edit_admin_owner_parent_thing_path' )
    path_helpers[:edit_rest_args].should eql( [@owner, @parent] )
    path_helpers[:delete_rest_helper].should eql( 'delete_admin_owner_parent_thing_path' )
    path_helpers[:delete_rest_args].should eql( [@owner, @parent] )
  end
  
  # Shallow
  
  it "should resolve shallow nested REST paths given ActiveRecord object and scoped by single object" do
    path_helpers = Guilded::Rails::Helpers.resolve_rest_path_helpers( @thing, :scoped_by => @parent, :shallow => true )
    path_helpers[:index_rest_helper].should eql( 'parent_things_path' )
    path_helpers[:index_rest_args].should eql( [@parent] )
    path_helpers[:show_rest_helper].should eql( 'thing_path' )
    path_helpers[:show_rest_args].should eql( [] )
    path_helpers[:new_rest_helper].should eql( 'new_parent_thing_path' )
    path_helpers[:new_rest_args].should eql( [@parent] )
    path_helpers[:edit_rest_helper].should eql( 'edit_thing_path' )
    path_helpers[:edit_rest_args].should eql( [] )
    path_helpers[:delete_rest_helper].should eql( 'delete_thing_path' )
    path_helpers[:delete_rest_args].should eql( [] )
  end
  
  it "should resolve shallow nested REST paths given ActiveRecord collection and scoped by single object" do
    path_helpers = Guilded::Rails::Helpers.resolve_rest_path_helpers( @things, :scoped_by => @parent, :shallow => true )
    path_helpers[:index_rest_helper].should eql( 'parent_things_path' )
    path_helpers[:index_rest_args].should eql( [@parent] )
    path_helpers[:show_rest_helper].should eql( 'thing_path' )
    path_helpers[:show_rest_args].should eql( [] )
    path_helpers[:new_rest_helper].should eql( 'new_parent_thing_path' )
    path_helpers[:new_rest_args].should eql( [@parent] )
    path_helpers[:edit_rest_helper].should eql( 'edit_thing_path' )
    path_helpers[:edit_rest_args].should eql( [] )
    path_helpers[:delete_rest_helper].should eql( 'delete_thing_path' )
    path_helpers[:delete_rest_args].should eql( [] )
  end
  
  it "should resolve shallow nested REST paths given ActiveRecord object and scoped by multiple object array" do
    path_helpers = Guilded::Rails::Helpers.resolve_rest_path_helpers( @thing, :scoped_by => [@owner, @parent], :shallow => true )
    path_helpers[:index_rest_helper].should eql( 'owner_parent_things_path' )
    path_helpers[:index_rest_args].should eql( [@owner, @parent] )
    path_helpers[:show_rest_helper].should eql( 'owner_thing_path' )
    path_helpers[:show_rest_args].should eql( [@owner] )
    path_helpers[:new_rest_helper].should eql( 'new_owner_parent_thing_path' )
    path_helpers[:new_rest_args].should eql( [@owner, @parent] )
    path_helpers[:edit_rest_helper].should eql( 'edit_owner_thing_path' )
    path_helpers[:edit_rest_args].should eql( [@owner] )
    path_helpers[:delete_rest_helper].should eql( 'delete_owner_thing_path' )
    path_helpers[:delete_rest_args].should eql( [@owner] )
  end
  
  it "should resolve shallow nested REST paths given ActiveRecord collection and scoped by multiple object array" do
    path_helpers = Guilded::Rails::Helpers.resolve_rest_path_helpers( @things, :scoped_by => [@owner, @parent], :shallow => true )
    path_helpers[:index_rest_helper].should eql( 'owner_parent_things_path' )
    path_helpers[:index_rest_args].should eql( [@owner, @parent] )
    path_helpers[:show_rest_helper].should eql( 'owner_thing_path' )
    path_helpers[:show_rest_args].should eql( [@owner] )
    path_helpers[:new_rest_helper].should eql( 'new_owner_parent_thing_path' )
    path_helpers[:new_rest_args].should eql( [@owner, @parent] )
    path_helpers[:edit_rest_helper].should eql( 'edit_owner_thing_path' )
    path_helpers[:edit_rest_args].should eql( [@owner] )
    path_helpers[:delete_rest_helper].should eql( 'delete_owner_thing_path' )
    path_helpers[:delete_rest_args].should eql( [@owner] )
  end
  
  it "should resolve shallow nested REST paths given ActiveRecord object and scoped by single object and namespace symbol" do
    path_helpers = Guilded::Rails::Helpers.resolve_rest_path_helpers( @thing, :scoped_by => @parent, :namespace => :admin, :shallow => true )
    path_helpers[:index_rest_helper].should eql( 'admin_parent_things_path' )
    path_helpers[:index_rest_args].should eql( [@parent] )
    path_helpers[:show_rest_helper].should eql( 'admin_thing_path' )
    path_helpers[:show_rest_args].should eql( [] )
    path_helpers[:new_rest_helper].should eql( 'new_admin_parent_thing_path' )
    path_helpers[:new_rest_args].should eql( [@parent] )
    path_helpers[:edit_rest_helper].should eql( 'edit_admin_thing_path' )
    path_helpers[:edit_rest_args].should eql( [] )
    path_helpers[:delete_rest_helper].should eql( 'delete_admin_thing_path' )
    path_helpers[:delete_rest_args].should eql( [] )
  end
  
  it "should resolve shallow nested REST paths given ActiveRecord object and scoped by multiple object array and namespace symbol" do
    path_helpers = Guilded::Rails::Helpers.resolve_rest_path_helpers( @thing, :scoped_by => [@owner, @parent], :namespace => :admin, :shallow => true )
    path_helpers[:index_rest_helper].should eql( 'admin_owner_parent_things_path' )
    path_helpers[:index_rest_args].should eql( [@owner, @parent] )
    path_helpers[:show_rest_helper].should eql( 'admin_owner_thing_path' )
    path_helpers[:show_rest_args].should eql( [@owner] )
    path_helpers[:new_rest_helper].should eql( 'new_admin_owner_parent_thing_path' )
    path_helpers[:new_rest_args].should eql( [@owner, @parent] )
    path_helpers[:edit_rest_helper].should eql( 'edit_admin_owner_thing_path' )
    path_helpers[:edit_rest_args].should eql( [@owner] )
    path_helpers[:delete_rest_helper].should eql( 'delete_admin_owner_thing_path' )
    path_helpers[:delete_rest_args].should eql( [@owner] )
  end
  
end
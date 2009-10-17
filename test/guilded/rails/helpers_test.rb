require 'test_helper'

class HelpersTest < Test::Unit::TestCase
  context "The helpers" do
    setup do
      @thing = Thing.new
      @things = [Thing.new, Thing.new]
      @parent = Parent.new
      @owner = Owner.new
      @lookup = Lookup.new
      @lookups = [Lookup.new, Lookup.new]
    end
  
    should "have class method resolve_field_methods_and_titles" do
      assert Guilded::Rails::Helpers.respond_to? :resolve_field_methods_and_titles
    end
    
    should "have class method resolve_rest_path_helpers" do
      assert Guilded::Rails::Helpers.respond_to? :resolve_rest_path_helpers
    end
    
    context "single level REST paths given ActiveRecord object" do
      setup do
        @path_helpers = Guilded::Rails::Helpers.resolve_rest_path_helpers( @thing )
      end
      
      should "resolve index path" do
        assert_equal 'things_path', @path_helpers[:index_rest_helper]
      end
      
      should "resolve index args" do
        assert_equal [], @path_helpers[:index_rest_args]
      end
      
      should "resolve show path" do
        assert_equal 'thing_path', @path_helpers[:show_rest_helper]
      end
      
      should "resolve show args" do
        assert_equal [], @path_helpers[:show_rest_args]
      end
      
      should "resolve new path" do
        assert_equal 'new_thing_path', @path_helpers[:new_rest_helper]
      end
      
      should "resolve new args" do
        assert_equal [], @path_helpers[:new_rest_args]
      end
      
      should "resolve edit path" do
        assert_equal 'edit_thing_path', @path_helpers[:edit_rest_helper]
      end
      
      should "resolve edit args" do
        assert_equal [], @path_helpers[:edit_rest_args]
      end
      
      should "resolve delete path" do
        assert_equal 'delete_thing_path', @path_helpers[:delete_rest_helper]
      end
      
      should "resolve delete args" do
        assert_equal [], @path_helpers[:delete_rest_args]
      end
    end
    
    context "single level REST paths given ActiveRecord collection" do
      setup do
        @path_helpers = Guilded::Rails::Helpers.resolve_rest_path_helpers( @things )
      end
      
      should "resolve index path" do
        assert_equal 'things_path', @path_helpers[:index_rest_helper]
      end
      
      should "resolve index args" do
        assert_equal [], @path_helpers[:index_rest_args]
      end
      
      should "resolve show path" do
        assert_equal 'thing_path', @path_helpers[:show_rest_helper]
      end
      
      should "resolve show args" do
        assert_equal [], @path_helpers[:show_rest_args]
      end
      
      should "resolve new path" do
        assert_equal 'new_thing_path', @path_helpers[:new_rest_helper]
      end
      
      should "resolve new args" do
        assert_equal [], @path_helpers[:new_rest_args]
      end
      
      should "resolve edit path" do
        assert_equal 'edit_thing_path', @path_helpers[:edit_rest_helper]
      end
      
      should "resolve edit args" do
        assert_equal [], @path_helpers[:edit_rest_args]
      end
      
      should "resolve delete path" do
        assert_equal 'delete_thing_path', @path_helpers[:delete_rest_helper]
      end
      
      should "resolve delete args" do
        assert_equal [], @path_helpers[:delete_rest_args]
      end
    end
    
    context "nested REST paths given ActiveRecord object and scoped by single object" do
      setup do
        @path_helpers = Guilded::Rails::Helpers.resolve_rest_path_helpers( @thing, :scoped_by => @parent )
      end
      
      should "resolve index path" do
        assert_equal 'parent_things_path', @path_helpers[:index_rest_helper]
      end
      
      should "resolve index args" do
        assert_equal [@parent], @path_helpers[:index_rest_args]
      end
      
      should "resolve show path" do
        assert_equal 'parent_thing_path', @path_helpers[:show_rest_helper]
      end
      
      should "resolve show args" do
        assert_equal [@parent], @path_helpers[:show_rest_args]
      end
      
      should "resolve new path" do
        assert_equal 'new_parent_thing_path', @path_helpers[:new_rest_helper]
      end
      
      should "resolve new args" do
        assert_equal [@parent], @path_helpers[:new_rest_args]
      end
      
      should "resolve edit path" do
        assert_equal 'edit_parent_thing_path', @path_helpers[:edit_rest_helper]
      end
      
      should "resolve edit args" do
        assert_equal [@parent], @path_helpers[:edit_rest_args]
      end
      
      should "resolve delete path" do
        assert_equal 'delete_parent_thing_path', @path_helpers[:delete_rest_helper]
      end
      
      should "resolve delete args" do
        assert_equal [@parent], @path_helpers[:delete_rest_args]
      end
    end
    
    context "nested REST paths given ActiveRecord object and scoped by single object array" do
      setup do
        @path_helpers = Guilded::Rails::Helpers.resolve_rest_path_helpers( @thing, :scoped_by => [@parent] )
      end
      
      should "resolve index path" do
        assert_equal 'parent_things_path', @path_helpers[:index_rest_helper]
      end
      
      should "resolve index args" do
        assert_equal [@parent], @path_helpers[:index_rest_args]
      end
      
      should "resolve show path" do
        assert_equal 'parent_thing_path', @path_helpers[:show_rest_helper]
      end
      
      should "resolve show args" do
        assert_equal [@parent], @path_helpers[:show_rest_args]
      end
      
      should "resolve new path" do
        assert_equal 'new_parent_thing_path', @path_helpers[:new_rest_helper]
      end
      
      should "resolve new args" do
        assert_equal [@parent], @path_helpers[:new_rest_args]
      end
      
      should "resolve edit path" do
        assert_equal 'edit_parent_thing_path', @path_helpers[:edit_rest_helper]
      end
      
      should "resolve edit args" do
        assert_equal [@parent], @path_helpers[:edit_rest_args]
      end
      
      should "resolve delete path" do
        assert_equal 'delete_parent_thing_path', @path_helpers[:delete_rest_helper]
      end
      
      should "resolve delete args" do
        assert_equal [@parent], @path_helpers[:delete_rest_args]
      end
    end
  
    context "nested REST paths given ActiveRecord collection and scoped by single object array" do
      setup do
        @path_helpers = Guilded::Rails::Helpers.resolve_rest_path_helpers( @things, :scoped_by => [@parent] )
      end
      
      should "resolve index path" do
        assert_equal 'parent_things_path', @path_helpers[:index_rest_helper]
      end
      
      should "resolve index args" do
        assert_equal [@parent], @path_helpers[:index_rest_args]
      end
      
      should "resolve show path" do
        assert_equal 'parent_thing_path', @path_helpers[:show_rest_helper]
      end
      
      should "resolve show args" do
        assert_equal [@parent], @path_helpers[:show_rest_args]
      end
      
      should "resolve new path" do
        assert_equal 'new_parent_thing_path', @path_helpers[:new_rest_helper]
      end
      
      should "resolve new args" do
        assert_equal [@parent], @path_helpers[:new_rest_args]
      end
      
      should "resolve edit path" do
        assert_equal 'edit_parent_thing_path', @path_helpers[:edit_rest_helper]
      end
      
      should "resolve edit args" do
        assert_equal [@parent], @path_helpers[:edit_rest_args]
      end
      
      should "resolve delete path" do
        assert_equal 'delete_parent_thing_path', @path_helpers[:delete_rest_helper]
      end
      
      should "resolve delete args" do
        assert_equal [@parent], @path_helpers[:delete_rest_args]
      end
    end
    
    context "nested REST paths given ActiveRecord object and scoped by multiple object array" do
      setup do
        @path_helpers = Guilded::Rails::Helpers.resolve_rest_path_helpers( @thing, :scoped_by => [@owner, @parent] )
      end
      
      should "resolve index path" do
        assert_equal 'owner_parent_things_path', @path_helpers[:index_rest_helper]
      end
      
      should "resolve index args" do
        assert_equal [@owner, @parent], @path_helpers[:index_rest_args]
      end
      
      should "resolve show path" do
        assert_equal 'owner_parent_thing_path', @path_helpers[:show_rest_helper]
      end
      
      should "resolve show args" do
        assert_equal [@owner, @parent], @path_helpers[:show_rest_args]
      end
      
      should "resolve new path" do
        assert_equal 'new_owner_parent_thing_path', @path_helpers[:new_rest_helper]
      end
      
      should "resolve new args" do
        assert_equal [@owner, @parent], @path_helpers[:new_rest_args]
      end
      
      should "resolve edit path" do
        assert_equal 'edit_owner_parent_thing_path', @path_helpers[:edit_rest_helper]
      end
      
      should "resolve edit args" do
        assert_equal [@owner, @parent], @path_helpers[:edit_rest_args]
      end
      
      should "resolve delete path" do
        assert_equal 'delete_owner_parent_thing_path', @path_helpers[:delete_rest_helper]
      end
      
      should "resolve delete args" do
        assert_equal [@owner, @parent], @path_helpers[:delete_rest_args]
      end
    end
  
    context "nested REST paths given ActiveRecord collection and scoped by multiple object array" do
      setup do
        @path_helpers = Guilded::Rails::Helpers.resolve_rest_path_helpers( @things, :scoped_by => [@owner, @parent] )
      end
      
      should "resolve index path" do
        assert_equal 'owner_parent_things_path', @path_helpers[:index_rest_helper]
      end
      
      should "resolve index args" do
        assert_equal [@owner, @parent], @path_helpers[:index_rest_args]
      end
      
      should "resolve show path" do
        assert_equal 'owner_parent_thing_path', @path_helpers[:show_rest_helper]
      end
      
      should "resolve show args" do
        assert_equal [@owner, @parent], @path_helpers[:show_rest_args]
      end
      
      should "resolve new path" do
        assert_equal 'new_owner_parent_thing_path', @path_helpers[:new_rest_helper]
      end
      
      should "resolve new args" do
        assert_equal [@owner, @parent], @path_helpers[:new_rest_args]
      end
      
      should "resolve edit path" do
        assert_equal 'edit_owner_parent_thing_path', @path_helpers[:edit_rest_helper]
      end
      
      should "resolve edit args" do
        assert_equal [@owner, @parent], @path_helpers[:edit_rest_args]
      end
      
      should "resolve delete path" do
        assert_equal 'delete_owner_parent_thing_path', @path_helpers[:delete_rest_helper]
      end
      
      should "resolve delete args" do
        assert_equal [@owner, @parent], @path_helpers[:delete_rest_args]
      end
    end
    
    context "single level REST paths given ActiveRecord object and namespace symbol" do
      setup do
        @path_helpers = Guilded::Rails::Helpers.resolve_rest_path_helpers( @thing, :namespace => :admin )
      end
      
      should "resolve index path" do
        assert_equal 'admin_things_path', @path_helpers[:index_rest_helper]
      end
      
      should "resolve index args" do
        assert_equal [], @path_helpers[:index_rest_args]
      end
      
      should "resolve show path" do
        assert_equal 'admin_thing_path', @path_helpers[:show_rest_helper]
      end
      
      should "resolve show args" do
        assert_equal [], @path_helpers[:show_rest_args]
      end
      
      should "resolve new path" do
        assert_equal 'new_admin_thing_path', @path_helpers[:new_rest_helper]
      end
      
      should "resolve new args" do
        assert_equal [], @path_helpers[:new_rest_args]
      end
      
      should "resolve edit path" do
        assert_equal 'edit_admin_thing_path', @path_helpers[:edit_rest_helper]
      end
      
      should "resolve edit args" do
        assert_equal [], @path_helpers[:edit_rest_args]
      end
      
      should "resolve delete path" do
        assert_equal 'delete_admin_thing_path', @path_helpers[:delete_rest_helper]
      end
      
      should "resolve delete args" do
        assert_equal [], @path_helpers[:delete_rest_args]
      end
    end
    
    context "single level REST paths given ActiveRecord object and namespace string" do
      setup do
        @path_helpers = Guilded::Rails::Helpers.resolve_rest_path_helpers( @thing, :namespace => 'admin' )
      end
      
      should "resolve index path" do
        assert_equal 'admin_things_path', @path_helpers[:index_rest_helper]
      end
      
      should "resolve index args" do
        assert_equal [], @path_helpers[:index_rest_args]
      end
      
      should "resolve show path" do
        assert_equal 'admin_thing_path', @path_helpers[:show_rest_helper]
      end
      
      should "resolve show args" do
        assert_equal [], @path_helpers[:show_rest_args]
      end
      
      should "resolve new path" do
        assert_equal 'new_admin_thing_path', @path_helpers[:new_rest_helper]
      end
      
      should "resolve new args" do
        assert_equal [], @path_helpers[:new_rest_args]
      end
      
      should "resolve edit path" do
        assert_equal 'edit_admin_thing_path', @path_helpers[:edit_rest_helper]
      end
      
      should "resolve edit args" do
        assert_equal [], @path_helpers[:edit_rest_args]
      end
      
      should "resolve delete path" do
        assert_equal 'delete_admin_thing_path', @path_helpers[:delete_rest_helper]
      end
      
      should "resolve delete args" do
        assert_equal [], @path_helpers[:delete_rest_args]
      end
    end
    
    context "single level REST paths given ActiveRecord collection and namespace symbol" do
      setup do
        @path_helpers = Guilded::Rails::Helpers.resolve_rest_path_helpers( @things, :namespace => :admin )
      end
      
      should "resolve index path" do
        assert_equal 'admin_things_path', @path_helpers[:index_rest_helper]
      end
      
      should "resolve index args" do
        assert_equal [], @path_helpers[:index_rest_args]
      end
      
      should "resolve show path" do
        assert_equal 'admin_thing_path', @path_helpers[:show_rest_helper]
      end
      
      should "resolve show args" do
        assert_equal [], @path_helpers[:show_rest_args]
      end
      
      should "resolve new path" do
        assert_equal 'new_admin_thing_path', @path_helpers[:new_rest_helper]
      end
      
      should "resolve new args" do
        assert_equal [], @path_helpers[:new_rest_args]
      end
      
      should "resolve edit path" do
        assert_equal 'edit_admin_thing_path', @path_helpers[:edit_rest_helper]
      end
      
      should "resolve edit args" do
        assert_equal [], @path_helpers[:edit_rest_args]
      end
      
      should "resolve delete path" do
        assert_equal 'delete_admin_thing_path', @path_helpers[:delete_rest_helper]
      end
      
      should "resolve delete args" do
        assert_equal [], @path_helpers[:delete_rest_args]
      end
    end
    
    context "single level REST paths given ActiveRecord collection and namespace string" do
      setup do
        @path_helpers = Guilded::Rails::Helpers.resolve_rest_path_helpers( @things, :namespace => 'admin' )
      end
      
      should "resolve index path" do
        assert_equal 'admin_things_path', @path_helpers[:index_rest_helper]
      end
      
      should "resolve index args" do
        assert_equal [], @path_helpers[:index_rest_args]
      end
      
      should "resolve show path" do
        assert_equal 'admin_thing_path', @path_helpers[:show_rest_helper]
      end
      
      should "resolve show args" do
        assert_equal [], @path_helpers[:show_rest_args]
      end
      
      should "resolve new path" do
        assert_equal 'new_admin_thing_path', @path_helpers[:new_rest_helper]
      end
      
      should "resolve new args" do
        assert_equal [], @path_helpers[:new_rest_args]
      end
      
      should "resolve edit path" do
        assert_equal 'edit_admin_thing_path', @path_helpers[:edit_rest_helper]
      end
      
      should "resolve edit args" do
        assert_equal [], @path_helpers[:edit_rest_args]
      end
      
      should "resolve delete path" do
        assert_equal 'delete_admin_thing_path', @path_helpers[:delete_rest_helper]
      end
      
      should "resolve delete args" do
        assert_equal [], @path_helpers[:delete_rest_args]
      end
    end
    
    context "nested REST paths given ActiveRecord object and scoped by single object and namespace symbol" do
      setup do
        @path_helpers = Guilded::Rails::Helpers.resolve_rest_path_helpers( @thing, :scoped_by => @parent, :namespace => :admin )
      end
      
      should "resolve index path" do
        assert_equal 'admin_parent_things_path', @path_helpers[:index_rest_helper]
      end
      
      should "resolve index args" do
        assert_equal [@parent], @path_helpers[:index_rest_args]
      end
      
      should "resolve show path" do
        assert_equal 'admin_parent_thing_path', @path_helpers[:show_rest_helper]
      end
      
      should "resolve show args" do
        assert_equal [@parent], @path_helpers[:show_rest_args]
      end
      
      should "resolve new path" do
        assert_equal 'new_admin_parent_thing_path', @path_helpers[:new_rest_helper]
      end
      
      should "resolve new args" do
        assert_equal [@parent], @path_helpers[:new_rest_args]
      end
      
      should "resolve edit path" do
        assert_equal 'edit_admin_parent_thing_path', @path_helpers[:edit_rest_helper]
      end
      
      should "resolve edit args" do
        assert_equal [@parent], @path_helpers[:edit_rest_args]
      end
      
      should "resolve delete path" do
        assert_equal 'delete_admin_parent_thing_path', @path_helpers[:delete_rest_helper]
      end
      
      should "resolve delete args" do
        assert_equal [@parent], @path_helpers[:delete_rest_args]
      end
    end
    
    context "nested REST paths given ActiveRecord object and scoped by single object and namespace string" do
      setup do
        @path_helpers = Guilded::Rails::Helpers.resolve_rest_path_helpers( @thing, :scoped_by => @parent, :namespace => 'admin' )
      end
      
      should "resolve index path" do
        assert_equal 'admin_parent_things_path', @path_helpers[:index_rest_helper]
      end
      
      should "resolve index args" do
        assert_equal [@parent], @path_helpers[:index_rest_args]
      end
      
      should "resolve show path" do
        assert_equal 'admin_parent_thing_path', @path_helpers[:show_rest_helper]
      end
      
      should "resolve show args" do
        assert_equal [@parent], @path_helpers[:show_rest_args]
      end
      
      should "resolve new path" do
        assert_equal 'new_admin_parent_thing_path', @path_helpers[:new_rest_helper]
      end
      
      should "resolve new args" do
        assert_equal [@parent], @path_helpers[:new_rest_args]
      end
      
      should "resolve edit path" do
        assert_equal 'edit_admin_parent_thing_path', @path_helpers[:edit_rest_helper]
      end
      
      should "resolve edit args" do
        assert_equal [@parent], @path_helpers[:edit_rest_args]
      end
      
      should "resolve delete path" do
        assert_equal 'delete_admin_parent_thing_path', @path_helpers[:delete_rest_helper]
      end
      
      should "resolve delete args" do
        assert_equal [@parent], @path_helpers[:delete_rest_args]
      end
    end
    
    context "nested REST paths given ActiveRecord collection and scoped by single object and namespace symbol" do
      setup do
        @path_helpers = Guilded::Rails::Helpers.resolve_rest_path_helpers( @things, :scoped_by => @parent, :namespace => :admin )
      end
      
      should "resolve index path" do
        assert_equal 'admin_parent_things_path', @path_helpers[:index_rest_helper]
      end
      
      should "resolve index args" do
        assert_equal [@parent], @path_helpers[:index_rest_args]
      end
      
      should "resolve show path" do
        assert_equal 'admin_parent_thing_path', @path_helpers[:show_rest_helper]
      end
      
      should "resolve show args" do
        assert_equal [@parent], @path_helpers[:show_rest_args]
      end
      
      should "resolve new path" do
        assert_equal 'new_admin_parent_thing_path', @path_helpers[:new_rest_helper]
      end
      
      should "resolve new args" do
        assert_equal [@parent], @path_helpers[:new_rest_args]
      end
      
      should "resolve edit path" do
        assert_equal 'edit_admin_parent_thing_path', @path_helpers[:edit_rest_helper]
      end
      
      should "resolve edit args" do
        assert_equal [@parent], @path_helpers[:edit_rest_args]
      end
      
      should "resolve delete path" do
        assert_equal 'delete_admin_parent_thing_path', @path_helpers[:delete_rest_helper]
      end
      
      should "resolve delete args" do
        assert_equal [@parent], @path_helpers[:delete_rest_args]
      end
    end
    
    context "nested REST paths given ActiveRecord collection and scoped by single object and namespace string" do
      setup do
        @path_helpers = Guilded::Rails::Helpers.resolve_rest_path_helpers( @things, :scoped_by => @parent, :namespace => 'admin' )
      end
      
      should "resolve index path" do
        assert_equal 'admin_parent_things_path', @path_helpers[:index_rest_helper]
      end
      
      should "resolve index args" do
        assert_equal [@parent], @path_helpers[:index_rest_args]
      end
      
      should "resolve show path" do
        assert_equal 'admin_parent_thing_path', @path_helpers[:show_rest_helper]
      end
      
      should "resolve show args" do
        assert_equal [@parent], @path_helpers[:show_rest_args]
      end
      
      should "resolve new path" do
        assert_equal 'new_admin_parent_thing_path', @path_helpers[:new_rest_helper]
      end
      
      should "resolve new args" do
        assert_equal [@parent], @path_helpers[:new_rest_args]
      end
      
      should "resolve edit path" do
        assert_equal 'edit_admin_parent_thing_path', @path_helpers[:edit_rest_helper]
      end
      
      should "resolve edit args" do
        assert_equal [@parent], @path_helpers[:edit_rest_args]
      end
      
      should "resolve delete path" do
        assert_equal 'delete_admin_parent_thing_path', @path_helpers[:delete_rest_helper]
      end
      
      should "resolve delete args" do
        assert_equal [@parent], @path_helpers[:delete_rest_args]
      end
    end
    
    context "nested REST paths given ActiveRecord object and scoped by single object array and namespace symbol" do
      setup do
        @path_helpers = Guilded::Rails::Helpers.resolve_rest_path_helpers( @thing, :scoped_by => [@parent], :namespace => :admin )
      end
      
      should "resolve index path" do
        assert_equal 'admin_parent_things_path', @path_helpers[:index_rest_helper]
      end
      
      should "resolve index args" do
        assert_equal [@parent], @path_helpers[:index_rest_args]
      end
      
      should "resolve show path" do
        assert_equal 'admin_parent_thing_path', @path_helpers[:show_rest_helper]
      end
      
      should "resolve show args" do
        assert_equal [@parent], @path_helpers[:show_rest_args]
      end
      
      should "resolve new path" do
        assert_equal 'new_admin_parent_thing_path', @path_helpers[:new_rest_helper]
      end
      
      should "resolve new args" do
        assert_equal [@parent], @path_helpers[:new_rest_args]
      end
      
      should "resolve edit path" do
        assert_equal 'edit_admin_parent_thing_path', @path_helpers[:edit_rest_helper]
      end
      
      should "resolve edit args" do
        assert_equal [@parent], @path_helpers[:edit_rest_args]
      end
      
      should "resolve delete path" do
        assert_equal 'delete_admin_parent_thing_path', @path_helpers[:delete_rest_helper]
      end
      
      should "resolve delete args" do
        assert_equal [@parent], @path_helpers[:delete_rest_args]
      end
    end
    
    context "nested REST paths given ActiveRecord object and scoped by single object array and namespace string" do
      setup do
        @path_helpers = Guilded::Rails::Helpers.resolve_rest_path_helpers( @thing, :scoped_by => [@parent], :namespace => 'admin' )
      end
      
      should "resolve index path" do
        assert_equal 'admin_parent_things_path', @path_helpers[:index_rest_helper]
      end
      
      should "resolve index args" do
        assert_equal [@parent], @path_helpers[:index_rest_args]
      end
      
      should "resolve show path" do
        assert_equal 'admin_parent_thing_path', @path_helpers[:show_rest_helper]
      end
      
      should "resolve show args" do
        assert_equal [@parent], @path_helpers[:show_rest_args]
      end
      
      should "resolve new path" do
        assert_equal 'new_admin_parent_thing_path', @path_helpers[:new_rest_helper]
      end
      
      should "resolve new args" do
        assert_equal [@parent], @path_helpers[:new_rest_args]
      end
      
      should "resolve edit path" do
        assert_equal 'edit_admin_parent_thing_path', @path_helpers[:edit_rest_helper]
      end
      
      should "resolve edit args" do
        assert_equal [@parent], @path_helpers[:edit_rest_args]
      end
      
      should "resolve delete path" do
        assert_equal 'delete_admin_parent_thing_path', @path_helpers[:delete_rest_helper]
      end
      
      should "resolve delete args" do
        assert_equal [@parent], @path_helpers[:delete_rest_args]
      end
    end
    
    context "nested REST paths given ActiveRecord collection and scoped by single object array and namespace symbol" do
      setup do
        @path_helpers = Guilded::Rails::Helpers.resolve_rest_path_helpers( @things, :scoped_by => [@parent], :namespace => :admin )
      end
      
      should "resolve index path" do
        assert_equal 'admin_parent_things_path', @path_helpers[:index_rest_helper]
      end
      
      should "resolve index args" do
        assert_equal [@parent], @path_helpers[:index_rest_args]
      end
      
      should "resolve show path" do
        assert_equal 'admin_parent_thing_path', @path_helpers[:show_rest_helper]
      end
      
      should "resolve show args" do
        assert_equal [@parent], @path_helpers[:show_rest_args]
      end
      
      should "resolve new path" do
        assert_equal 'new_admin_parent_thing_path', @path_helpers[:new_rest_helper]
      end
      
      should "resolve new args" do
        assert_equal [@parent], @path_helpers[:new_rest_args]
      end
      
      should "resolve edit path" do
        assert_equal 'edit_admin_parent_thing_path', @path_helpers[:edit_rest_helper]
      end
      
      should "resolve edit args" do
        assert_equal [@parent], @path_helpers[:edit_rest_args]
      end
      
      should "resolve delete path" do
        assert_equal 'delete_admin_parent_thing_path', @path_helpers[:delete_rest_helper]
      end
      
      should "resolve delete args" do
        assert_equal [@parent], @path_helpers[:delete_rest_args]
      end
    end
    
    context "nested REST paths given ActiveRecord collection and scoped by single object array and namespace string" do
      setup do
        @path_helpers = Guilded::Rails::Helpers.resolve_rest_path_helpers( @things, :scoped_by => [@parent], :namespace => 'admin' )
      end
      
      should "resolve index path" do
        assert_equal 'admin_parent_things_path', @path_helpers[:index_rest_helper]
      end
      
      should "resolve index args" do
        assert_equal [@parent], @path_helpers[:index_rest_args]
      end
      
      should "resolve show path" do
        assert_equal 'admin_parent_thing_path', @path_helpers[:show_rest_helper]
      end
      
      should "resolve show args" do
        assert_equal [@parent], @path_helpers[:show_rest_args]
      end
      
      should "resolve new path" do
        assert_equal 'new_admin_parent_thing_path', @path_helpers[:new_rest_helper]
      end
      
      should "resolve new args" do
        assert_equal [@parent], @path_helpers[:new_rest_args]
      end
      
      should "resolve edit path" do
        assert_equal 'edit_admin_parent_thing_path', @path_helpers[:edit_rest_helper]
      end
      
      should "resolve edit args" do
        assert_equal [@parent], @path_helpers[:edit_rest_args]
      end
      
      should "resolve delete path" do
        assert_equal 'delete_admin_parent_thing_path', @path_helpers[:delete_rest_helper]
      end
      
      should "resolve delete args" do
        assert_equal [@parent], @path_helpers[:delete_rest_args]
      end
    end
    
    context "nested REST paths given ActiveRecord object and scoped by multiple object array and namespace symbol" do
      setup do
        @path_helpers = Guilded::Rails::Helpers.resolve_rest_path_helpers( @thing, :scoped_by => [@owner, @parent], :namespace => :admin )
      end
      
      should "resolve index path" do
        assert_equal 'admin_owner_parent_things_path', @path_helpers[:index_rest_helper]
      end
      
      should "resolve index args" do
        assert_equal [@owner, @parent], @path_helpers[:index_rest_args]
      end
      
      should "resolve show path" do
        assert_equal 'admin_owner_parent_thing_path', @path_helpers[:show_rest_helper]
      end
      
      should "resolve show args" do
        assert_equal [@owner, @parent], @path_helpers[:show_rest_args]
      end
      
      should "resolve new path" do
        assert_equal 'new_admin_owner_parent_thing_path', @path_helpers[:new_rest_helper]
      end
      
      should "resolve new args" do
        assert_equal [@owner, @parent], @path_helpers[:new_rest_args]
      end
      
      should "resolve edit path" do
        assert_equal 'edit_admin_owner_parent_thing_path', @path_helpers[:edit_rest_helper]
      end
      
      should "resolve edit args" do
        assert_equal [@owner, @parent], @path_helpers[:edit_rest_args]
      end
      
      should "resolve delete path" do
        assert_equal 'delete_admin_owner_parent_thing_path', @path_helpers[:delete_rest_helper]
      end
      
      should "resolve delete args" do
        assert_equal [@owner, @parent], @path_helpers[:delete_rest_args]
      end
    end
    
    context "nested REST paths given ActiveRecord object and scoped by multiple object array and namespace string" do
      setup do
        @path_helpers = Guilded::Rails::Helpers.resolve_rest_path_helpers( @thing, :scoped_by => [@owner, @parent], :namespace => 'admin' )
      end
      
      should "resolve index path" do
        assert_equal 'admin_owner_parent_things_path', @path_helpers[:index_rest_helper]
      end
      
      should "resolve index args" do
        assert_equal [@owner, @parent], @path_helpers[:index_rest_args]
      end
      
      should "resolve show path" do
        assert_equal 'admin_owner_parent_thing_path', @path_helpers[:show_rest_helper]
      end
      
      should "resolve show args" do
        assert_equal [@owner, @parent], @path_helpers[:show_rest_args]
      end
      
      should "resolve new path" do
        assert_equal 'new_admin_owner_parent_thing_path', @path_helpers[:new_rest_helper]
      end
      
      should "resolve new args" do
        assert_equal [@owner, @parent], @path_helpers[:new_rest_args]
      end
      
      should "resolve edit path" do
        assert_equal 'edit_admin_owner_parent_thing_path', @path_helpers[:edit_rest_helper]
      end
      
      should "resolve edit args" do
        assert_equal [@owner, @parent], @path_helpers[:edit_rest_args]
      end
      
      should "resolve delete path" do
        assert_equal 'delete_admin_owner_parent_thing_path', @path_helpers[:delete_rest_helper]
      end
      
      should "resolve delete args" do
        assert_equal [@owner, @parent], @path_helpers[:delete_rest_args]
      end
    end
    
    context "nested REST paths given ActiveRecord collection and scoped by multiple object array and namespace symbol" do
      setup do
        @path_helpers = Guilded::Rails::Helpers.resolve_rest_path_helpers( @things, :scoped_by => [@owner, @parent], :namespace => :admin )
      end
      
      should "resolve index path" do
        assert_equal 'admin_owner_parent_things_path', @path_helpers[:index_rest_helper]
      end
      
      should "resolve index args" do
        assert_equal [@owner, @parent], @path_helpers[:index_rest_args]
      end
      
      should "resolve show path" do
        assert_equal 'admin_owner_parent_thing_path', @path_helpers[:show_rest_helper]
      end
      
      should "resolve show args" do
        assert_equal [@owner, @parent], @path_helpers[:show_rest_args]
      end
      
      should "resolve new path" do
        assert_equal 'new_admin_owner_parent_thing_path', @path_helpers[:new_rest_helper]
      end
      
      should "resolve new args" do
        assert_equal [@owner, @parent], @path_helpers[:new_rest_args]
      end
      
      should "resolve edit path" do
        assert_equal 'edit_admin_owner_parent_thing_path', @path_helpers[:edit_rest_helper]
      end
      
      should "resolve edit args" do
        assert_equal [@owner, @parent], @path_helpers[:edit_rest_args]
      end
      
      should "resolve delete path" do
        assert_equal 'delete_admin_owner_parent_thing_path', @path_helpers[:delete_rest_helper]
      end
      
      should "resolve delete args" do
        assert_equal [@owner, @parent], @path_helpers[:delete_rest_args]
      end
    end
    
    context "nested REST paths given ActiveRecord collection and scoped by multiple object array and namespace string" do
      setup do
        @path_helpers = Guilded::Rails::Helpers.resolve_rest_path_helpers( @things, :scoped_by => [@owner, @parent], :namespace => 'admin' )
      end
      
      should "resolve index path" do
        assert_equal 'admin_owner_parent_things_path', @path_helpers[:index_rest_helper]
      end
      
      should "resolve index args" do
        assert_equal [@owner, @parent], @path_helpers[:index_rest_args]
      end
      
      should "resolve show path" do
        assert_equal 'admin_owner_parent_thing_path', @path_helpers[:show_rest_helper]
      end
      
      should "resolve show args" do
        assert_equal [@owner, @parent], @path_helpers[:show_rest_args]
      end
      
      should "resolve new path" do
        assert_equal 'new_admin_owner_parent_thing_path', @path_helpers[:new_rest_helper]
      end
      
      should "resolve new args" do
        assert_equal [@owner, @parent], @path_helpers[:new_rest_args]
      end
      
      should "resolve edit path" do
        assert_equal 'edit_admin_owner_parent_thing_path', @path_helpers[:edit_rest_helper]
      end
      
      should "resolve edit args" do
        assert_equal [@owner, @parent], @path_helpers[:edit_rest_args]
      end
      
      should "resolve delete path" do
        assert_equal 'delete_admin_owner_parent_thing_path', @path_helpers[:delete_rest_helper]
      end
      
      should "resolve delete args" do
        assert_equal [@owner, @parent], @path_helpers[:delete_rest_args]
      end
    end
    
    context "shallow nested REST paths given ActiveRecord object and scoped by single object" do
      setup do
        @path_helpers = Guilded::Rails::Helpers.resolve_rest_path_helpers( @thing, :scoped_by => @parent, :shallow => true )
      end
      
      should "resolve index path" do
        assert_equal 'parent_things_path', @path_helpers[:index_rest_helper]
      end
      
      should "resolve index args" do
        assert_equal [@parent], @path_helpers[:index_rest_args]
      end
      
      should "resolve show path" do
        assert_equal 'thing_path', @path_helpers[:show_rest_helper]
      end
      
      should "resolve show args" do
        assert_equal [], @path_helpers[:show_rest_args]
      end
      
      should "resolve new path" do
        assert_equal 'new_parent_thing_path', @path_helpers[:new_rest_helper]
      end
      
      should "resolve new args" do
        assert_equal [@parent], @path_helpers[:new_rest_args]
      end
      
      should "resolve edit path" do
        assert_equal 'edit_thing_path', @path_helpers[:edit_rest_helper]
      end
      
      should "resolve edit args" do
        assert_equal [], @path_helpers[:edit_rest_args]
      end
      
      should "resolve delete path" do
        assert_equal 'delete_thing_path', @path_helpers[:delete_rest_helper]
      end
      
      should "resolve delete args" do
        assert_equal [], @path_helpers[:delete_rest_args]
      end
    end
    
    context "shallow nested REST paths given ActiveRecord collection and scoped by single object" do
      setup do
        @path_helpers = Guilded::Rails::Helpers.resolve_rest_path_helpers( @things, :scoped_by => @parent, :shallow => true )
      end
      
      should "resolve index path" do
        assert_equal 'parent_things_path', @path_helpers[:index_rest_helper]
      end
      
      should "resolve index args" do
        assert_equal [@parent], @path_helpers[:index_rest_args]
      end
      
      should "resolve show path" do
        assert_equal 'thing_path', @path_helpers[:show_rest_helper]
      end
      
      should "resolve show args" do
        assert_equal [], @path_helpers[:show_rest_args]
      end
      
      should "resolve new path" do
        assert_equal 'new_parent_thing_path', @path_helpers[:new_rest_helper]
      end
      
      should "resolve new args" do
        assert_equal [@parent], @path_helpers[:new_rest_args]
      end
      
      should "resolve edit path" do
        assert_equal 'edit_thing_path', @path_helpers[:edit_rest_helper]
      end
      
      should "resolve edit args" do
        assert_equal [], @path_helpers[:edit_rest_args]
      end
      
      should "resolve delete path" do
        assert_equal 'delete_thing_path', @path_helpers[:delete_rest_helper]
      end
      
      should "resolve delete args" do
        assert_equal [], @path_helpers[:delete_rest_args]
      end
    end
    
    context "shallow nested REST paths given ActiveRecord object and scoped by multiple object array" do
      setup do
        @path_helpers = Guilded::Rails::Helpers.resolve_rest_path_helpers( @thing, :scoped_by => [@owner, @parent], :shallow => true )
      end
      
      should "resolve index path" do
        assert_equal 'owner_parent_things_path', @path_helpers[:index_rest_helper]
      end
      
      should "resolve index args" do
        assert_equal [@owner, @parent], @path_helpers[:index_rest_args]
      end
      
      should "resolve show path" do
        assert_equal 'owner_thing_path', @path_helpers[:show_rest_helper]
      end
      
      should "resolve show args" do
        assert_equal [@owner], @path_helpers[:show_rest_args]
      end
      
      should "resolve new path" do
        assert_equal 'new_owner_parent_thing_path', @path_helpers[:new_rest_helper]
      end
      
      should "resolve new args" do
        assert_equal [@owner, @parent], @path_helpers[:new_rest_args]
      end
      
      should "resolve edit path" do
        assert_equal 'edit_owner_thing_path', @path_helpers[:edit_rest_helper]
      end
      
      should "resolve edit args" do
        assert_equal [@owner], @path_helpers[:edit_rest_args]
      end
      
      should "resolve delete path" do
        assert_equal 'delete_owner_thing_path', @path_helpers[:delete_rest_helper]
      end
      
      should "resolve delete args" do
        assert_equal [@owner], @path_helpers[:delete_rest_args]
      end
    end
    
    context "shallow nested REST paths given ActiveRecord collection and scoped by multiple object array" do
      setup do
        @path_helpers = Guilded::Rails::Helpers.resolve_rest_path_helpers( @things, :scoped_by => [@owner, @parent], :shallow => true )
      end
      
      should "resolve index path" do
        assert_equal 'owner_parent_things_path', @path_helpers[:index_rest_helper]
      end
      
      should "resolve index args" do
        assert_equal [@owner, @parent], @path_helpers[:index_rest_args]
      end
      
      should "resolve show path" do
        assert_equal 'owner_thing_path', @path_helpers[:show_rest_helper]
      end
      
      should "resolve show args" do
        assert_equal [@owner], @path_helpers[:show_rest_args]
      end
      
      should "resolve new path" do
        assert_equal 'new_owner_parent_thing_path', @path_helpers[:new_rest_helper]
      end
      
      should "resolve new args" do
        assert_equal [@owner, @parent], @path_helpers[:new_rest_args]
      end
      
      should "resolve edit path" do
        assert_equal 'edit_owner_thing_path', @path_helpers[:edit_rest_helper]
      end
      
      should "resolve edit args" do
        assert_equal [@owner], @path_helpers[:edit_rest_args]
      end
      
      should "resolve delete path" do
        assert_equal 'delete_owner_thing_path', @path_helpers[:delete_rest_helper]
      end
      
      should "resolve delete args" do
        assert_equal [@owner], @path_helpers[:delete_rest_args]
      end
    end
    
    context "shallow nested REST paths given ActiveRecord object and scoped by single object and namespace symbol" do
      setup do
        @path_helpers = Guilded::Rails::Helpers.resolve_rest_path_helpers( @thing, :scoped_by => @parent, :namespace => :admin, :shallow => true )
      end
      
      should "resolve index path" do
        assert_equal 'admin_parent_things_path', @path_helpers[:index_rest_helper]
      end
      
      should "resolve index args" do
        assert_equal [@parent], @path_helpers[:index_rest_args]
      end
      
      should "resolve show path" do
        assert_equal 'admin_thing_path', @path_helpers[:show_rest_helper]
      end
      
      should "resolve show args" do
        assert_equal [], @path_helpers[:show_rest_args]
      end
      
      should "resolve new path" do
        assert_equal 'new_admin_parent_thing_path', @path_helpers[:new_rest_helper]
      end
      
      should "resolve new args" do
        assert_equal [@parent], @path_helpers[:new_rest_args]
      end
      
      should "resolve edit path" do
        assert_equal 'edit_admin_thing_path', @path_helpers[:edit_rest_helper]
      end
      
      should "resolve edit args" do
        assert_equal [], @path_helpers[:edit_rest_args]
      end
      
      should "resolve delete path" do
        assert_equal 'delete_admin_thing_path', @path_helpers[:delete_rest_helper]
      end
      
      should "resolve delete args" do
        assert_equal [], @path_helpers[:delete_rest_args]
      end
    end
    
    context "shallow nested REST paths given ActiveRecord object and scoped by multiple object array and namespace symbol" do
      setup do
        @path_helpers = Guilded::Rails::Helpers.resolve_rest_path_helpers( @thing, :scoped_by => [@owner, @parent], :namespace => :admin, 
          :shallow => true )
      end
      
      should "resolve index path" do
        assert_equal 'admin_owner_parent_things_path', @path_helpers[:index_rest_helper]
      end
      
      should "resolve index args" do
        assert_equal [@owner, @parent], @path_helpers[:index_rest_args]
      end
      
      should "resolve show path" do
        assert_equal 'admin_owner_thing_path', @path_helpers[:show_rest_helper]
      end
      
      should "resolve show args" do
        assert_equal [@owner], @path_helpers[:show_rest_args]
      end
      
      should "resolve new path" do
        assert_equal 'new_admin_owner_parent_thing_path', @path_helpers[:new_rest_helper]
      end
      
      should "resolve new args" do
        assert_equal [@owner, @parent], @path_helpers[:new_rest_args]
      end
      
      should "resolve edit path" do
        assert_equal 'edit_admin_owner_thing_path', @path_helpers[:edit_rest_helper]
      end
      
      should "resolve edit args" do
        assert_equal [@owner], @path_helpers[:edit_rest_args]
      end
      
      should "resolve delete path" do
        assert_equal 'delete_admin_owner_thing_path', @path_helpers[:delete_rest_helper]
      end
      
      should "resolve delete args" do
        assert_equal [@owner], @path_helpers[:delete_rest_args]
      end
    end
    
    context "single level REST paths given a polymorphic ActiveRecord object" do
      setup do
        @path_helpers = Guilded::Rails::Helpers.resolve_rest_path_helpers( @lookup, :polymorphic_type => 'Thing', :polymorphic_as => :lookupable )
      end
      
      should "resolve index path" do
        assert_equal 'things_path', @path_helpers[:index_rest_helper]
      end
      
      should "resolve index args" do
        assert_equal [], @path_helpers[:index_rest_args]
      end
      
      should "resolve show path" do
        assert_equal 'thing_path', @path_helpers[:show_rest_helper]
      end
      
      should "resolve show args" do
        assert_equal [], @path_helpers[:show_rest_args]
      end
      
      should "resolve new path" do
        assert_equal 'new_thing_path', @path_helpers[:new_rest_helper]
      end
      
      should "resolve new args" do
        assert_equal [], @path_helpers[:new_rest_args]
      end
      
      should "resolve edit path" do
        assert_equal 'edit_thing_path', @path_helpers[:edit_rest_helper]
      end
      
      should "resolve edit args" do
        assert_equal [], @path_helpers[:edit_rest_args]
      end
      
      should "resolve delete path" do
        assert_equal 'delete_thing_path', @path_helpers[:delete_rest_helper]
      end
      
      should "resolve delete args" do
        assert_equal [], @path_helpers[:delete_rest_args]
      end
    end
    
    context "shallow nested REST paths given a polymorphic ActiveRecord object and scoped by multiple object array and namespace symbol" do
      setup do
        @path_helpers = Guilded::Rails::Helpers.resolve_rest_path_helpers( @looku, :scoped_by => [@owner, @parent], :namespace => :admin, 
          :shallow => true, :polymorphic_type => 'Thing', :polymorphic_as => :lookupable )
      end
      
      should "resolve index path" do
        assert_equal 'admin_owner_parent_things_path', @path_helpers[:index_rest_helper]
      end
      
      should "resolve index args" do
        assert_equal [@owner, @parent], @path_helpers[:index_rest_args]
      end
      
      should "resolve show path" do
        assert_equal 'admin_owner_thing_path', @path_helpers[:show_rest_helper]
      end
      
      should "resolve show args" do
        assert_equal [@owner], @path_helpers[:show_rest_args]
      end
      
      should "resolve new path" do
        assert_equal 'new_admin_owner_parent_thing_path', @path_helpers[:new_rest_helper]
      end
      
      should "resolve new args" do
        assert_equal [@owner, @parent], @path_helpers[:new_rest_args]
      end
      
      should "resolve edit path" do
        assert_equal 'edit_admin_owner_thing_path', @path_helpers[:edit_rest_helper]
      end
      
      should "resolve edit args" do
        assert_equal [@owner], @path_helpers[:edit_rest_args]
      end
      
      should "resolve delete path" do
        assert_equal 'delete_admin_owner_thing_path', @path_helpers[:delete_rest_helper]
      end
      
      should "resolve delete args" do
        assert_equal [@owner], @path_helpers[:delete_rest_args]
      end
    end
  end
end
require 'spec_helper'
require 'generators/guilded_assets/guilded_assets_generator'

describe GuildedAssetsGenerator do
  before :each do
    @destination = File.join 'tmp', 'test_app'
    @source = GuildedAssetsGenerator.source_root
    GuildedAssetsGenerator.start '', :destination_root => @destination
  end
  
  after :each do
    FileUtils.rm_rf @destination
  end
  
  {"guilded.js" => "public/javascripts/guilded.js",
   "guilded.min.js" => "public/javascripts/guilded.min.js",
   "jquery-1.2.6.js" => "public/javascripts/jquery/jquery-1.2.6.js",
   "jquery-1.2.6.min.js" => "public/javascripts/jquery/jquery-1.2.6.min.js",
   "jquery-1.3.2.js" => "public/javascripts/jquery/jquery-1.3.2.js",
   "jquery-1.3.2.min.js" => "public/javascripts/jquery/jquery-1.3.2.min.js",
   "jquery-url.js" => "public/javascripts/jquery/jquery-url.js",
   "jquery-url.min.js" => "public/javascripts/jquery/jquery-url.min.js",
   "mootools-1.2.3.js" => "public/javascripts/mootools/mootools-1.2.3.js",
   "mootools-1.2.3.min.js" => "public/javascripts/mootools/mootools-1.2.3.min.js",
   "reset-min.css" => "public/stylesheets/reset-min.css"}.each do |file, path|  
    
    it "should copy '#{file}' to '#{path}'" do
      File.exists?( File.join( @destination, path ) ).should be_true
    end
    
    it "should agree that the contents of '#{file}' are identical to '#{path}'" do
      File.read( File.join( @source, file ) ).should eql File.read( File.join( @destination, path ) )
    end
  end
end
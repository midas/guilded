require 'spec_helper'
require 'generators/guilded_config/guilded_config_generator'

describe GuildedConfigGenerator do
  before :each do
    @destination = File.join 'tmp', 'test_app'
    @source = GuildedConfigGenerator.source_root
    GuildedConfigGenerator.start '', :destination_root => @destination
  end
  
  after :each do
    FileUtils.rm_rf @destination
  end
  
  {'guilded_config.rb' => 'config/initializers/guilded_config.rb'}.each do |file, path|  
    it "should copy '#{file}' to '#{path}'" do
      File.exists?( File.join( @destination, path ) ).should be_true
    end
    
    it "should agree that the contents of '#{file}' are identical to '#{path}'" do
      File.read( File.join( @source, file ) ).should eql File.read( File.join( @destination, path ) )
    end
  end
end
$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'guilded/base'
require 'guilded/component_def'
require 'guilded/guilder'
require 'guilded/base/view_helpers'
require 'guilded/exceptions'

module Guilded
  VERSION = '0.0.1'
end
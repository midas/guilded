$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'guilded/component_def'
require 'guilded/guilder'
require 'guilded/exceptions'
require 'guilded/rails/controller_actions'
require 'guilded/rails/helpers'
require 'guilded/rails/view_helpers'
require 'guilded/rails/active_record/human_attribute_hint'
require 'guilded/rails/active_record/human_attribute_override'
require 'guilded/rails/inactive_record/human_attribute_hint'

# Guilded is a framework for creating reusable UI components for web applications.  Guilded provides the facilities to 
# easily add components and all of their required assets to a page.
# 
# A Guilded component is a set of XHTML, CSS and JavaScript that combine to create a rich UI.  The Guilded component should be
# authored using progressive enhancement to enable users without CSS or JavaScript enabled to utilize the essential functionality
# of the component.  The easiest way to accomplish this requirement is to write your behavior code as a jQuery plugin.  Doing
# so will naturally guide your behavior code to be applied through progrssive enhancement and also allow your behavior code 
# to be used without Guilded.
#
# To create a Guilded component at least four things must occur: writing a view helper, writing a JavaScript initialization
# function, writing a default stylesheet and writing either a rake task or generator to place these assets into a project's 
# public directory.  It is also probable that a jQuery plugin with the behavior code will need to be authored.  If this is the 
# case, then the JavaScript initialization function will most likely just call the jQuery plugin on the DOM element(s) that should 
# have the behavior applied.
#
# The view helper should output the HTML necessary for the component.  It must also add the component to a collection so that
# Guilded can collect its assets and add them to the page.  This is accomplished through a call to the Guilder.add() method.
# The Guilder is a singleton, so you must access it like: Guilded::Guilder.instance.add( ... ).  The Guilder.add() method adds
# element to a collection with it's options.  Guilded automatically looks for CSS assets that obey the naming convention 
# {component_name}/default.css.  Guilded also automatically looks for a JavaScript asset named: guilded.{component_name}.js.  
# This asset should at least include the initComponentName( options ).  The Guilded.add() method can also add additional CSS and 
# JavaScript assets necessary for a component.  An example of an additional JavaScript asset is the jQuery plugin authored to 
# contain the behavior of a component.  The view helper must be called with an :id option as it is used to differentiate different
# instances of the same component on a single page from each other.  It will also be used as the DOM element's id.  A Guilded view 
# helper should have a g_ appended to the beginning of it to help differentiate from normal view helepr sin a project.
# 
# The JavaScript initialization function should be named init{ComponentName}( options ).  The options hash from the view helper
# will automatically be passed to this function.  The function should handle a before and after init callback to enable the user
# to set up anything necessary for the component and perform additional tasks.  This function must also perform any other code 
# necessary to set up the behavior for a compnent.  An example fo this would be adding behavior to events or simply calling
# a jQuery plugin on element(s) of the component.  Remember that any JavaScript relating to Guilded should be placed in the 'g'
# namespace that Guilded creates on every page.  An example init function for a g_load_alerter would be:
#
#   g.initLoadAlerter = function( options )
#   {
#     if( g.beforeInitLoadAlerter )
#       g.beforeInitLoadAlerter( options );
#
#     // Initialization code here...
#
#     if( g.afterInitLoadAlerter )
#       g.afterInitLoadAlerter( options );
#   };
#
# For a user to implement these callback functions, they should create a JavaScript file with the functions and call it on
# any page they need it on utilizing Guilded's JavaScript include helper g_javascript_include_tag.  This helper will add the
# JavaScript files after the jQuery and Guilded framework files, but within the component files in the order they were added.  
# This will make the 'g' namespace available for use.  Obviously this file must be included prior to calling the component's helper,
# or the callback functions will not be defined for use. 
#
# The default stylesheet for a Guilded component should be the minimum amount of CSS for the component to function.  When no :skin
# option is passed to the view helper when a component is added, Guilded will look for the default stylesheet.  The assets
# used within the stylesheet (images) should be placed in a folder named default that is in the same directory as the default.css
# file.  All asssets used in the stylesheet should use an absolute reference from the public directory: /stylesheets/guilded/{component_name}/default/{asset_name}.
#
# In order to create another skin for a component, simply create a {skin_name}.css file and a {skin_name} directory with the style 
# assets in it.  Be sure to reference the style assets with absolute paths from teh public directory so that the skin will work in 
# all cases.  Then call the component's view helper and use the :skin option:
#
#   <%= g_load_alerter :skin => 'blueish', :id => 'load_alerter' %>
#
module Guilded
  VERSION = '1.0.3'
end

ActionView::Base.send( :include, Guilded::Rails::ViewHelpers ) if defined?( ActionView )
ActionController::Base.send( :include, Guilded::Rails::ControllerActions ) if defined?( ActionController::Base )
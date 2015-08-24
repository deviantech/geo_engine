require 'responders'
require 'jbuilder'

module Geo
  class Engine < ::Rails::Engine
    isolate_namespace Geo
  end
end

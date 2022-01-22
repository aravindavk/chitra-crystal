require "cairo"

at_exit do
  GC.collect
end

module Chitra
  include Cairo
end

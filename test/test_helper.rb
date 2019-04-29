$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "dr_rockter"

require "minitest/autorun"
require "minitest/reporters"

Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(:color => true)]

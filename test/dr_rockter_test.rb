require "test_helper"

class DrRockterTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::DrRockter::VERSION
  end
end

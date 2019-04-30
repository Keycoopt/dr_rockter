require "test_helper"
require "dr_rockter/candidate"

module DrRockter
  class CandidateTest < Minitest::Test
    def test_serialization
      candidate = Candidate.new
      candidate.reference    = "the_reference"
      candidate.consent_date = Time.new(2009, 9, 25, 14, 45, 0, "+01:00")
      candidate.origin       = "the_origin"
      candidate.locale       = "pr_BR"
      candidate.message      = "the message"
      candidate.gender       = Candidate::MALE
      candidate.first_name   = "First"
      candidate.last_name    = "Last"
      candidate.email        = "email@example.org"
      candidate.phone        = "(42) 2015-5616"
      candidate.job          = "a job"
      candidate.street       = "the street"
      candidate.city         = "the city"
      candidate.zip_code     = "the zip code"
      # TODO: add a file
      
      json = candidate.to_json
      
      result = JSON.parse json
      assert_equal "the_reference", result["reference"]
      assert_equal "2009-09-25", result["consent_date"]
      assert_equal "the_origin", result["s_o"]
      assert_equal "pr_BR", result["locale"]
      assert_equal "the message", result.dig("ApplicationMessage", "message")
      assert_equal "1", result.dig("ApplicationProfile", "gender")
      assert_equal "First", result.dig("ApplicationProfile", "firstName")
      assert_equal "Last", result.dig("ApplicationProfile", "lastName")
      assert_equal "(42) 2015-5616", result.dig("ApplicationProfile", "phoneNumber")
      assert_equal "a job", result.dig("ApplicationProfile", "job")
      assert_equal "the street", result.dig("ApplicationProfile", "addressStreet")
      assert_equal "the zip code", result.dig("ApplicationProfile", "addressZip")
      assert_equal "the city", result.dig("ApplicationProfile", "addressCity")
      # TODO: assertions on the file
    end
  end
end

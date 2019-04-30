require "test_helper"
require "json"
require "dr_rockter/md"

module DrRockter
  class CustomType
    include MD

    json_attributes :custom_attr
  end

  class Test
    include MD

    json_attributes a_hash: :hash, a_string: :string, a_url: :url, custom_type: CustomType, string_array: [:string], custom_type_array: [CustomType]
  end

  class TestUnknownDeserializer
    include MD

    json_attributes unknown: :unknown_deserializer
  end

  class MDTest < Minitest::Test

    def test_it_parses_a_string
      json = <<~JSON
      {
        "a_string": "It is a string"
      }
      JSON
      test = Test.json_create(JSON.parse(json))

      assert_equal "It is a string", test.a_string
    end

    def test_it_parses_a_hash
      json = <<~JSON
      {
        "a_hash": {
          "first": "first",
          "last": "last"
        }
      }
      JSON
      test = Test.json_create(JSON.parse(json))

      assert_equal({ "first" => "first", "last" => "last" }, test.a_hash)
    end

    def test_it_parses_a_hash_with_null_value
      json = <<~JSON
      {
        "a_hash": null
      }
      JSON
      test = Test.json_create(JSON.parse(json))

      assert_nil test.a_hash
    end

    def test_it_parses_a_url
      url = "http://www.example.com"
      json = <<~JSON
      {
        "a_url": "#{url}"
      }
      JSON
      test = Test.json_create(JSON.parse(json))

      assert_equal URI(url), test.a_url
    end

    def test_it_parses_a_custom_type
      test = Test.json_create({ custom_type: { custom_attr: "custom attribute" } })

      assert_instance_of CustomType, test.custom_type
      assert_equal "custom attribute", test.custom_type.custom_attr
    end

    def test_it_parses_a_custom_type_with_null_value
      json = <<~JSON
      {
        "custom_type": null
      }
      JSON
      test = Test.json_create(JSON.parse(json))

      assert_nil test.custom_type
    end

    def test_it_parses_an_array
      json = <<~JSON
      {
        "string_array": ["a string", "another string"]
      }
      JSON
      test = Test.json_create(JSON.parse(json))

      assert_equal ["a string", "another string"], test.string_array
    end

    def test_it_parses_an_array_of_custom_types
      json = <<~JSON
      {
        "custom_type_array": [
          { "custom_attr": "a custom type" },
          { "custom_attr": "another custom type" }
        ]
      }
      JSON
      test = Test.json_create(JSON.parse(json))

      assert_instance_of Array, test.custom_type_array
      assert_instance_of CustomType, test.custom_type_array.first
      assert_instance_of CustomType, test.custom_type_array.last
    end

    def test_it_throws_an_exception_for_unknown_deserializer
      json = <<~JSON
      {
        "unknown": "unknown"
      }
      JSON

      assert_raises DeserializerError do
        TestUnknownDeserializer.json_create(JSON.parse(json))
      end
    end
  
    def test_serialization_methods
      klass = Class.new { include MD }
      
      assert_includes klass.instance_methods, :as_json
      assert_includes klass.instance_methods, :to_json
    end
  
    def test_serializing
      klass = Class.new do
        include MD
        json_attributes :an_attribute
      end
      
      k = klass.new
      k.an_attribute = "a value"
      
      json = k.as_json
      assert_equal "a value", json[:an_attribute]
    end
  end
end

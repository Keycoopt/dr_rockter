require "date"
require "uri"

module DrRockter
  DeserializerError = Class.new(StandardError)
  
  module MD
    KNOWN_TYPES = {
      string:   ->(v) { v },
      datetime: ->(v) { DateTime.parse v unless v.nil? },
      url:      ->(v) { URI(v) unless v.nil? },
      hash:     ->(v) { v }
    }
    DEFAULT_TYPE = KNOWN_TYPES[:string]
    
    class << self
      def included(base)
        base.extend ClassMethods
      end
      
      def deserializer_for(type)
        if type.is_a?(Array)
          item_type = deserializer_for type.first
          ->(v) { v.map { |i| item_type.call(i) } }
        elsif type.respond_to? :call
          type
        elsif type.respond_to? :json_creatable?
          ->(v) { type.json_create(v) unless v.nil? }
        else
          begin
            KNOWN_TYPES.fetch type
          rescue KeyError
            ->(v) { raise DeserializerError, "no deserializer found for attribute type '#{type}'" }
          end
        end
      end
    end
    
    module ClassMethods
      def json_attributes(*names_with_or_without_types)
        attributes = normalize_attributes_names_and_types(names_with_or_without_types)
        attributes.each do |name, type|
          define_deserializor name, type
          define_accessor name
        end
      end
    
      def json_creatable?
        true
      end
    
      def json_create(object)
        new.tap do |jo|
          object.each { |k, v| jo.send("deserialize_#{k}", v) if jo.respond_to? "deserialize_#{k}" }
        end
      end
    
      private
    
      def normalize_attributes_names_and_types(names_with_or_without_types)
        names_with_or_without_types.each_with_object({}) do |name_or_hash, attributes|
          if name_or_hash.respond_to? :to_h
            attributes.merge! name_or_hash.to_h
          else
            attributes.store name_or_hash, DEFAULT_TYPE
          end
        end
      end
    
      def define_deserializor(name, type)
        deserializer = MD.deserializer_for(type)
      
        define_method "deserialize_#{name}" do |value|
          instance_variable_set "@#{name}", deserializer.call(value)
        end
      end
    
      def define_accessor(name)
        attr_accessor name
      end
    end
    
    def as_json(*)
      {}
    end

    def to_json(*args)
      as_json.to_json *args
    end
  end
end

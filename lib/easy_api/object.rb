require 'forwardable'
require 'ostruct'

module EasyApi
  class MissingRequiredAttributeError < StandardError; end;
  class UnknownAttributeError < StandardError; end;

  class Object
    include Enumerable
    extend ::Forwardable

    def_delegators(:attributes, :size, :[], :each)

    def initialize(data)
      raise EasyApi::MissingRequiredAttributeError unless required_attribute_names.all? do |name|
        data.keys.include?(name) || data.keys.include?(name.to_s)
      end

      raise EasyApi::UnknownAttributeError if data.keys.any? do |key|
        !(attribute_names.include?(key) || attribute_names.include?(key.to_sym))
      end

      @attributes = data.map do |k, v|
        next [k, v] unless v.instance_of? Hash

        v =
          if object_class = schema[k.to_sym]
            object_class.new(v)
          else
            OpenStruct.new(v)
          end

        [k.to_sym, v]
      end.to_h
    end

    def method_missing(m, *args, &block)
      if v = attributes[m]
        v
      else
        raise UnknownAttributeError
      end
    end

    def attributes
      @attributes ||= {}
    end

    def attribute_names
      required_attribute_names + optional_attribute_names
    end

    # Please override
    def required_attribute_names
      []
    end

    # Please override
    def optional_attribute_names
      []
    end

    # Please override
    def schema
      {}
    end
  end
end

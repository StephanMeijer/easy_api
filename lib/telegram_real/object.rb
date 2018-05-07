require 'forwardable'

module TelegramReal
  class MissingRequiredAttributeError < StandardError; end;
  class UnknownAttributeError < StandardError; end;

  class Object
    include Enumerable
    extend ::Forwardable

    def_delegators(:attributes, :size, :[], :each)

    def initialize(data)
      raise TelegramReal::MissingRequiredAttributeError unless required_attribute_names.all? { |name| data.keys.include? name }
      raise TelegramReal::UnknownAttributeError if data.keys.any? { |key| !attribute_names.include? key }

      @attributes = data.map do |k, v|
        next [k, v] unless v.instance_of? Hash

        v =
          if object_class = schema[k]
            object_class.new(v)
          else
            OpenStruct.new(v) # TODO: maybe create OpenStructObject which creates OpenStruct instance and parses
          end

        [k, v]
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

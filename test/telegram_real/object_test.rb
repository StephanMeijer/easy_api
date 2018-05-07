require File.join(__dir__, '../test_helper.rb')

describe TelegramReal::Object do
  class CObject < TelegramReal::Object
    def required_attribute_names
      [:e]
    end
  end
  class ExampleObject < TelegramReal::Object
    def required_attribute_names
      [:a, :b]
    end
    def optional_attribute_names
      [:c, :d]
    end
    def schema
      {c: CObject}
    end
  end

  it 'does not raise error if all parameters are given' do
    assert ExampleObject.new(a: 1, b: 'String', c: {e: 123}, d: 3)
  end

  it 'does not raise error if parameters include hash' do
    assert ExampleObject.new(a: 1, b: 'String', c: {e: 123}, d: 3)
  end

  it 'raises error if unknown parameter' do
    assert_raises TelegramReal::UnknownAttributeError do
      ExampleObject.new(a: 1, b: 'String', c: {e: 123}, f: 3)
    end
  end

  it 'raises error if required parameter is missing' do
    assert_raises TelegramReal::MissingRequiredAttributeError do
      ExampleObject.new(b: 'String')
    end
  end

  it 'does not raise error if optional attribute is given' do
    assert ExampleObject.new(a: 1, b: 'String', c: {e: 123})
  end

  it 'does not raise error if optional attribute is not given' do
    assert ExampleObject.new(a: 1, b: 'String')
  end

  it 'does not raise error if required attributes of child object given' do
    assert example = ExampleObject.new(a: 1, b: 'String', c: {e: 123})
    binding.pry
  end

  it 'raises error if required attributes of child object not given' do
    assert_raises TelegramReal::MissingRequiredAttributeError do
      assert ExampleObject.new(a: 1, b: 'String', c: {})
    end
  end

  it 'raises error if unknown attributes of child object not given' do
    assert_raises TelegramReal::UnknownAttributeError do
      assert ExampleObject.new(a: 1, b: 'String', c: {unknow: true})
    end
  end
end

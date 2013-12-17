##
# Wraps an object or collection of objects for presentation in a view
# This class is meant to be subclassed.
class Presenter < SimpleDelegator
  def initialize(presentee = nil)
    super(Conversions::Present(presentee))
  end

  def self.inherited(klass)
    # get the part of the class name we want like "ShoppingCart"
    base_name = klass.name.split('::').last.sub('Presenter','')
    # downcase and underscore (without activesupport) like "shopping_cart"
    wrapped_object_name = base_name.gsub(/([a-z][A-Z])/){ $1.scan(/./).join('_') }.downcase
    klass.send(:alias_method, wrapped_object_name, :__getobj__)
    klass.send(:alias_method, "#{wrapped_object_name}=", :__setobj__)
  end

  def wrapped_enum(presenter_class, enumerable, &block)
    enumerable.each do |object|
      presenter = presenter_class.new(object)
      block.call(presenter)
    end
  end
end

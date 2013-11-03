##
# Wraps an object or collection of objects for presentation in a view
# This class is meant to be subclassed.
#
# Typical usage:
#
# class MyPresenter < Presenter
#   # custom methods here
# end
#
# presenter = MyPresenter.new_from(presentee)
# presenter.name => delegates to presentee.name
#
# class MyCompositePresenter < Presenter
#   def initialize(main_presentee, related_presentee)
#     super(main_presentee)
#     @related_presentee = related_presentee
#   end
#
#   def self.new_from(main_presentee, related_presentee)
#     self.Maybe(MyCompositePresenter.new(main_presentee, related_presentee))
#   end
# end
#
# presenter = MyCompositePresenter.new_from(main_presentee, related_presentee)
class Presenter < SimpleDelegator
  def initialize(presentee)
    super(presentee)
  end

  def self.inherited(klass)
    # get the part of the class name we want like "ShoppingCart"
    base_name = klass.name.split('::').last.sub('Presenter','')
    # downcase and underscore (without activesupport) like "shopping_cart"
    wrapped_object_name = base_name.gsub(/([a-z][A-Z])/){ $1.scan(/./).join('_') }.downcase
    klass.send(:alias_method, wrapped_object_name, :__getobj__)
    klass.send(:alias_method, "#{wrapped_object_name}=", :__setobj__)
  end

  def self.new_from(presentee)
    Conversions::Present(presentee)
  end
end

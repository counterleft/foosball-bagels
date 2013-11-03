module Conversions
  extend NullObjects::NullObject::Conversions

  def self.Present(presentee, *args)
    presentee = Maybe(presentee)
    presenter_class = get_presenter_class(presenter_class_prefix(presentee))
    presenter_class.new(presentee, *args)
  end

  private

  def self.presenter_class_prefix(presentee)
    prefix = presentee.class.name

    if Actual(presentee).respond_to?(:to_ary)
      actual_presentee = Maybe(presentee.first)
      prefix = "#{actual_presentee.class.name}List"
    end

    prefix
  end

  def self.get_presenter_class(prefix)
    begin
      Object.const_get("#{prefix}Presenter")
    rescue
      Object.const_get("NullObjects::NullObjectPresenter")
    end
  end
end

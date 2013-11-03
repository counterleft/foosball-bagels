require_relative "../../app/lib/presenter"
require "ostruct"

describe Presenter do
  describe ".new_from" do
    class TempPresenteePresenter < Presenter
      attr_reader :foo

      def initialize(presentee, foo)
        super(presentee)
        @foo = foo
      end

      def self.new_from(presentee, foo = nil)
        Conversions::Present(presentee, foo)
      end
    end

    class TempPresentee
      attr_reader :name

      def initialize(name)
        @name = name
      end
    end

    it "creates a NullPresenter when given nil presentee" do
      expect(TempPresenteePresenter.new_from(nil)).to be_a(NullObjects::NullObjectPresenter)
      expect(Presenter.new_from(nil)).to be_a(NullObjects::NullObjectPresenter)
    end

    it "creates a subclass Presenter when sent from subclass" do
      subject = TempPresenteePresenter.new_from(TempPresentee.new("Name"))
      expect(subject.name).to eq("Name")
    end

    it "creates a subclass Presenter with extra args" do
      subject = TempPresenteePresenter.new_from(TempPresentee.new("Name"), "Foo")
      expect(subject.name).to eq("Name")
      expect(subject.foo).to eq("Foo")
    end
  end
end

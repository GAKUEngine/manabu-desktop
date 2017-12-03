require_relative "base"

module ManabuDesktop
  module Screens
    class Login < ManabuDesktop::Screens::Base
      attr_accessor :window

      def initialize()
        super('login')
        _show()
      end
    end
  end
end

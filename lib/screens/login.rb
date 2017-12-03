require_relative "base"

module ManabuDesktop
  module Screens
    class Login < ManabuDesktop::Screens::Base
      def initialize()
        super('login')

        @builder.get_object('server.label').set_label(I18n.t('login.server'))
        @builder.get_object('user.label').set_label(I18n.t('login.user'))
        @builder.get_object('password.label').set_label(I18n.t('login.password'))

        engage_button = @builder.get_object('engage.button')
        engage_button.set_label(I18n.t('login.engage'))
        engage_button.signal_connect('clicked') { puts 'TODO: login' }

        _show()
      end
    end
  end
end

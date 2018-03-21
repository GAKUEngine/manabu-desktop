require_relative 'base'
require_relative 'login'
require_relative '../sessions'
require_relative '../windows'

module ManabuDesktop
  module Screens
    class MainMenu < ManabuDesktop::Screens::Base
      def initialize()
        if ManabuDesktop::Windows.set_main_menu(self) == false
          # TODO: handle multiple main menus..
          STDERR.puts 'Tried to initialize multiple Main Menus!'
        end

        super('main_menu', :c)

        connect_button = @builder.get_object('connect.Button')
        connect_button.set_label(I18n.t('main_menu.connect'))
        connect_button.signal_connect('clicked') { ManabuDesktop::Screens::Login.new() }

        settings_button = @builder.get_object('settings.Button')
        settings_button.set_label(I18n.t('main_menu.settings'))
        settings_button.signal_connect('clicked') { puts 'Settings coming soon' }

        exit_button = @builder.get_object('exit.Button')
        exit_button.set_label(I18n.t('main_menu.exit'))
        exit_button.signal_connect('clicked') do |_widget|
          ManabuDesktop::Windows.destroy_all()
          Gtk.main_quit()
        end

        @connections_list = @builder.get_object('connections.ListBox')

        @status_bar = @builder.get_object('status.Statusbar')
        @status_bar_context_id = @status_bar.get_context_id('Connection Status')

        set_connections_status(ManabuDesktop::Sessions.session_count)

        _show()
      end

      def set_status(status_text)
        @status_bar.push(@status_bar_context_id, status_text)
      end

      def set_connections_status(num)
        set_status("#{I18n.t('main_menu.num_connections')}: #{num}")
      end
    end
  end
end

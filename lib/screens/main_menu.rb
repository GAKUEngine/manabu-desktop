require_relative 'base'
require_relative 'login'
require_relative '../sessions'
require_relative '../windows'

STATUS_ICON_SIZE = 16

module ManabuDesktop
  module Screens
    class MainMenu < ManabuDesktop::Screens::Base
      def initialize()
        if ManabuDesktop::Windows.set_main_menu(self) == false
          # TODO: handle multiple main menus..
          STDERR.puts 'Tried to initialize multiple Main Menus!'
        end


        super('main_menu', :c)
        @window.set_resizable(false)
        @window.gravity = Gdk::Gravity::NORTH_EAST
        @window.move((Gdk::Screen.width - @window.width_request), 0)

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

        # Status icon
        @status_image = @builder.get_object('status.Image')
        _load_status_icons()
        _set_status_icon(:clear)

        # Heartbeat icon
        @heartbeat_image = @builder.get_object('heartbeat.Image')
        _load_heartbeat_icons()
        @heartbeat_image.set_pixbuf(@heart_icons[:black])

        # Transmission and buffer status
        @transfer_status_image = @builder.get_object('transfer_status.Image')
        _load_transfer_icons()
        @transfer_status_image.set_pixbuf(@transfer_icons[:none])
        @buffer_status_progress_bar = @builder.get_object('buffer_status.ProgressBar')

        _show()
      end

      def set_status(status_text)
        @status_bar.push(@status_bar_context_id, status_text)
      end

      def set_connections_status(num)
        set_status("#{I18n.t('main_menu.num_connections')}: #{num}")
      end

      def _load_status_icons()
        @status_icons = {}
        @status_icons[:none] = GdkPixbuf::Pixbuf.new(
          {file: "#{__dir__}/../../layouts/img/black_circle.png",
                                width: STATUS_ICON_SIZE, height: STATUS_ICON_SIZE})
        @status_icons[:clear] = GdkPixbuf::Pixbuf.new(
          {file: "#{__dir__}/../../layouts/img/white_circle.png",
                                width: STATUS_ICON_SIZE, height: STATUS_ICON_SIZE})
        @status_icons[:ok] = GdkPixbuf::Pixbuf.new(
          {file: "#{__dir__}/../../layouts/img/blue_circle.png",
                                width: STATUS_ICON_SIZE, height: STATUS_ICON_SIZE})
        @status_icons[:ng] = GdkPixbuf::Pixbuf.new(
          {file: "#{__dir__}/../../layouts/img/red_circle.png",
                                width: STATUS_ICON_SIZE, height: STATUS_ICON_SIZE})
      end

      def _set_status_icon(status_code)
        if @status_icons.include? status_code
          @status_image.set_pixbuf(@status_icons[status_code])
        else
          @status_image.set_pixbuf(@status_icons[:none])
        end
      end

      def _load_heartbeat_icons()
        @heart_icons = {}
        @heart_icons[:black] = GdkPixbuf::Pixbuf.new(
          {file: "#{__dir__}/../../layouts/img/black_heart.png",
                                width: STATUS_ICON_SIZE, height: STATUS_ICON_SIZE})
        @heart_icons[:red] = GdkPixbuf::Pixbuf.new(
          {file: "#{__dir__}/../../layouts/img/heart.png",
                                width: STATUS_ICON_SIZE, height: STATUS_ICON_SIZE})
      end

      def heartbeat()
      end

      def _load_transfer_icons()
        @transfer_icons = {}
        @transfer_icons[:none] = GdkPixbuf::Pixbuf.new(
          {file: "#{__dir__}/../../layouts/img/transfer_none.png",
                                width: STATUS_ICON_SIZE, height: STATUS_ICON_SIZE})
        @transfer_icons[:up] = GdkPixbuf::Pixbuf.new(
          {file: "#{__dir__}/../../layouts/img/transfer_up.png",
                                width: STATUS_ICON_SIZE, height: STATUS_ICON_SIZE})
        @transfer_icons[:down] = GdkPixbuf::Pixbuf.new(
          {file: "#{__dir__}/../../layouts/img/transfer_down.png",
                                width: STATUS_ICON_SIZE, height: STATUS_ICON_SIZE})
        @transfer_icons[:updown] = GdkPixbuf::Pixbuf.new(
          {file: "#{__dir__}/../../layouts/img/transfer_updown.png",
                                width: STATUS_ICON_SIZE, height: STATUS_ICON_SIZE})
      end
    end
  end
end

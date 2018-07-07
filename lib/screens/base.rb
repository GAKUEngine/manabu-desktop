require_relative '../tools'
require_relative '../windows'
require 'gtk3'

module ManabuDesktop
  module Screens
    class Base
      attr_accessor :window, :builder

      @@gtk_initialized = false
      @@gtk_main_quit_set = false

      # opts:
      #   icon_path: path to an icon image for the window icon
      def initialize(layout, locale = :c, opts = {})
        @builder = Gtk::Builder.new()
        @builder.add_from_file("#{__dir__}/../../layouts/#{layout}.glade")

        @builder.connect_signals do |handler|
          begin
            method(handler)
          rescue
            puts "#{handler} not yet implemented!"
            method('not_yet_implemented')
          end
        end

        @window = builder.get_object("#{layout}.Window")
        @window.set_title(I18n.t("#{layout}.title"))
        if opts.include? :icon_path
          begin
            @window.set_icon(opts[:icon_path])
          rescue
            @window.set_icon("#{__dir__}/../../layouts/img/gaku-logo-128.png")
          end
        else
          @window.set_icon("#{__dir__}/../../layouts/img/gaku-logo-128.png")
        end
        unless @@gtk_main_quit_set
          @window.signal_connect('delete-event') do |_widget|
            #@window.destroy()
            ManabuDesktop::Windows.destroy_all()
            Gtk.main_quit()
          end
          @@gtk_main_quit_set = true
        end
      end

      def _show()
        @window.show()
        unless @@gtk_initialized
          Gtk.main()
          @@gtk_initialized = true
        end
      end
    end
  end
end

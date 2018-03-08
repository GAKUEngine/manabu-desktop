require_relative '../tools'
require_relative '../windows'
require 'gtk3'

module ManabuDesktop
  module Screens
    class Base
      attr_accessor :window, :builder

      @@gtk_initialized = false
      @@gtk_main_quit_set = false

      def initialize(layout, locale = :c)
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

require_relative '../toolbox'
require 'gtk3'

module ManabuDesktop
  module Screens
    class Base
      attr_accessor :window, :builder

      def initialize(layout)
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

        @window = builder.get_object("#{layout}.window")
        @window.signal_connect('delete-event') { |_widget| Gtk.main_quit }
      end

      def _show()
        @window.show()

        Gtk.main()
      end
    end
  end
end

require 'gtk3'

module ManabuDesktop
  module Screens
    module Components
      class ServerListItem
        attr_reader :user, :server, :port, :list_box_row, :label

        def initialize(user, server, port = 80)
          @user = user
          @server = server
          @port = port
          super()
          _generate()
        end

        def _generate()
          sib_builder = Gtk::Builder.new()
          sib_builder.add_from_file("#{__dir__}/../../../layouts/server_listbox.glade")
          @list_box_row = sib_builder.get_object('server_instance.ListBoxRow')
          @label = sib_builder.get_object('server_id.Label')
          @label.set_label("#{@user}@#{@server}:#{@port}")
          @list_box_row.show_all()
        end
      end
    end
  end
end

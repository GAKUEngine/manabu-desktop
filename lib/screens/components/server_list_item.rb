require 'gtk3'

module ManabuDesktop
  module Screens
    module Components
      class ServerListItem
        attr_reader :client, :user, :server, :port, :list_box_row, :label

        def initialize(client, user, server, port = 80)
          @client = client
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
          @menu_button = sib_builder.get_object('server_menu.Button')
          @menu_popover = sib_builder.get_object('server_menu.Popover')
          _populate_menu(sib_builder)
          @list_box_row.show_all()
        end

        def _populate_menu(builder)
          list_box = builder.get_object('server_menu.ListBox')
          list_box.add(_build_ability_menu_lbr(:Toolbox))
          list_box.add(_build_ability_menu_lbr(:Roster))
          list_box.add(_build_ability_menu_lbr(:Courses))
          list_box.add(_build_ability_menu_lbr(:Exams))
          list_box.add(_build_ability_menu_lbr(:Administration))
          list_box.show_all()

          @menu_button.signal_connect 'clicked' do |button|
            ManabuDesktop::Screens.Toolbox.new(@client)
            @menu_popover.visible = true
          end
        end

        def _build_ability_menu_lbr(ability)
          builder = Gtk::Builder.new()
          builder.add_from_file("#{__dir__}/../../../layouts/server_menu_item.glade")
          menu_item = builder.get_object('server_menu_item.ListBoxRow')
          # TODO find the *actual* way to git children by ID
          box = menu_item.children[0]
          box.children[0].set_pixbuf(_get_ability_icon(ability))
          box.children[2].label = I18n.t("g.#{ability.to_s}")
          #menu_item.ability = ability
          #menu_item.signal_connect 'set-focus-child' do |item|
          #  ManabuDesktop::Screens.const_get(ability).new(@client)
          #end
          menu_item
        end

        def _get_ability_icon(ability)
          case ability
          when :Toolbox
            pixbuf = GdkPixbuf::Pixbuf.new(
              file: ManabuDesktop::Tools.emojidex.emoji[:hammer_wrench].paths[:png][:px16])
          when :Roster
            pixbuf = GdkPixbuf::Pixbuf.new(
              file: ManabuDesktop::Tools.emojidex.emoji[:student].paths[:png][:px16])
          when :Courses
            pixbuf = GdkPixbuf::Pixbuf.new(
              file: ManabuDesktop::Tools.emojidex.emoji[:notebook].paths[:png][:px16])
          when :Exams
            pixbuf = GdkPixbuf::Pixbuf.new(
              file: ManabuDesktop::Tools.emojidex.emoji[:white_check_mark].paths[:png][:px16])
          when :Administration
            pixbuf = GdkPixbuf::Pixbuf.new(
              file: ManabuDesktop::Tools.emojidex.emoji[:wrench].paths[:png][:px16])
          else
            pixbuf = GdkPixbuf::Pixbuf.new(
              file: ManabuDesktop::Tools.emojidex.emoji[:question].paths[:png][:px16])
          end

          pixbuf
        end
      end
    end
  end
end

require_relative 'base'
require_relative 'roster'
require_relative '../tools'
require 'manabu/client'

module ManabuDesktop
  module Screens
    class ToolBox < ManabuDesktop::Screens::Base
      attr_reader :activities

      ICON_COL    = 0
      LABEL_COL   = 1
      ACTIVITY_COL = 2

      def initialize(client)
        @client = client
        super('toolbox')

        @activities = [:Roster, :Courses, :Exams, :Administration]

        icon_view = @builder.get_object('tools.IconView')
        icon_view.set_pixbuf_column(ICON_COL)
        icon_view.set_text_column(LABEL_COL)
        list = Gtk::ListStore.new(GdkPixbuf::Pixbuf, String, String)

        _setup_filter_controls()

        _fill_toolbox(list, icon_view)

        icon_view.signal_connect('item-activated') do |_widget, tree_path|
          iter = list.get_iter(tree_path)
          ManabuDesktop::Screens.const_get(iter[ACTIVITY_COL]).new(@client)
        end

        _show()
      end

      def _setup_filter_controls()
        enrollment_status_filters_toggleButton =
          @builder.get_object('enrollment_status_filters.ToggleButton')
        enrollment_status_filters_popover =
          @builder.get_object('enrollment_status_filters.Popover')

        enrollment_status_filters_popover.signal_connect('closed') {
          enrollment_status_filters_toggleButton.active = false
        }
        enrollment_status_filters_toggleButton.signal_connect('toggled') {
          enrollment_status_filters_popover.visible =
            enrollment_status_filters_toggleButton.active?
        }
      end

      def _fill_toolbox(list, icon_view)
        @activities.each do |ability|
          _create_ability_icon(ability, list, icon_view)
        end
      end

      def _create_ability_icon(ability, list, icon_view)
        case ability
        when :Roster
          pixbuf = GdkPixbuf::Pixbuf.new(
            file: ManabuDesktop::Tools.emojidex.emoji[:student].paths[:png][:px64])
        when :Courses
          pixbuf = GdkPixbuf::Pixbuf.new(
            file: ManabuDesktop::Tools.emojidex.emoji[:notebook].paths[:png][:px64])
        when :Exams
          pixbuf = GdkPixbuf::Pixbuf.new(
            file: ManabuDesktop::Tools.emojidex.emoji[:white_check_mark].paths[:png][:px64])
        when :Administration
          pixbuf = GdkPixbuf::Pixbuf.new(
            file: ManabuDesktop::Tools.emojidex.emoji[:wrench].paths[:png][:px64])
        else
          pixbuf = GdkPixbuf::Pixbuf.new(
            file: ManabuDesktop::Tools.emojidex.emoji[:question].paths[:png][:px64])
        end

        iter = list.append
        list.set_value(iter, ICON_COL, pixbuf)
        list.set_value(iter, LABEL_COL, I18n.t("g.#{ability.to_s}"))
        list.set_value(iter, ACTIVITY_COL, ability)
        icon_view.set_model(list)
      end
    end
  end
end


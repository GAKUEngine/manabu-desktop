require_relative 'base'
require_relative 'student/registration'
require 'manabu/client'
require 'manabu/students'

module ManabuDesktop
  module Screens
    class Roster < ManabuDesktop::Screens::Base

      attr_reader :column_order

      def initialize(client)
        @client = client
        super('roster')

        setup_columns()

        _setup_toolbar()
        _setup_search_filters()

        @window.show_all
        _show()
      end

      # Set the order of the columns
      # Possible columns:
      #   :id, :surname, :name, :middle_name, :surname_reading, :name_reading,
      #   :middle_name_reading, :gender, :dob, :enrollment
      def setup_columns(order = [:id, :surname, :name, :gender, :dob, :enrollment])
        @column_order = {select: 0}
        order.each do |item|
          @column_order[item] = @column_order.count
        end
        # @column_order << :controls # TODO: setup control column
        _create_columns()
      end

      def _create_model()
        # TODO: dynamically generate model based on selected columns/order
        @model = Gtk::ListStore.new(TrueClass, Integer, String, String, String, String)

        students = Manabu::Students.new(@client)
        students.roster.each_with_index do |student|
          iter = @model.append()
          iter.set_values([false, student.id, student.surname, student.name,
          #                     #student.surname_reading, student.name_reading,
                               student.birth_date, student.gender])
        end
      end

      def _create_columns()
        treeview = @builder.get_object('roster.TreeView')
        _create_model()
        treeview.set_model(@model)
        renderer = Gtk::CellRendererToggle.new
        renderer.signal_connect("toggled") { |_cell, path| _student_select(path) }
        column = Gtk::TreeViewColumn.new(I18n.t("g.select"), renderer,
                                         "active" => @column_order[:select])
        column.sort_column_id = @column_order[:select]
        treeview.append_column(column)

        renderer = Gtk::CellRendererText.new()
        column = Gtk::TreeViewColumn.new(I18n.t("student.id"), renderer,
                                         "text" => @column_order[:id])
        column.sort_column_id = @column_order[:id]
        treeview.append_column(column)

        renderer = Gtk::CellRendererText.new()
        column = Gtk::TreeViewColumn.new(I18n.t("student.surname"), renderer,
                                         "text" => @column_order[:surname])
        column.sort_column_id = @column_order[:surname]
        treeview.append_column(column)

        renderer = Gtk::CellRendererText.new()
        column = Gtk::TreeViewColumn.new(I18n.t("student.name"), renderer,
                                         "text" => @column_order[:name])
        column.sort_column_id = @column_order[:name]
        treeview.append_column(column)

        renderer = Gtk::CellRendererText.new()
        column = Gtk::TreeViewColumn.new(I18n.t("student.dob"), renderer,
                                         "text" => @column_order[:dob])
        column.sort_column_id = @column_order[:dob]
        treeview.append_column(column)

        renderer = Gtk::CellRendererText.new()
        column = Gtk::TreeViewColumn.new(I18n.t("student.gender"), renderer,
                                         "text" => @column_order[:gender])
        column.sort_column_id = @column_order[:gender]
        treeview.append_column(column)
      end

      def _student_select(path_str)
        path = Gtk::TreePath.new(path_str)
        iter = @model.get_iter(path)
        selected = iter[@column_order[:select]]
        # TODO: get student record and put in or remove from collection
        selected ^= 1
        iter[@column_order[:select]] = fixed
      end

      def _setup_toolbar()
        toolbar = @builder.get_object('roster.Toolbar')
        # new button
        register_student_button = Gtk::ToolButton.new(:stock_id => Gtk::Stock::NEW)
        register_student_button.label = I18n.t('student.register')
        register_student_button.signal_connect('clicked') do
          ManabuDesktop::Screens::Student::Registration.new(@client, self)
        end

        # separator
        sep = Gtk::SeparatorToolItem.new()

        # search/filtering box
       # search_container = Gtk::Box.new(:horizontal, 10)
       # search_entry = Gtk::SearchEntry.new()
       # search_bar = Gtk::SearchBar.new()
       # search_bar.connect_entry(search_entry)
       # search_bar.add(search_container)

        toolbar.insert(register_student_button, 0)
        toolbar.insert(sep, 1)
        #toolbar.insert(search_container, 2)
      end

      def _setup_search_filters()
        clear_filters_button = @builder.get_object('clear_filters.Button')
        clear_filters_button.set_label(I18n.t('g.clear'))

        enrollment_status_filters_toggleButton = \
          @builder.get_object('enrollment_status_filters.ToggleButton')
        enrollment_status_filters_toggleButton.set_label(I18n.t('enrollment.filter'))
        enrollment_status_filters_popover = \
          @builder.get_object('enrollment_status_filters.Popover')

        enrollment_status_filters_popover.signal_connect('closed') {
          enrollment_status_filters_toggleButton.active = false
        }
        enrollment_status_filters_toggleButton.signal_connect('toggled') {
          enrollment_status_filters_popover.visible =
            enrollment_status_filters_toggleButton.active?
        }
      end
    end
  end
end

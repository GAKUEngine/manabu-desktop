require_relative 'base'
require_relative 'student/registration'
require 'manabu/client'
require 'manabu/students'

module ManabuDesktop
  module Screens
    class Roster < ManabuDesktop::Screens::Base

      COLUMN_SELECT   = 0
      COLUMN_ID       = 1
      COLUMN_SURNAME  = 2
      COLUMN_NAME     = 3
      COLUMN_DOB      = 4
      COLUMN_SEX      = 5

      def initialize(client)
        @client = client
        super('roster')

        treeview = @builder.get_object('roster.treeview')
        toolbar = @builder.get_object('roster.toolbar')

        _create_model()
        treeview.set_model(@model)
        _create_columns(treeview)

        _setup_toolbar(toolbar)

        @window.show_all
        _show()
      end

      def _create_model()
        @model = Gtk::ListStore.new(TrueClass, Integer, String, String, String, String)

        students = Manabu::Students.new(@client)
        students.roster.each_with_index do |student|
          iter = @model.append()
          iter.set_values([false, student.id, student.surname, student.name,
          #                     #student.surname_reading, student.name_reading,
                               student.birth_date, student.gender])
        end
      end

      def _create_columns(treeview)
        renderer = Gtk::CellRendererToggle.new
        renderer.signal_connect("toggled") { |_cell, path| _student_select(path) }
        column = Gtk::TreeViewColumn.new(I18n.t("g.select"), renderer,
                                         "active" => COLUMN_SELECT)
        column.sort_column_id = COLUMN_SELECT
        treeview.append_column(column)

        renderer = Gtk::CellRendererText.new()
        column = Gtk::TreeViewColumn.new(I18n.t("student.id"), renderer,
                                         "text" => COLUMN_ID)
        column.sort_column_id = COLUMN_ID
        treeview.append_column(column)

        renderer = Gtk::CellRendererText.new()
        column = Gtk::TreeViewColumn.new(I18n.t("student.surname"), renderer,
                                         "text" => COLUMN_SURNAME)
        column.sort_column_id = COLUMN_SURNAME
        treeview.append_column(column)

        renderer = Gtk::CellRendererText.new()
        column = Gtk::TreeViewColumn.new(I18n.t("student.name"), renderer,
                                         "text" => COLUMN_NAME)
        column.sort_column_id = COLUMN_NAME
        treeview.append_column(column)

        renderer = Gtk::CellRendererText.new()
        column = Gtk::TreeViewColumn.new(I18n.t("student.dob"), renderer,
                                         "text" => COLUMN_DOB)
        column.sort_column_id = COLUMN_DOB
        treeview.append_column(column)

        renderer = Gtk::CellRendererText.new()
        column = Gtk::TreeViewColumn.new(I18n.t("student.sex"), renderer,
                                         "text" => COLUMN_SEX)
        column.sort_column_id = COLUMN_SEX
        treeview.append_column(column)
      end

      def _student_select(path_str)
        path = Gtk::TreePath.new(path_str)
        iter = @model.get_iter(path)
        fixed = iter[COLUMN_SELECT]
        # TODO: get student record and put in or remove from collection
        fixed ^= 1
        iter[COLUMN_SELECT] = fixed
      end

      def _setup_toolbar(toolbar)
        register_student_button = Gtk::ToolButton.new(:stock_id => Gtk::Stock::NEW)
        register_student_button.label = I18n.t('student.register')
        register_student_button.signal_connect "clicked" do
          ManabuDesktop::Screens::Student::Registration.new(@client, self)
        end
        sep = Gtk::SeparatorToolItem.new
        toolbar.insert(register_student_button, 0)
        toolbar.insert(sep, 1)
      end
    end
  end
end
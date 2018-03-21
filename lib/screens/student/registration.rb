require_relative '../base'
require_relative '../../tools' 
require 'manabu/client'
require 'manabu/student'
require 'manabu/students'

module ManabuDesktop
  module Screens
    module Student
      class Registration < ManabuDesktop::Screens::Base

        def initialize(client, parent)
          @client = client
          @parent = parent

          super('student_registration')

          # Name
          @builder.get_object('surname.Label').set_label(
            I18n.t('student.surname'))
          @surname_entry = @builder.get_object('surname.Entry')
          @builder.get_object('name.Label').set_label(
            I18n.t('student.name'))
          @name_entry = @builder.get_object('name.Entry')
          @builder.get_object('middle_name.Label').set_label(
            I18n.t('student.middle_name'))
          @middle_name_entry = @builder.get_object('middle_name.Entry')

          # Name readings
          @builder.get_object('surname_reading.Label').set_label(
            I18n.t('student.surname_reading'))
          @surname_reading_entry = @builder.get_object('surname_reading.Entry')
          @builder.get_object('name_reading.Label').set_label(
            I18n.t('student.name_reading'))
          @name_reading_entry = @builder.get_object('name_reading.Entry')
          @builder.get_object('middle_name_reading.Label').set_label(
            I18n.t('student.middle_name_reading'))
          @middle_name_reading_entry = @builder.get_object('middle_name_reading.Entry')

          # Gender
          @builder.get_object('gender.Label').set_label(I18n.t('student.gender'))
          gender_comboBoxText = @builder.get_object('gender.ComboBoxText')
          gender_comboBoxText.append_text(' ')
          gender_comboBoxText.append_text(I18n.t('student.male'))
          gender_comboBoxText.append_text(I18n.t('student.female'))

          # Birth date
          @builder.get_object('birth_date.Label').set_label(I18n.t('student.dob'))
          birth_date_picker_toggleButton = @builder.get_object('birth_date_picker.ToggleButton')
          pixbuf = GdkPixbuf::Pixbuf.new(
            file: ManabuDesktop::Tools.emojidex.emoji[:calendar].paths[:png][:hdpi])
          @builder.get_object('birth_date_picker.Image').set_pixbuf(pixbuf)
          birth_date_picker_popover = @builder.get_object('birth_date_picker.Popover')
          birth_date_picker_popover.signal_connect('closed') {
            birth_date_picker_toggleButton.active = false
          }
          birth_date_picker_calendar = @builder.get_object('birth_date_picker.Calendar')
          birth_date_picker_calendar.signal_connect('day-selected') {
            puts birth_date_picker_calendar.date
          }
          birth_date_picker_toggleButton.signal_connect('toggled') {
            birth_date_picker_popover.visible = birth_date_picker_toggleButton.active?
          }


          # Registration
          register_button = @builder.get_object('register.Button')
          register_button.set_label(I18n.t('g.register'))
          register_button.signal_connect('clicked') {
            _register(@surname_entry.text, @name_entry.text, @middle_name_entry.text,
                      @surname_reading_entry.text, @name_reading_entry.text,
                      @middle_name_reading_entry.text,
                      nil, nil, nil, nil)
          }

          _show()
        end

        # Compose and send a registration request
        def _register(surname, name, middle_name,
                      surname_reading, name_reading, middle_name_reading,
                      gender, dob, enrollment_status, picture_path)
          student = Manabu::Student.new(@client)
          student.surname = surname
          student.name = name
          student.middle_name = middle_name
          student.surname_reading = surname_reading
          student.name_reading = name_reading
          student.middle_name_reading = middle_name_reading
          # TODO: gender
          # TODO: DOB
          # TODO: enrollment_status
          # TODO: picture

          students = Manabu::Students.new(@client)
          students.register(student)

          @window.destroy
        end
      end
    end
  end
end

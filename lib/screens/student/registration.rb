require_relative '../base'
require 'manabu/client'
require 'manabu/student'

module ManabuDesktop
  module Screens
    module Student
      class Registration < ManabuDesktop::Screens::Base

        def initialize(client, parent)
          @client = client
          @parent = parent

          super('student_registration')
          
          @builder.get_object('surname.Label').set_label(
            I18n.t('student.surname'))
          @builder.get_object('name.Label').set_label(
            I18n.t('student.name'))
          @builder.get_object('middle_name.Label').set_label(
            I18n.t('student.middle_name'))

          @builder.get_object('surname_reading.Label').set_label(
            I18n.t('student.surname_reading'))
          @builder.get_object('name_reading.Label').set_label(
            I18n.t('student.name_reading'))
          @builder.get_object('middle_name_reading.Label').set_label(
            I18n.t('student.middle_name_reading'))


          @builder.get_object('gender.Label').set_label(I18n.t('student.gender'))
          gender_comboBoxText = @builder.get_object('gender.ComboBoxText')
          gender_comboBoxText.append_text(' ')
          gender_comboBoxText.append_text(I18n.t('student.male'))
          gender_comboBoxText.append_text(I18n.t('student.female'))
          @builder.get_object('birth_date.Label').set_label(I18n.t('student.dob'))

          @builder.get_object('register.Button').set_label(I18n.t('g.register'))

          _show()
        end
      end
    end
  end
end

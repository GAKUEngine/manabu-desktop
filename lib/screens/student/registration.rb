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


          @builder.get_object('sex.Label').set_label(I18n.t('student.sex'))
          sex_comboboxtext = @builder.get_object('sex.Comboboxtext')
          sex_comboboxtext.append_text(I18n.t('student.male'))
          sex_comboboxtext.append_text(I18n.t('student.female'))
          @builder.get_object('birth_date.Label').set_label(I18n.t('student.dob'))

          _show()
        end
      end
    end
  end
end

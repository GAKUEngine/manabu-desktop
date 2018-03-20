require_relative 'base'
require_relative 'toolbox'
require_relative '../util/cache'
require_relative '../sessions'
require 'manabu/client'

module ManabuDesktop
  module Screens
    class Login < ManabuDesktop::Screens::Base
      attr_accessor :cache_info, :client

      CACHE_FILE_NAME = "login_cache.manabu"

      def initialize()
        super('login')

        _load_cache()

        @window.resizable = false

        @builder.get_object('server.Label').set_label(I18n.t('login.server'))
        @builder.get_object('secure.Label').set_label(I18n.t('login.secure'))
        @server_comboBoxText = @builder.get_object('server.ComboBoxText')
        @server_secure_switch = @builder.get_object('secure.Switch')
        @cache_info[:servers].each{ |server| @server_comboBoxText.append_text(server[:addr])}
        if (@cache_info[:servers].length > 0)
          @server_comboBoxText.set_active(0)
          @server_secure_switch.active = @cache_info[:servers][0][:secure]
        end
        # TODO: set server details when selection is changed
        # TODO: allow deletion of a server entry
        # TODO: save new servers

        @builder.get_object('user.Label').set_label(I18n.t('login.user'))
        @user_entry = @builder.get_object('user.Entry')
        @builder.get_object('password.Label').set_label(I18n.t('login.password'))
        @password_entry = @builder.get_object('password.Entry')

        engage_button = @builder.get_object('engage.Button')
        engage_button.set_label(I18n.t('login.engage'))
        engage_button.signal_connect('clicked') {
          _engage(@server_comboBoxText.active_text, @server_secure_switch.active?,
                  @user_entry.text, @password_entry.text)
        }

        _show()
      end

      def _load_cache()
        @cache_info = ManabuDesktop::Util::Cache.load(CACHE_FILE_NAME)
        if (@cache_info === {} || !@cache_info.includes?(:servers) ||
            !@cache_info[:servers].instance_of?(Array))
          @cache_info = {
            servers: [{addr: 'localhost:9000', secure: false}]
          }
        end
      end

      def _save_cache()

      end

      def _engage(server, secure, user, password)
        addr = /^[^:|^\/]*[^:|^\/]/.match(server) # server part
        port = /[^:]\d[^\D]*/.match(server).to_s.to_i # port part
        port = 80 if (port == 0)
        route = /\/.*$/.match(server) #route part

        # TODO: first check if a session is already open to this server/port/user
        @client = Manabu::Client.new(user, password, "#{addr}#{route}", port,
                                     force_secure_connection: secure)
        if @client.status == :connected
          ManabuDesktop::Sessions.add_session(@client)
          _open_toolbox(@client)
        end
      end

      def _open_toolbox(client)
        @window.destroy
        ManabuDesktop::Screens::ToolBox.new(client)
      end

      def _update_server_list()
      end
    end
  end
end

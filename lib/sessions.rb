require_relative 'windows'

module ManabuDesktop
  class Sessions
    @@active_sessions = []

    def self.get_sessions()
      @@active_sessions
    end

    def self.session_count
      @@active_sessions.length
    end

    def self.add_session(session_handle)
      @@active_sessions << session_handle
      main_menu = ManabuDesktop::Windows.get_main_menu()
      main_menu.set_connections_status(session_count) unless main_menu == nil
    end

    def self.remove_session(session_identifier)
    end
  end
end

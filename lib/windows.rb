module ManabuDesktop
  class Windows
    @@main_menu = nil
    @@window_list = []

    def self.set_main_menu(handle)
      return false if @@main_menu != nil
      @@main_menu = handle
      true
    end

    def self.get_main_menu()
      @@main_menu
    end

    def self.add_window(handle)
      @@window_list << handle
    end

    def self.destroy_all()
      @@window_list.each do |window|
        window.destroy()
      end
    end
  end
end

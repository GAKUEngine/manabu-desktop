module ManabuDesktop
  module Util
    class Cache
      @@cache_path_override = nil

      def self.load(file)
        if File.exist?("#{cache_path()}/login_cache.msgpack")
          file = File.open("#{cache_path()}/login_cache.msgpack", 'rb')
          content = file.read()
          begin
            return MessagePack.unpack(content)
          rescue
          end          
        end
        {}
      end

      def self.cache_path()
        @@cache_path_override || ENV['MANABU_DESKTOP_CACHE'] || "#{ENV['HOME']}/.manabu-desktop/"
      end
    end
  end
end

require 'manabu/client'
require_relative '../lib/screens/toolbox'

client = Manabu::Client.new('admin', '123456', 'localhost', 9000, force_secure_connection: false)

toolbox = ManabuDesktop::Screens::ToolBox.new(client)

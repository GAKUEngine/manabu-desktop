Gem::Specification.new do |s|
  s.name         = 'manabu-desktop'
  s.version      = '0.0.5'
  s.licenses     = ['GPL-3.0']
  s.summary      = 'GTK based GUI client for Manabu/GAKU Engine'
  s.description  = 'Manabu Desktop is a GTK front end for the Manabu client.'
  s.post_install_message =  \
    "╔═════════════════════════╼\n" +
    "║Manabu GTK GUI for ⚙学 GAKU Engine [学エンジン] \n" +
    "╟─────────────────────────╼\n" +
    "║©2015 (株)幻創社 [Phantom Creation Inc.]\n" +
    "║http://www.gakuengine.com\n" +
    "╟─────────────────────────╼\n" +
    "║Manabu GTK is Open Sourced under the GPLv3.\n" +
    "╚═════════════════════════╼\n" 
  s.authors      = ['Rei Kagetsuki']
  s.email        = 'info@gakuengine.com'
  s.homepage     = 'http://www.gakuengine.com'

  s.files       = Dir.glob('lib/**/*.rb') +
                  Dir.glob('layouts/**/*.glade') +
                  Dir.glob('layouts/**/*.png') +
                  ['bin/manabu-desktop', 'manabu-desktop.gemspec']
  s.require_paths = ['lib']
  s.bindir = 'bin'
  s.executables << 'manabu-desktop'

  s.add_dependency 'manabu'
  s.add_dependency 'gtk3'
  s.add_dependency 'i18n'

  s.add_dependency 'emojidex'
  s.add_dependency 'emojidex-rasters'
end

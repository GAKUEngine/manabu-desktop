Gem::Specification.new do |s|
  s.name         = 'manabu-desktop'
  s.version      = '0.0.1'
  s.licenses     = ['GPLv3']
  s.summary      = 'GTK based GUI client for Manabu/GAKU Engine'
  s.description  = 'Manabu Desktop is a GTK front end for the Manabu client.'
  s.post_install_message =  \
    '╔═════════════════════════╼' +
    "║Manabu GTK GUI for ⚙学 GAKU Engine [学エンジン] " +
    '╟─────────────────────────╼' +
    '║©2015 (株)幻創社 [Phantom Creation Inc.]' +
    '║http://www.gakuengine.com' +
    '╟─────────────────────────╼' +
    '║Manabu GTK is Open Sourced under the GPLv3.' +
    '╚═════════════════════════╼' 
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
end

class people::fukayatsu {
  include dropbox
  include skype
  include iterm2::stable #::devもある
  include chrome

  # homebrewでインストール
  package {
    [
      'tmux',
      'reattach-to-user-namespace',
      'tig',
      'postgresql'
    ]:
  }

  # zshのインストール with osx
  include osx
  package {
    'zsh':
      install_options => [
        '--disable-etcdir'
      ]
  }
  file_line { 'add zsh to /etc/shells':
    path    => '/etc/shells',
    line    => "${boxen::config::homebrewdir}/bin/zsh",
    require => Package['zsh'],
    before  => Osx_chsh[$::luser];
  }
  osx_chsh { $::luser:
    shell   => "${boxen::config::homebrewdir}/bin/zsh";
  }

  # Mac appのインストール
  package {
    'Kobito':
      source   => "http://kobito.qiita.com/download/Kobito_v1.2.0.zip",
      provider => compressed_app;
    'XtraFinder':
      source   => "http://www.trankynam.com/xtrafinder/downloads/XtraFinder.dmg",
      provider => pkgdmg;
  }

  $home     = "/Users/${::luser}"
  $src      = "${home}/src"
  $dotfiles = "${src}/dotfiles"

  # ~/src/dotfilesにGitHub上のtaka84u9/dotfilesリポジトリを
  # git-cloneする。そのとき~/srcディレクトリがなければいけない。
  repository { $dotfiles:
    source  => "taka84u9/dotfiles",
    require => File[$src]
  }
  # git-cloneしたらインストールする
  exec { "sh ${dotfiles}/symlink.sh":
    cwd => $dotfiles,
    creates => "${home}/.zshrc",
    require => Repository[$dotfiles],
  }
}
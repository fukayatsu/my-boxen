class people::fukayatsu {
  include dropbox
  include skype
  include iterm2::stable #::devもある
  include chrome
  include sublime_text_2

  # homebrewでインストール
  package {
    [
      'tmux',
      'reattach-to-user-namespace',
      'tig'
    ]:
  }

  $home     = "/Users/${::luser}"
  $src      = "${home}/src"
  $dotfiles = "${src}/dotfiles"

  # ~/src/dotfilesにGitHub上のfukayatsu/dotfilesリポジトリを
  # git-cloneする。そのとき~/srcディレクトリがなければいけない。
  repository { $dotfiles:
    source  => "fukayatsu/dotfiles",
    require => File[$src]
  }
  # git-cloneしたらインストールする
  exec { "sh ${dotfiles}/symlink.sh":
    cwd => $dotfiles,
    creates => "${home}/.zshrc",
    require => Repository[$dotfiles],
  }
}



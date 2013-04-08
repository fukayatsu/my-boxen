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
      'tig'
    ]:
  }
}



require "fileutils"

SOURCE_DIR_SKIP_FILES = %[Rakefile README vendor config install.sh bin]
CONFIG_DIR_LINKS = %w[nvim]

HOME_DIR = ENV["HOME"]
HOME_CONFIG_DIR = File.join(HOME_DIR, ".config")
SOURCE_DIR = File.join(HOME_DIR, ".dotfiles")
CONFIG_SOURCE_DIR = File.join(SOURCE_DIR, "config")

def skip_source_file?(file)
  file[0..0] == "." || SOURCE_DIR_SKIP_FILES.include?(file)
end

def link_file(source, deset)
  return if File.symlink?(deset)

  if File.exists?(deset)
    puts "#{source} already exists.  Creating backup..."
    backup = "#{deset}.backup"
    if File.exists? backup
      puts "\tBackup aleady exists."
    else
      FileUtils.move(deset, backup)
    end
  end

  puts "Linking #{source} to #{deset}"
  File.symlink(source, deset)
end

def unlink_file(dest)
  if File.symlink? dest
    puts "Unlinking #{dest}"
    File.unlink(dest)
  elsif File.exists? dest
    puts "#{dest} is not a symlink... skipping..."
  end
end

desc "Install dotfiles"
task install: [:link, :init_submodules]

desc "Uninstall dotfiles"
task uninstall: [:unlink]

task :init_submodules do
  system "git submodule init"
  system "git submodule update"
end

desc "Create links from dotfiles to home directory"
task :link do
  Dir.foreach(SOURCE_DIR) do |file|
    next if skip_source_file?(file)

    link_file(File.join(SOURCE_DIR, file), File.join(HOME_DIR, ".#{file}"))
  end

  CONFIG_DIR_LINKS.each do |file|
    link_file(File.join(CONFIG_SOURCE_DIR, file), File.join(HOME_CONFIG_DIR, file))
  end
end

desc "Delete links to dotfiles in home directory"
task :unlink do
  Dir.foreach(SOURCE_DIR) do |file|
    next if skip_source_file?(file)

    unlink_file(File.join(HOME_DIR, ".#{file}"))
  end

  CONFIG_DIR_LINKS.each do |file|
    unlink_file(File.join(HOME_CONFIG_DIR, file))
  end
end

task :vim_setup do
  system "vim +PluginInstall +qall"
end

task :iterm2_setup do
  puts %|defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "#{SOURCE_DIR}/config/iterm2"|
  puts %|defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true|
end

task :macos_write_defautls do
  system %|chmod u+x "#{SOURCE_DIR}/config/macos/write_defaults"|
  system %|"#{SOURCE_DIR}/config/macos/write_defaults"|
end

task :brew_install do
  system %|chmod u+x "#{SOURCE_DIR}/config/brew/install"|
  system %|"#{SOURCE_DIR}/config/brew/install"|
end

task macos_setup: [:macos_write_defautls, :brew_install, :iterm2_setup]

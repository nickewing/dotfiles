require "fileutils"

SOURCE_DIR = "#{ENV['HOME']}/.dotfiles"
SKIP_FILES = ["Rakefile", "README", "vendor", "config", "install.sh"]

def skip?(f)
  f[0..0] == "." || SKIP_FILES.include?(f)
end

def source_path(file)
  "#{SOURCE_DIR}/#{file}"
end

def dot_path(file)
  "#{ENV['HOME']}/.#{file}"
end

desc "Install dotfiles"
task :install => [:link, :init_submodules, :vim_setup, :iterm2_setup]

desc "Uninstall dotfiles"
task :uninstall => [:unlink]

task :init_submodules do
  system "git submodule init"
  system "git submodule update"
end

desc "Create links from dotfiles to home directory"
task :link do
  Dir.foreach(SOURCE_DIR) do |f|
    next if skip? f

    path = dot_path(f)
    next if File.symlink?(path)

    if File.exists?(path)
      puts "#{f} already exists.  Creating backup..."
      backup = "#{path}.backup"
      if File.exists? backup
        puts "\tBackup aleady exists."
      else
        FileUtils.move(path, backup)
      end
    end

    puts "Linking #{f} to #{path}"
    File.symlink(source_path(f), path)
  end
end

desc "Delete links to dotfiles in home directory"
task :unlink do
  Dir.foreach(SOURCE_DIR) do |f|
    next if skip? f

    path = dot_path(f)

    if File.symlink? path
      puts "Unlinking #{path}"
      File.unlink(path)
    elsif File.exists? path
      puts "#{path} is not a symlink... skipping..."
    end
  end
end

task :vim_setup do
  system "vim +PluginInstall +qall"
  system "cd vendor/matcher && make"
end

task :iterm2_setup do
  system %|defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "#{SOURCE_DIR}/iterm2"|
  system %|defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true|
end

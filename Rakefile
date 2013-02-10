require 'fileutils'

SOURCE_DIR = "#{ENV['HOME']}/.dotfiles"
SKIP_FILES = ['Rakefile', 'README', 'vendor', 'config']

def skip?(f)
  f[0..0] == '.' || SKIP_FILES.include?(f)
end

def source_path(file)
  "#{SOURCE_DIR}/#{file}"
end

def dot_path(file)
  "#{ENV['HOME']}/.#{file}"
end

desc 'Install dotfiles'
task :install => [:init_submodules, :vim_setup, :irb_setup, :link]

task :init_submodules do
  system "git submodule init"
  system "git submodule update"
end

desc 'Create links from dotfiles to home directory'
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

desc 'Delete links to dotfiles in home directory'
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
  system "vim +BundleInstall +qall"
  #system "cd vim/bundle/matcher && make"
end

task :irb_setup do
  system "cd config/irb && bundle install"
end

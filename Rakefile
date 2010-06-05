require 'ftools'

SOURCE_DIR = "#{ENV['HOME']}/.dotfiles"
SKIP_FILES = ['.', '..', '.git', 'Rakefile']

def source_path(file)
  "#{SOURCE_DIR}/#{file}"
end

def dot_path(file)
  "#{ENV['HOME']}/.#{file}"
end

desc 'Create links from dotfiles to home directory'
task :link do
  Dir.foreach(SOURCE_DIR) do |f|
    next if SKIP_FILES.include? f

    path = dot_path(f)

    if File.exists? path
      puts "#{f} already exists.  Creating backup..."
      File.move(path, "#{path}.backup")
    end

    puts "Linking #{f} to #{path}..."
    puts File.symlink(source_path(f), path)
  end
end

desc 'Delete links to dotfiles in home directory'
task :unlink do
  Dir.foreach(SOURCE_DIR) do |f|
    next if SKIP_FILES.include? f

    path = dot_path(f)

    if File.symlink? path
      puts "Unlinking #{path}..."
      puts File.unlink(path)
    elsif File.exists? path
      puts "#{path} is not a symlink... skipping..."
    else
      puts "#{path} does not exist."
    end
  end
end

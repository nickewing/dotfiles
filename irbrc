require 'rubygems'
require 'pp'

begin
  require 'looksee'
  require 'interactive_editor'
  require 'wirble'

  # Colors
  # http://pablotron.org/software/wirble/
  Wirble.init
  Wirble::Colorize.colors = Wirble::Colorize.colors.merge({
    :comma              => :light_blue,
    :refers             => :light_blue,

    :open_hash          => :light_blue,
    :close_hash         => :light_blue,
    :open_array         => :light_blue,
    :close_array        => :light_blue,

    :open_object        => :light_blue,
    :object_class       => :light_blue,
    :object_addr_prefix => :light_blue,
    :object_line_prefix => :light_blue,
    :close_object       => :light_blue,

    :symbol             => :red,
    :symbol_prefix      => :red,

    :open_string        => :green,
    :string             => :green,
    :close_string       => :green,

    :number             => :red,
    :keyword            => :yellow,
    :range              => :red,
    :class              => :cyan
  })
  Wirble.colorize
rescue LoadError => err
end

if IRB
  # Create a custom prompt
  if IRB.conf and IRB.conf[:PROMPT]
    IRB.conf[:PROMPT][:CUSTOM] = {
      :PROMPT_N => "> ",
      :PROMPT_I => "> ",
      :PROMPT_S => nil,
      :PROMPT_C => "> ",
      :RETURN   => ""
    }
  end

  # Set default prompt
  # IRB.conf[:PROMPT_MODE]  = :CUSTOM
  IRB.conf[:AUTO_INDENT]  = true
  IRB.conf[:USE_READLINE] = true
end

# Log to terminal when in Rails console
if ENV.include?('RAILS_ENV') && !Object.const_defined?('RAILS_DEFAULT_LOGGER')
  require 'logger'
  RAILS_DEFAULT_LOGGER = Logger.new(STDOUT)
end


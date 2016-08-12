#!/usr/bin/ruby

require 'yaml'
require 'colorize'
require 'net/ssh'
require 'mixlib/cli'

class ComparaDirOptions
  include Mixlib::CLI

  option :servers,
    :short        => "-s /path/to/servers.yaml",
    :long         => "--servers /path/to/servers.yaml",
    :description  => "yaml file with servers",
    :default      => "servers.yaml"

  option :directories,
    :short        => "-d /path/to/directories.yaml",
    :long         => "--directories /path/to/directories.yaml",
    :description  => "yaml file with directories to compare",
    :default      => "directories.yaml"
end
#path = '/opt/autentia/www'
#default_user = 'root'
#default_port = '14225'

options = ComparaDirOptions.new
options.parse_options

def run(options)
  @servers.each do |web,srv|
    Net::SSH.start(srv, options[:default_user], :port => options[:default_port]) do |ssh|
      dirs.each { |dir|
        output = ssh.exec!("[ -d #{path}/#{dir} ] && OK")
        if output.include? "OK"
          # Verbose mode
          print "[#{web}] [INFO] - ".green
          puts "Directorio coincide"
        else
          # Verbose mode
          print "[#{web}] [WARN] - ".red
          puts "Revisar directorio en: #{path}/#{dir}\n"
        end
      }
    end
  end
end

private
  def servers
    @servers ||= YAML.load_file(options.config[:servers])
  end

  def dirs
    @dirs ||= YAML.load_files(options.config[:directories])
  end

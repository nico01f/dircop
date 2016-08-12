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

  option :user,
    :short        => "-u root",
    :long         => "--user root",
    :description  => "username to ssh login",
    :default      => "root"

  option :port,
    :short        => "-p 22",
    :long         => "--port 22",
    :description  => "ssh port for remote server",
    :default      => "22"

  option :path,
    :long         => "--path /var/www",
    :description  => "remote path to compare",
    :default      => "/var/www"

  option :verbose,
    :short        => "-v",
    :long         => "--verbose",
    :description  => "debug"

  option :help,
    :short        => "-h",
    :long         => "--help",
    :description  => "Show this message",
    :on           => :tail,
    :boolean      => true,
    :show_options => true,
    :exit         => 0
end

class Compara

  def initialize
    arguments = ComparaDirOptions.new
    arguments.parse_options
    args = {
      :directories  => arguments.config[:directories],
      :servers      => arguments.config[:servers],
      :port         => arguments.config[:port],
      :user         => arguments.config[:user],
      :path         => arguments.config[:path],
      :verbose      => arguments.config[:verbose]
    }
    get_servers(args[:servers])
    get_dirs(args[:directories])
    run(args)
  end

  private

    def run(options = {})
      @servers.each do |k,v|
        Net::SSH.start(v, options[:user], :port => options[:port]) do |ssh|
          @dirs.each { |dir|
            output = ssh.exec!("[ -d #{options[:path]}/#{dir} ] && OK")
            if output.include? "OK"
              print "[#{v}] [OK] - ".green if options[:verbose]
              puts "Directorio coincide" if options[:verbose]
            else
              print "[#{v}] [CHECK] - ".red
              puts "Revisar directorio en: #{options[:path]}/#{dir}\n"
            end
          }
        end
      end

    rescue Exception => error
      puts error

    end

    def get_servers(servers)
      @servers ||= YAML.load_file(servers)
    end

    def get_dirs(dirs)
      @dirs ||= YAML.load_file(dirs)
    end

end

Compara.new

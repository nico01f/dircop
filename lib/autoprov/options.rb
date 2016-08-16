module Autprov
  module Options
    require 'mixlib/cli'

    class ComparaDirOptions
      include Mixlib::CLI

      option :servers,
        :short        => "-s /path/to/servers.yaml",
        :long         => "--servers /path/to/servers.yaml",
        :description  => "yaml file with servers",
        :default      => "files/servers.yaml"

      option :directories,
        :short        => "-d /path/to/directories.yaml",
        :long         => "--directories /path/to/directories.yaml",
        :description  => "yaml file with directories to compare",
        :default      => "files/directories.yaml"

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

  end

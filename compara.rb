#!/usr/bin/ruby

require 'yaml'
require 'colorize'
require 'net/ssh'

# Servers arrays
CONN = YAML.load_file('servers.yaml') unless defined? CONN

# Directories arrays
DIR_LIST = YAML.load_file('directorios.yaml') unless defined? DIR_LIST

# TO-DO: Loop servers
path = '/opt/autentia/www'
default_user = 'root'
default_port = '14225'

CONN.each do |k,v|
  Net::SSH.start(v, default_user, :port => default_port) do |ssh|
    DIR_LIST.each { |dir|
      output = ssh.exec!("[ -d #{path}/#{dir} ] && OK")
      if output.include? "OK"
        print "[#{k}] | [INFO] - ".green
        puts "Directorio coincide"
      else
        print "[#{k}] | [WARN] - ".red
        puts "Revisar directorio en: #{path}/#{dir}\n"
      end
    }
  end
end

require 'yaml'
require 'colorize'
require 'net/ssh'

# Arreglo de conexion
CONN = YAML.load_file('servers.yaml') unless defined? CONN
#Listado de directorios a buscar
DIR_LIST = YAML.load_file('directorios.yaml') unless defined? DIR_LIST

serv = CONN['web01']
port = CONN['puerto'].to_s
user = 'root'


Net::SSH.start(serv, :port=>port, :username=>'root') do |ssh|
  DIR_LIST.each { |dir|
    if Dir.exist?(dir) == false
      print "[ELIMINAR] - ".red
      puts "Directorio: #{dir} no existe"
    else
      print "[MANTENER] - ".green
      puts "Directorio: #{dir} existe"
    end


    }
end

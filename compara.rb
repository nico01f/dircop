require 'yaml'
require ''
# Arreglo de conexion
CONN = YAML.load_file('servers.yaml') unless defined? CONN
#Listado de directorios a buscar
DIR_LIST = YAML.load_file('directorios.yaml') unless defined? DIR_LIST

serv = CONN['web01']
port = CONN['puerto'].to_s
user = 'root'


Net::SSH.start(serv, :port=>port, :username=>'root') do
  DIR_LIST.each { |dir|
    if Dir.exist?(dir) == false
      puts 

    end


    }
end

require 'yaml'
require ''
# Arreglo de conexion
CONEXION = YAML.load_file('servers.yaml') unless defined? CONEXION
#Listado de directorios a buscar
DIRECTORIOS = YAML.load_file('directorios.yaml') unless defined? DIRECTORIOS

serv = CONEXION['web01']
puerto= CONEXION['puerto'].to_s


DIRECTORIOS.each { |dir|
  # Comprueba si existe directorio
  }

require 'yaml'

# A
CONEXION = YAML.load_file('servers.yaml') unless defined? CONEXION

serv = CONEXION['web01']
puerto= CONEXION['puerto'].to_s

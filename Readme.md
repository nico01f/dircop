## Dircop


Retrieve list of directories are different in servers. Useful if you want unsure if files are replicated through servers.

*Files:*
- servers.yaml : This file contains list of servers
- directories.yaml : Contains list of directories

### How tu use:

#### Install dependencies:

`cd dircop ; bundle install` for global installation of dependencies or if you want, use ruby-enviroment `cd dircop ; source bin/activate`, and for deactivate enviroment use `deactivate`

Note: ruby-enviroment it's a gem for creating ruby execution enviroment. Gem installed in this workplace are locally executed.

`./dircop.rb -p 14225 --path /path/to/compare`

```
Usage: ./dircop.rb (options)
    -d /path/to/directories.yaml,    yaml file with directories to compare
        --directories
        --path /var/www              remote path to compare
    -p, --port 22                    ssh port for remote server
    -s /path/to/servers.yaml,        yaml file with servers
        --servers
    -u, --user root                  username to ssh login
    -V, --verbose                    debug
    -h, --help                       Show this message
```

## TO-DO
- [ ] Make for files: example cgi-bin
- [x] Convert to script

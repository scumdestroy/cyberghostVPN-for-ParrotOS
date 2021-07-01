[CyberGhost Linux Application]
    Version: 1.2.0
[Install]
    - Run 'install.sh' script from the downloaded app's folder via "sudo bash install.sh" command
    
[Uninstall]
    - Run command: sudo cyberghostvpn --uninstall
    
[Setup a new account/device]
    - Run command: sudo cyberghostvpn --setup   
    
[Using Application]
    - To view help type: "cyberghostvpn" or "cyberghostvpn --help":
                Cyberghost - 1.2.0
                Available arguments:
                  SERVER TYPES
                    --server-type <serverType>    : Connect to specified server type. Available types: traffic, streaming and torrent. Default value: traffic.
                    --traffic                     : Show only traffic countries.
                    --streaming <serviceName>     : Get streaming service.
                    --torrent                     : Show only torrent countries.
                  OTHER COMMANDS
                    --country-code <countryCode>  : Connect a specified country. If argument city is not set will be connected to random city from chosen country.
                    --city <cityName>             : Connect a specified city from a country.
                    --server <serverName>         : Connect to a specified server.
                    --connect                     : Prepare a new VPN connection.
                    --status                      : Check if we have VPN connection opened.
                    --stop                        : Terminate all VPN connection.
    [Using Services]
        The default service is: TRAFFIC
        NOTE: all string which contains spaces are written between simple or double quotes
        
        [Traffic]
            - connect to traffic servers
            - Examples:
                [List]
                    - List all countries type: cyberghostvpn --country-code
                    - List a city for a specified country type: cyberghostvpn --country-code us
                    - List all servers for a specified city type:
                        - cyberghostvpn --country-code us --city miami
                        - cyberghostvpn --country-code us --city 'new york'
                [Connect]
                    - Connect to a random city for a specified country type: cyberghostvpn --country-code us --connect
                    - Connect to a random server for a specified city type: cyberghostvpn --country-code us --city 'new york' --connect
                    - Connect to a specified server type:
                        - sudo cyberghostvpn --country-code us --city 'new york' --server newyork-s23-i12 --connect
                        - sudo cyberghostvpn --server newyork-s23-i12 --connect
        [Streaming]
            - connect to streaming servers
            - Examples:
                [List]
                    - List all streaming services and countries type: cyberghostvpn --streaming --country-code
                    - List a specified streaming service for all countries type: cyberghostvpn --streaming netflix --country-code
                    - List all streaming services for a specified country type: cyberghostvpn --streaming  --country-code us
                    - List all servers for a specified city: cyberghostvpn.py --streaming netflix --country-code us --city atlanta
                [Connect]
                    - Connect to a random city type: sudo cyberghostvpn --streaming netflix --country-code us --connect
                    - Connect to a random server for a specified city type: sudo cyberghostvpn --streaming netflix --country-code us --city atlanta --connect
                    - Connect to a specified server type: sudo cyberghostvpn --streaming netflix --country-code us --city atlanta --server atlanta-s01-i01 --connect
        [Torrent]
            - connect to torrent servers
            - Examples:
                [List]
                    - List all countries type: cyberghostvpn --torrent --country-code
                    - List a city for a specified country type:
                        - cyberghostvpn --torrent --country-code fr
                    - List all servers for a specified city type:
                        - cyberghostvpn --torrent --country-code fr --city paris
                [Connect]
                    - Connect to a random city for a specified country type: sudo cyberghostvpn --torrent --country-code fr --connect
                    - Connect to a random server for a specified city type: sudo cyberghostvpn --torrent --country-code fr --city paris --connect
                    - Connect to a specified server type:
                        - sudo cyberghostvpn --torrent --country-code fr --city paris --server paris-s01-i01 --connect
                        - sudo cyberghostvpn --server paris-s01-i01 --connect
    - To connect to a specified country/city/server use "--connect" parameter
    - To check OpenVPN status type "cyberghostvpn --status"
    - To close all OpenVPN connections type "cyberghostvpn --stop"
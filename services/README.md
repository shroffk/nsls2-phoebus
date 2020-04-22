All 3 alarm services are part of the phoebus/services. 

They can all be built using the `build-alarm.sh` script. The script downloads and install java, elastic search, and kafka.

### Installing the alarm server  

Setting up the alarm server requires the following steps

 1. Update the Kafka config 
    Update `server.properties` with the following line  
    ```
    log.dirs=/opt/css/data/kafka-logs
    ```
   
   Copy the `services/startup-scripts/zookeeper.service` to `etc/systemd/`  
   Copy the `services/startup-scripts/kafka.service` to `etc/systemd/`  
   
 2. Update the startup scripts for the alarm server `alarm.service`  
    Update the following lines (lines 33 & 34)  
    ```
    Environment=SETTINGS=/opt/css/preferences/accl/settings.ini
    Environment=CONFIG=NSLS2_OPR
    ```
    
    Copy the `alarm.service` into `etc/systemd/`  

### Installing the alarm logging service

 1. Update the startup scripts for the alarm logging service `alarm-logger.service`  
    Update the following lines (lines 33)  
    ```
    Environment=CONFIG=NSLS2_OPR
    ```
    
    Copy the `alarm.service` into `etc/systemd/`  


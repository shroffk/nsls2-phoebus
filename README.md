# nsls2-phoebus
NSLS2 phoebus product

A set of install and build scripts to setup nsls2-phoebus product on the nsls2 controls/internal n/w.  
It also consists of settings and configuration needed to run cs-studio effectively on the nsls2 n/w.  


### Install NSLS2 Phoebus

Clone the nsls2-phoebus product repo to the installation location.

```
git clone https://github.com/shroffk/nsls2-phoebus
./build.sh
```


### Run NSLS2 Phoebus

```
./run-phoebus
```

If installing on a multi-user host, edit the run-phoebus TOP to point to the phoebus installation folder.  

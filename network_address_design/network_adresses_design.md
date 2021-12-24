# CIDR : 10.0.0.0/21
* Netmask: 255.255.248.0
* First Usable IP: 10.0.0.1
* Last Usable IP: 10.0.7.254
* Count: 2048

#Address distribution:
# Availability Zone A
Public Subnet 1:
* 10.0.0.0/24
* Count: 256
* First Usable IP: 10.0.0.1
* Last Usable IP: 10.0.0.254
* Netmask: 255.255.255.0

Private Subnet 1:
* 10.0.2.0/23
* Count: 512
* First Usable IP: 10.0.2.1
* Last Usable IP: 10.0.3.254
* Netmask: 255.255.254.0

#Availability Zone B
* Public Subnet 2:
* 10.0.1.0/24
* Count: 256
* First Usable IP: 10.0.1.1
* Last Usable IP: 10.0.1.254
* Netmask: 255.255.255.0

Private Subnet 2:
* 10.0.4.0/23
* Count: 512
* First Usable IP: 10.0.4.1
* Last Usable IP: 10.0.5.254
* Netmask: 255.255.254.0
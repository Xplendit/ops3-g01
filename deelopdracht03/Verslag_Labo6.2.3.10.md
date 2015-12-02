## Labo6.2.3.10 Troubleshooting Multiarea OSPFv2 and OSPFv3

### Stappenplan

Zet de opstelling op zoals in de opgave en kopieer de configuraties naar de juiste routers.

1. Vergelijk de configuratie van de router met de gegevens. Dit doe je door het commando `sh run` (show running config) op de router uit te voeren. 
2. In deze file controleer je eerst of alle IP-adressen correct ingevuld zijn en of er nog moeten toegevoegd worden.

commands om te controleren zijn:
* `sh run` toont de configuration
* `show ip route ospf` (ip kan door ipv6 vervangen worden)
* `show ip ospf neighbor` (ip kan door ipv6 vervangen worden)
* `ping` met de ip addressen van de andere routers
* `show ipv6 protocols`

### R1

		en
		conf t

		int s0/0/0
		no ip address
		ip address 192.168.12.1 255.255.255.252
		no shutdown
		
		router ospf 1
		network 192.168.1.0 0.0.0.255 area 1

		int lo1
		no ipv6 address
		ipv6 address 2001:DB8:ACAD:1::1/64
		ipv6 ospf 1 area 1

		ipv6 router ospf 1
		router-id 1.1.1.1
		
		clear ipv6 ospf process


###R2

		int lo6
		no ipv6 address 2001:DB8:CAD:6::1/64
		ipv6 address 2001:DB8:ACAD:6::1/64
		ipv6 ospf 1 area 3

###R3

		router ospf 1
		network 192.168.23.0 0.0.0.3 area 3
## Labo6.2.3.9 Configuring Multiarea OSPFv3

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
		hostname R1
		int s0/0/0
		clock rate 128000
		ipv6 address 2001:db8:acad:12::1/64
		ipv6 address fe80::1 link-local
		no shutdown
		int lo0
		ipv6 address 2001:db8:acad::1/64
		int lo1
		ipv6 address 2001:db8:acad:1::1/64
		int lo2
		ipv6 address 2001:db8:acad:2::1/64
		int lo3
		ipv6 address 2001:db8:acad:3::1/64
		exit
		ipv6 unicast-routing
		ipv6 router ospf 1
		router-id 1.1.1.1
		exit
		int lo0
		ipv6 ospf 1 area 1
		ipv6 ospf network point-to-point
		int lo1
		ipv6 ospf 1 area 1
		ipv6 ospf network point-to-point
		int lo2
		ipv6 ospf 1 area 1
		ipv6 ospf network point-to-point
		int lo3
		ipv6 ospf 1 area 1
		ipv6 ospf network point-to-point
		int s0/0/0
		ipv6 ospf 1 area 0


###R2

		en
		conf t
		hostname R2
		int s0/0/0
		clock rate 128000
		ipv6 address 2001:db8:acad:12::2/64
		ipv6 address fe80::2 link-local
		no shutdown
		int s0/0/1
		clock rate 128000
		ipv6 address 2001:db8:acad:23::2/64
		ipv6 address fe80::2 link-local
		no shutdown
		int lo8
		ipv6 address 2001:db8:acad::8:1/64
		exit
		ipv6 unicast-routing
		ipv6 router ospf 1
		router-id 2.2.2.2
		int s0/0/0
		ipv6 ospf 1 area 0
		int s0/0/1
		ipv6 ospf 1 area 0
		int lo8
		ipv6 ospf 1 area 0
		ipv6 ospf network point-to-point
			

###R3

		en
		conf t
		hostname R3
		int s0/0/1
		clock rate 128000
		ipv6 address 2001:db8:acad:23::3/64
		ipv6 address fe80::3 link-local
		no shutdown
		int lo4
		ipv6 address 2001:db8:acad:4::1/64
		int lo5
		ipv6 address 2001:db8:acad:5::1/64
		int lo6
		ipv6 address 2001:db8:acad:6::1/64
		int lo7
		ipv6 address 2001:db8:acad:7::1/64
		exit
		ipv6 unicast-routing
		ipv6 router ospf 1
		router-id 3.3.3.3
		int lo4
		ipv6 ospf 1 area 2
		ipv6 ospf network point-to-point
		int lo5
		ipv6 ospf 1 area 2
		ipv6 ospf network point-to-point
		int lo6
		ipv6 ospf 1 area 2
		ipv6 ospf network point-to-point
		int lo7
		ipv6 ospf 1 area 2
		ipv6 ospf network point-to-point
		int s0/0/1
		ipv6 ospf 1 area 0
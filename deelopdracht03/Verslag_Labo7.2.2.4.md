## Labo6.2.3.10 Troubleshooting Multiarea OSPFv2 and OSPFv3

### Stappenplan

### R1

		en
		conf t
		router eigrp 1
		do show ip route

`C` (Connected) duid op een netwerk adres.
`L` (Local) duid op een interface adres.

		network 172.16.1.1 0.0.0.255
		network 172.16.3.1 0.0.0.3
		network 192.168.10.4 0.0.03
		
		passive-interface g0/0
		
		no auto-summary

		copy run start

### R2

		en
		conf t
		router eigrp 1

		network 172.16.2.1 0.0.0.255
		network 172.16.3.2 0.0.0.3
		network 192.168.10.9 0.0.0.3
		
		passive-interface g0/0
		
		no auto-summary

		copy run start

## R3

		en
		conf t
		router eigrp 1

		network 192.168.1.10 0.0.0.255
		network 192.168.10.4 0.0.0.3
		network 192.168.10.10 0.0.0.3

		passive-interface g0/0
		
		no auto-summary

		copy run start

## Commando's om te controlleren

`show ip eigrp neighbors`
`show ip protocols`
EIGRP metric weight:
	* k1 = bandwith
	* k2 = load
	* k3 = delay
	* k4 = reliability
	* k5 = MTU


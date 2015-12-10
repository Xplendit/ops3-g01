## Labo7.2.2.5 

### Stappenplan

* Stel de opstelling op in packet tracer zoals in de opgave.

![](https://github.com/HoGentTIN/ops3-g01/blob/master/deelopdracht03/7.2.2.5/lab7.2.2.5.PNG)

* Configureer de PC's met de correcte adressen.
* Zet de basis opstelling van de routers op

**R1**

		en
		conf t
		hostname R1
		int g0/0
		ip add 192.168.1.1 255.255.255.0
		no sh
		
		int s0/0/0
		ip add 10.1.1.1 255.255.255.252
		clock rate 128000
		no sh
		
		int s0/0/1
		ip add 10.3.3.1 255.255.255.252
		no sh
		
		end
**R2**

		en
		conf t
		hostname R2
		int g0/0
		ip add 192.168.2.1 255.255.255.0
		no sh
		
		int s0/0/0
		ip add 10.1.1.2 255.255.255.252
		no sh
		
		int s0/0/1
		ip add 10.2.2.2 255.255.255.252
		clock rate 128000
		no sh
		end
**R3**

		en
		conf t
		hostname R3
		int g0/0
		ip add 192.168.3.1 255.255.255.0
		no sh
		
		int s0/0/0
		ip add 10.3.3.2 255.255.255.252
		clock rate 128000
		no sh
		
		int s0/0/1
		ip add 10.2.2.1 255.255.255.252
		no sh
		end

* Controleren met ping 
* Stel de EIGRP in

**R1**

		router eigrp 10
		network 10.1.1.0 0.0.0.3
		network 192.168.1.0 0.0.0.3
		network 10.3.3.0 0.0.0.3

**R2**

		router eigrp 10
		network 192.168.2.0 0.0.0.255
		network 10.1.1.0 0.0.0.3
		network 10.2.2.0 0.0.0.3

**R3**

		router eigrp 10
		network 192.168.3.0 0.0.0.255
		network 10.3.3.0 0.0.0.3
		network 10.2.2.0 0.0.0.3

* Controleren of je van PC naar PC kan pingen.
* Voer `show ip eigrp neighbors` uit op R1 en controleer of het resultaat klopt.

![](https://github.com/HoGentTIN/ops3-g01/blob/master/deelopdracht03/7.2.2.5/showeigrp.PNG)

* Voer `show ip route eigrp` uit op R1 en controleer het resultaat.

![](https://github.com/HoGentTIN/ops3-g01/blob/master/deelopdracht03/7.2.2.5/showroute.PNG)

* Voer `show ip eigrp topology` uit op R1 en controleer het resultaat.

![](https://github.com/HoGentTIN/ops3-g01/blob/master/deelopdracht03/7.2.2.5/showtopo.PNG)

* Controleer bandwith van de interfaces.`show interface s0/0/0` en kijk naar `BW=`.
* Pas de bandwith aan.

**R1**

		conf t
		int s0/0/0
		bandwith 2000
		
		int s0/0/1
		bandwith 64

**R2**

		conf t
		int s0/0/0
		bandwith 2000
		
		int s0/0/1
		bandwith 2000

**R3**

		conf t
		int s0/0/0
		bandwith 64
		
		int s0/0/1
		bandwith 2000

* Controleer de ip routes nogmaals.
* Stel de passieve interfaces in

**R1**

		router eigrp 10
		passive-interface g0/0

**R2**

		router eigrp 10
		passive-interface g0/0

**R3**

		router eigrp 10
		passive-interface g0/0

* Controleer via `show ip protocols`

##Testplan en -rapport: LAMP stack

* Verantwoordelijke uitvoering: Lucas en Jordi
* Verantwoordelijke testen: Lara en Daan

###Testplan

Auteur(s) testplan: Lucas, Jordi

Doelstelling:  
	1. Performante webserver opzetten met high availability  
	2. Monitoren van netwerkservices, opvangen metrieken. 
	3. Stress-testen van netwerkservices  
	4. Reproduceerbare experimenten opzetten, resultaten correct analyseren en rapporteren


###Opstelling 1: Eenvoudige LAMP stack

1. Opzetten LAMP stack
	- [ ] Packages installeren (httpd, php, 'databank')
	- [ ] Services starten
	- [ ] Firewall configureren
	- [ ] Databank met php-webapplicatie verbinden 
	- [ ] Databank opvullen met data
2. Server voor monitoring opzetten
	- [ ] aantal queries per seconde
	- [ ] aantal fouten vs geslaagde queries
	- [ ] bandbreedte
	- [ ] responstijd
	- [ ] (evt.) cpu load, netwerk/disk-IO, geheugen- en schijfgebruik,...
3. Load testing met framework
	- [ ] weinig load
	- [ ] veel load
	- [ ] sommige gebruikers geven commentaar op artikels
	- [ ] "Hacker News"-effect (plots enorm veel requests voor de pagina)
	- [ ] ...
4. Visualiseer het gedrag van de server
5. Bestudeer de metrieken
6. Zorg ervoor dat de opstelling reproduceerbaar is

###Opstelling 2: Multi-tier webserver

Doel: Webserver performanter maken. Herhaal bij elke stap de experimenten uit de eerste opstelling en bekijk het verschil. Probeer de belangrijkste bottleneck te bepalen en weg te werken.

1. Webserversoftware vervangen door "perfomantere"
2. Database op aparate machine zetten
3. Parallele webserver + load balancer
4. DNS als load-balancer
5. Cache-systeem


### Testrapport

Uitvoerder(s) test: NAAM

- ...
##Testplan en -rapport: LAMP stack

* Verantwoordelijke uitvoering: NAAM
* Verantwoordelijke testen: NAAM

###Testplan

Auteur(s) testplan: Lucas

Doelstelling:  
	1. Performante webserver opzetten met high availability  
	2. Monitoren van netwerkservices, opvangen metrieken. 
	3. Stress-testen van netwerkservices  
	4. Reproduceerbare experimenten opzetten, resultaten correct analyseren en rapporteren


###Opsetlling 1: Eenvoudige LAMP stack

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

### Testrapport

Uitvoerder(s) test: NAAM

- ...
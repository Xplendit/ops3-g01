#Documentatie Lampstack

##Procedure
Om een Lampstack op te zetten, gebruiken we de volgende rol: [https://github.com/bertvv/ansible-role-wordpress](https://github.com/bertvv/ansible-role-wordpress)

Vervolgens hebben we de playbook opgesteld zoals u hieronder kunt zien.

	# host_vars/lampstack.yml
	---
	
	el7_repositories:
	  - epel-release
	
	el7_install_packages:
	  - bash-completion
	  - tree
	  - vim-enhanced
	
	el7_firewall_allow_services:
	  - http
	  - https
	
	httpd_scripting: 'php'
	
	mariadb_databases:
	  - wordpress
	
	mariadb_users:
	  - name: user
	    password: WopWop
	    priv: 'wordpress.*:ALL'
	
	mariadb_root_password: WopWop
	
	wordpress_database: wordpress
	wordpress_user: user
	wordpress_password: WopWop
	wordpress_plugins: 
	  - name: demo-data-creator

Hier zorgen we ervoor dat er een database wordt aangemaakt met de naam *wordpress*. Daarna maken we een user aan voor de database.

Dan moet je ervoor zorgen dat WordPress de juiste database gebruikt. Eerst installeren we een plugin om de wordpress pagina makkelijk te kunnen vullen met lorem ipsum.

Ga naar volgende site [http://192.168.56.77/wordpress/wp-admin/install.php](http://192.168.56.77/wordpress/wp-admin/install.php) maak hier een admin account aan voor je WordPress.

![](https://github.com/HoGentTIN/ops3-g01/blob/master/deelopdracht01/img/wordpress.PNG)

Log hierna in met de gebruikte inloggegevens.

Activeer vervolgens de plugin:

![](https://github.com/HoGentTIN/ops3-g01/blob/master/deelopdracht01/img/plugin.PNG)

Nu gaan we met deze plugin, een aantal artikels generen, speel wat met de instellingen tot je het gewenste resultaat bekomt.

Nu gaan we inloggen op onze sql database

![](https://github.com/HoGentTIN/ops3-g01/blob/master/deelopdracht01/img/phpmyadmin.PNG)

Klik vervolgens links op wordpress(naargelang hoe je je database hebt genoemd). Deze gaan we exporteren.

![](https://github.com/HoGentTIN/ops3-g01/blob/master/deelopdracht01/img/database.PNG)

Zorg ervoor dat je venster hetzelfde eruitziet zoals op volgende screenshot.

![](https://github.com/HoGentTIN/ops3-g01/blob/master/deelopdracht01/img/exporteren.PNG)

Kopieer de output en maak een nieuwe init.sql file aan in volgende locatie: lampstack\ansible\roles\bertvv.mariadb\files.

Als laatste gaan we het volgende toevoegen aan onze lampstack.yml

	mariadb_init_scripts:
  		- database: wordpress
   		 script: init.sql

Hiermee wordt je wordpress site direct aangemaakt met alle gegenereerde posts en je user account aangemaakt. Zet dit in commentaar als je nog provision wilt doen.
	


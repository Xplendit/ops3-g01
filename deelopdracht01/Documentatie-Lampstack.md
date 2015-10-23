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



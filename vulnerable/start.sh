#!/usr/bin/env bash

sleep 5

if ps aux | grep -q mysqld
then
	mysql --user="root" --skip-password --execute="DROP DATABASE IF EXISTS payroll; CREATE DATABASE payroll;" \
		&& mysql --user="root" --skip-password payroll < /tmp/payroll.sql

	mysql --user="root" --skip-password --execute="DROP DATABASE IF EXISTS drupal; CREATE DATABASE drupal;" \
		&& mysql --user="root" --skip-password --execute="GRANT SELECT, INSERT, DELETE, CREATE, DROP, INDEX, ALTER ON drupal.* TO 'root'@'localhost';" \
		&& mysql --user="root" --skip-password --execute="GRANT SELECT, INSERT, DELETE, CREATE, DROP, INDEX, ALTER ON drupal.* TO 'root'@'localhost';" \
		&& mysql --user="root" --skip-password drupal < /tmp/drupal.sql

	mysql --user="root" --skip-password --execute="CREATE DATABASE super_secret_db;"
    	mysql --user="root" --skip-password --execute="GRANT SELECT, INSERT, DELETE, CREATE, DROP, INDEX, ALTER ON drupal.* TO 'root'@'localhost' IDENTIFIED BY 'sploitme';"
    	mysql --user="root" --skip-password super_secret_db < /tmp/super_secret_db.sql


	mysql -u root --skip-password -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('sploitme');"
	
	rm /tmp/*.sql
	killall -9 mysqld
fi

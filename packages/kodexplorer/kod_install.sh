#!/bin/sh

NAME=KodExplorer
VER=4.47
URL=https://github.com/kalcaddle/KodExplorer/archive/refs/tags
MNT_DIR=`uci get fstab.@mount[0].target`
LAN_IP=`uci get network.lan.ipaddr`
KOD_INSTALL_DIR=$MNT_DIR/$NAME
DATA_DIR=$MNT_DIR/data
NGINX_CONF_NAME=$NAME.conf
PHP8_FPM_CONF_NAME=$NAME.conf

func_generate_nginx_conf()
{
	[ ! -d /etc/nginx/conf.d ] && mkdir -p /etc/nginx/conf.d
	cat > "/etc/nginx/conf.d/$NGINX_CONF_NAME" <<EOF
server {
    listen 8080;
    server_name localhost;
    access_log /var/log/nginx/KodExplorer_access.log;
    error_log /var/log/nginx/KodExplorer_error.log;

    location / {
        root $KOD_INSTALL_DIR;
        index index.php;
    }

    location ~ \.php\$ {
        root $KOD_INSTALL_DIR;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
        fastcgi_pass unix:/var/run/$NAME-php8-fpm.sock;
        include fastcgi_params;
    }
}
EOF
}

func_generate_php8_fpm_conf()
{
	cat > "/etc/php8-fpm.d/$PHP8_FPM_CONF_NAME" <<EOF
[$NAME]
user = nobody
group = nogroup
listen = /var/run/$NAME-php8-fpm.sock
listen.mode = 0666
listen.allowed_clients = 127.0.0.1
pm = dynamic
pm.max_children = 5
pm.start_servers = 2
pm.min_spare_servers = 1
pm.max_spare_servers = 3
pm.max_requests = 500
chdir = /
php_admin_value[upload_max_filesize] = 16M
php_admin_value[memory_limit] = 24M
php_admin_value[doc_root] = $KOD_INSTALL_DIR
php_admin_value[open_basedir] = $KOD_INSTALL_DIR/:$DATA_DIR/:/tmp/:/proc/
EOF
}

func_install_kodexplorer()
{
	echo "Installing, please wait..."

	tar xzf $MNT_DIR/$NAME-$VER.tar.gz -C $MNT_DIR
	rm $MNT_DIR/$NAME-$VER.tar.gz

	mv $MNT_DIR/$NAME-$VER $KOD_INSTALL_DIR
	if [ -d $DATA_DIR ]; then
		rm $KOD_INSTALL_DIR/data -rf
	else
		mv $KOD_INSTALL_DIR/data $DATA_DIR
	fi
	echo -n "<?php define('DATA_PATH','$DATA_DIR/');" > $KOD_INSTALL_DIR/config/define.php

	chown nobody:nogroup -R $KOD_INSTALL_DIR
	chown nobody:nogroup -R $DATA_DIR
	chmod 775 -R $KOD_INSTALL_DIR
	chmod 775 -R $DATA_DIR

	func_generate_nginx_conf
	func_generate_php8_fpm_conf

	/etc/init.d/php8-fpm restart
	/etc/init.d/nginx restart

	echo "Kod Explorer install finished. Please visit http://$LAN_IP:8080"
}

if [ ! -d $MNT_DIR ]; then
	echo "$MNT_DIR does not exit."
	exit 0
fi

if [ -d $KOD_INSTALL_DIR ]; then
	echo "Kod Explorer has been installed in $KOD_INSTALL_DIR, exit installation."
	exit 0
fi

# now download kod explorer
wget --no-check-certificate $URL/$VER.tar.gz -O $MNT_DIR/$NAME-$VER.tar.gz

if [ $? != 0 ]; then
	echo "Download Kod Explorer failed."
	exit 0
fi

if [ ! -e $MNT_DIR/$NAME-$VER.tar.gz ]; then
	echo "Download Kod Explorer failed."
else
	func_install_kodexplorer
fi

exit 0

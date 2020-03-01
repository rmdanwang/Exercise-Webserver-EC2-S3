#!/bin/bash
# assign variables
ACTION=${1}
VERSION=1.0.0

function remove_nginx() {
sudo service nginx stop
sudo rm -rf /usr/share/nginx/html
sudo yum remove nginx -y
}

function show_version() {
echo "$VERSION"
}

function display_help() {
cat << EOF
Usage: ${0} {-r|--remove|-v|--version|-h|--help}
OPTIONS:
	-r | --remove Stop Ngnix service, delete Nginx website document, and uninstall Nginx software package
	-v | --version Display the version of the script
	-h | --help Display the command help
Examples:
	Stop Ngnix service, delte website document, and uninstall Nginx software:
		$ ${0} -r
	Display the version of the script:
		$ ${0} -v
	Display help:
		$ ${0} -h
EOF
}

case "$ACTION" in
        -h|--help)
		display_help
	       ;;
	-r|--remove)
		remove_nginx
	       ;;
	-v|--version)
		show_version
	       ;;

	*)
	sudo yum update -y
	sudo amazon-linux-extras install nginx1.12 -y
	sudo chkconfig nginx on
	sudo aws s3 cp s3://danwang-seis61503-va/index.html /usr/share/nginx/html/index.html
	sudo service nginx start
	echo "Instance webserver has been fully configured"
	exit 0
esac


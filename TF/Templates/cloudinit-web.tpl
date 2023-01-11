#!/usr/bin/env bash
set -x
source /etc/lsb-release

export DEBIAN_FRONTEND=noninteractive

sudo apt-get update 
sudo apt-get install nginx -y

cat << EOF > index.html
<html>
<title> Prema Soft</title>
<h1> BIG PAGE </title>

</html>
EOF

sudo cp index.html /var/www/html/


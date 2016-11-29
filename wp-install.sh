#!/bin/bash

# WordPress install v 0.1
echo
echo "                   |       "
echo "                  / \      "
echo "                 /   \     "
echo "                |  R  |    "
echo "                |  O  |    "
echo "                |  C  |    "
echo "                |  K  |    "
echo "                |  E  |    "
echo "                |  T  |    "
echo "                |     |    "
echo "                |  M  |    "
echo "                |  A  |    "
echo "                |  X  |    "
echo "               /       \   "
echo "              /\   _   /\  "
echo "             /  \ | | /  \ "
echo "             |  |_|_|_|  | "
echo "             |  |     |  | "
echo "             \__/     \__/ "
echo "              \/       \/  "
echo
echo "###########################################"
echo "# WordPress Install Process by Rocket Max #"
echo "###########################################"
echo

wpcli="/usr/local/bin/wp"
if [ ! -f "$wpcli" ]; then
echo "You dont have 'WP-CLI' installed!!! Install it? y/n"
read WPCLIINSTALL

if [ "$WPCLIINSTALL" == "y" ]; then
wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
php wp-cli.phar --info
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp
echo "WP-CLI installed"

else 
echo "Sory but to start 'WordPress Install Process' You need to install 'WP-CLI'"
exit

fi
fi

echo "Start WordPress Install Process? y/n"
read START

if [ "$START" == "y" ]; then

wp core download

echo "Enter Data Base Name:"
read DBNAME

echo "Enter Data Base User Name:"
read DBUSER

echo "Enter Data Base Password:"
read DBPASSWORD

echo "Enter Data Base Prefix:"
read DBPREFIX

wp core config --dbname=$DBNAME --dbuser=$DBUSER --dbpass=$DBPASSWORD --dbprefix=$DBPREFIX

echo "Enter Site URL http://"
read SITEURL

echo "Enter Site Title:"
read SITETITLE

echo "Enter Admin User Name:"
read ADMINUSER

echo "Enter Admin Password:"
read ADMIPASSWORD

echo "Enter Admin Email:"
read ADMINEMAIL

wp core install --url=$SITEURL --title="$SITETITLE" --admin_user=$ADMINUSER --admin_password=$ADMIPASSWORD --admin_email=$ADMINEMAIL

wp plugin delete hello
wp plugin update --all
wp plugin install --activate cyr3lat svg-support tinymce-advanced contact-form-7 duplicate-post loco-translate disable-comments

echo
echo "Want To install Advanced Custom Fields? y/n"
read ACF
if [ "$ACF" == "y" ]; then
wp plugin install --activate advanced-custom-fields
fi

echo
echo "Want To install Simple Custom CSS and JS? y/n"
read SCSJ
if [ "$SCSJ" == "y" ]; then
wp plugin install --activate custom-css-js
fi

echo
echo "Want To install WooCommerce? y/n"
read WOOCOMMERCE
if [ "$WOOCOMMERCE" == "y" ]; then
wp plugin install --activate woocommerce woo-checkout-field-editor-pro woocommerce-customizer
fi

echo
echo "Choise SEO Plugin"
echo
echo "1 - SEO Ultimate"
echo "2 - All In One Seo Pack"
echo "3 - Yoast SEO"
echo "Dont Need SEO Plugin Type n"
read SEOPLUGIN

if [ "$SEOPLUGIN" == "1" ]; then
wp plugin install --activate seo-ultimate
elif [ "$SEOPLUGIN" == "2" ]; then
wp plugin install --activate all-in-one-seo-pack
elif [ "$SEOPLUGIN" == "3" ]; then
wp plugin install --activate wordpress-seo
fi

echo
echo "Want To install Google XML Sitemaps? y/n"
read SITEMAP
if [ "$SITEMAP" == "y" ]; then
wp plugin install --activate google-sitemap-generator
fi

echo
echo "Want To install W3 Total Cache? y/n"
echo "Just install, When You Need To Start Cache You Need To Activate It"
read CACHE
if [ "$CACHE" == "y" ]; then
wp plugin install w3-total-cache
fi

echo
echo "Want To install WP-Optimize? y/n"
read OPTIMIZE
if [ "$OPTIMIZE" == "y" ]; then
wp plugin install wp-optimize
fi

echo
echo "Choise The Theme, Enter The Numder"
echo
echo "1 - The7"
echo "2 - Avada"
read THEME

if [ "$THEME" == "1" ]; then
wp theme install --activate ../../dt-the7_v.4.0.0.zip
elif [ "$THEME" == "2" ]; then
wp theme install --activate ../../Avada.zip
fi

echo
echo "Delete Default Themes? y/n"
read DELTHEMES
if [ "$DELTHEMES" == "y" ]; then
wp theme delete twentyfifteen twentyfourteen twentysixteen
fi

echo
echo "Want To Sequre WordPress By -WPS Hide Login- And -Wordfence Security- ?"
read SQURE
if [ "$SQURE" == "y" ]; then
wp plugin install --activate wps-hide-login wordfence
fi

echo
echo "Want To Create .htaccess File? y/n"
read HTACCESS
if [ "$HTACCESS" == "y" ]; then
cat > .htaccess << EOF
# BEGIN WordPress
<IfModule mod_rewrite.c>
RewriteEngine On
RewriteBase /
RewriteRule ^index\.php$ - [L]
RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d
RewriteRule . /index.php [L]
</IfModule>

<FilesMatch "^.*(error_log|wp-config\.php|php.ini|\.[hH][tT][aApP].*)$">
Order deny,allow
Deny from all
</FilesMatch>
# END WordPress
EOF
fi

wp post delete 1
wp post delete 2

echo
echo "WordPress Installed Successfully!"
echo

if [ "$SQURE" == "y" ]; then
echo "You Whas Installed -WPS Hide Login- And WordPress Login Page Whas Changed to $SITEURLlogin !!!!!!!"
echo
fi
echo "Thanks For Using Rocket Max WP Install"
echo "http://rocket-max.com"
echo

elif [ "$START" == "n" ]; then
echo "By!"

fi

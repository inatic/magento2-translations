#!/bin/bash
cd /var/www/magento
for lang_code in nl_BE fr_FR de_DE
do
	if [ ! -f source_$lang_code.csv ]; then
		wget https://raw.githubusercontent.com/inatic/magento2-translations/master/source_$lang_code.csv
	fi
	php bin/magento i18n:pack -m replace -d source_$lang_code.csv $lang_code
	php bin/magento setup:static-content:deploy $lang_code
done
php bin/magento indexer:reindex
php bin/magento cache:clean
php bin/magento cache:flush

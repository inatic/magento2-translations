#!/bin/bash
for lang_code in nl_BE fr_FR de_DE
do
	if [ ! -f source_$lang_code.csv ]; then
		wget http://107.170.242.99/var/Head/source_$lang_code.csv
	fi
	php bin/magento i18n:pack -m replace -d source_$lang_code.csv $lang_code
	php bin/magento setup:static-content:deploy $lang_code
done
php bin/magento indexer:reindex
php bin/magento cache:clean
php bin/magento cache:flush

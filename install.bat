echo "installation start"
set /p projectName="Enter projectName: "
mkdir %projectName%.local

cd %projectName%.local
mkdir dist
mkdir src
echo RewriteEngine On > .htaccess
echo RewriteBase / >> .htaccess
echo RewriteCond %{THE_REQUEST} /dist/([^\s?]*) [NC] >> .htaccess
echo RewriteRule ^ %1 [L,NE,R=302] >> .htaccess
echo RewriteRule ^((?!dist/).*)$ dist/$1 [L,NC] >> .htaccess

call npm init -y
call npm install laravel-mix --save-dev
call npm install normalize.css
call npm install jquery
call npm install swiper

#npm v8
call npm pkg set scripts.dev="npm run development"
call npm pkg set scripts.watch="mix watch"
call npm pkg set scripts.prod="npm run production"
call npm pkg set scripts.production="mix --production"

echo const mix = require('laravel-mix'); > webpack.mix.js
echo mix.options({ processCssUrls: false }) >> webpack.mix.js
echo mix.js('src/js/app.js', 'dist/js') >> webpack.mix.js
echo     .sass('src/scss/app.scss', 'dist/css'); >> webpack.mix.js

cd src
mkdir js
cd js
copy NUL app.js
cd ../
mkdir scss
cd scss
copy NUL app.scss
cd ../../dist
mkdir img
mkdir fonts
copy NUL index.php

pause

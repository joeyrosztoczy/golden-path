cd $assets_dir
node_modules/.bin/webpack -p

cd $phoenix_dir
mix "${phoenix_ex}.digest"

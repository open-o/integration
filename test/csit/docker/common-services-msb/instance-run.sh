./startup.sh
tail -F ./openresty/nginx/logs/error.log &
tail -F ./eag/nginx/logs/error.log &
tail -F ./apiroute-works/logs/application.log

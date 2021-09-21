sleep 60
DATA=$(curl -H --data-ascii "Content-Type: application/x-www-form-urlencoded; charset=utf-8" -s https://rds.eurozet.pl/reader/var/antyradio.json?callback=rdsData);
TITLE=$(echo ${DATA} | awk -F '[,:]'  '/artist/{print $5}' | tr -d '\"')
ARTIST=$(echo ${DATA} | awk -F '[,:]'  '/artist/{print $7}' | tr -d '\"')
echo -e ${ARTIST} ⚡${TITLE}

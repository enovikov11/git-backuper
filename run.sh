while true
do
  echo "start"
  timeout 20m /bin/sh /root/backup.sh
  echo "end"
  sleep 12h
done
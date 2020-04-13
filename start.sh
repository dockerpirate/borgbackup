mkdir /etc/periodic/15min && \
mkdir /etc/periodic/daily && \
mkdir /etc/periodic/hourly && \
mkdir /etc/periodic/monthly && \
mkdir /etc/periodic/weekly && \
mv /borg_auto /etc/periodic/hourly/ && \ 
chmod +x /etc/periodic/hourly/borg_auto && \
crond -b -c /etc/crontabs/ -L /tmp/cron-log && \
/usr/bin/supervisord

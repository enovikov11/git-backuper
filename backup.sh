git config --global user.name $GIT_NAME
git config --global user.email $GIT_EMAIL

chown -R root:root /root

cd /root
# Отключаем автосохранение чанков на диск, чтобы не испортить бекап
/root/rcon-cli --host ${RCON_HOST} --port ${RCON_PORT} --password ${RCON_PASSWORD} save-off
# Форсированно сохраняем на диск загруженные чанки, чтобы в бекап попали актуальные версии
/root/rcon-cli --host ${RCON_HOST} --port ${RCON_PORT} --password ${RCON_PASSWORD} save-all flush

TAG=$(date +"save_%d_%m_%Y__%H")

for dirname in $(ls /root/master); do
    cd /root/master/$dirname
    git add .
    git commit -m $TAG
    git tag -a $TAG -m $TAG
done

# Включаем автосохранение чанков на диск, чтобы не терять данные при внезапном отключении
/root/rcon-cli --host ${RCON_HOST} --port ${RCON_PORT} --password ${RCON_PASSWORD} save-on

for dirname in $(ls /root/master); do
    cd /root/master/$dirname
    # Пихаем в orgin новые комиты, стирая то, что там лежит
    git push -f -u origin master
done

for dirname in $(ls /root/slave); do
    cd /root/slave/$dirname
    # Скачиваем нам новые комиты, стирая то, что лежит у на
    git fetch origin
    git reset --hard origin/master
done
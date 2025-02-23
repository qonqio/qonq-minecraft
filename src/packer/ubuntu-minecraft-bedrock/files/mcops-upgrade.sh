randomint=$(tr -dc 0-9 < /dev/urandom 2>/dev/null | head -c 4 | xargs)
DOWNLOAD_URL=$(curl -H "Accept-Encoding: identity" -H "Accept-Language: en" -s -L -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko>
echo $DOWNLOAD_URL

WORKING_DIR=$(pwd)
DOWNLOAD_PATH="/home/qonqadmin/mcb"
INSTALL_PATH="/home/mcserver/minecraft_bedrock"
BACKUP_SOURCE="/home/mcserver/minecraft_bedrock"
BACKUP_TARGET="/home/qonqadmin/backup"

curl -o $DOWNLOAD_PATH/bedrock-server.zip -H "Accept-Encoding: identity" -H "Accept-Language: en" -s -L -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537>

echo "Minecraft Downloaded"

BACKUP_FILENAME=worlds-$(date +"%Y-%m-%d").zip
BACKUP_FULL_PATH=$BACKUP_TARGET/$BACKUP_FILENAME

cd $BACKUP_SOURCE/worlds && zip -r $BACKUP_FULL_PATH ./*
cd $WORKING_DIR

cp $BACKUP_SOURCE/allowlist.json $BACKUP_TARGET/
cp $BACKUP_SOURCE/permissions.json $BACKUP_TARGET/
cp $BACKUP_SOURCE/server.properties $BACKUP_TARGET/

echo "Minecraft Config Backup Complete"

systemctl stop mcbedrock

echo "Minecraft Service Stopped"

unzip -o $DOWNLOAD_PATH/bedrock-server.zip -d $INSTALL_PATH

rm $DOWNLOAD_PATH/bedrock-server.zip

chown -R mcserver: $INSTALL_PATH

echo "New Version of Minecraft Installed"

mkdir -p $INSTALL_PATH/worlds

unzip -o $BACKUP_FULL_PATH -d $INSTALL_PATH/worlds
cp $BACKUP_TARGET/allowlist.json $INSTALL_PATH/
cp $BACKUP_TARGET/permissions.json $INSTALL_PATH/
cp $BACKUP_TARGET/server.properties $INSTALL_PATH/

chown -R mcserver: $INSTALL_PATH

echo "Old Worlds Restored"

systemctl start mcbedrock

echo "Minecraft Server Started"

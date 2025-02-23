WORKING_DIR=$(pwd)
INSTALL_PATH=/home/mcserver/minecraft_bedrock
BACKUP_FILE=$1

systemctl stop mcbedrock

echo "Minecraft Service Stopped"

mkdir -p $INSTALL_PATH/worlds

rm -rf $INSTALL_PATH/worlds/*

unzip -o $BACKUP_FILE -d $INSTALL_PATH/worlds

chown -R mcserver: $INSTALL_PATH

echo "Old Worlds Restored"

systemctl start mcbedrock

echo "Minecraft Server Started"
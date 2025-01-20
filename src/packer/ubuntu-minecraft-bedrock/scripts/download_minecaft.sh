# This works
DOWNLOAD_URL=$(curl -H "Accept-Encoding: identity" -H "Accept-Language: en" -s -L -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.$${randomint}.212 Safari/537.36" https://www.minecraft.net/en-us/download/server/bedrock/ |  grep -o 'https://www.minecraft.net/bedrockdedicatedserver/bin-linux/[^\"]*')

# produces this URL
https://www.minecraft.net/bedrockdedicatedserver/bin-linux/bedrock-server-1.21.51.02.zip

wget $DOWNLOAD_URL -O ./bedrock-server.zip

curl -L -o bedrock-server.zip -H "Accept-Encoding: identity" -H "Accept-Language: en" -s -L -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.$${randomint}.212 Safari/537.36" "https://www.minecraft.net/bedrockdedicatedserver/bin-linux/bedrock-server-1.21.51.02.zip"

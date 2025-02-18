#!/bin/ash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
GRAY='\033[0;37m'
RESET='\033[0m'

BG_RED='\033[41m'
BG_GREEN='\033[42m'
BG_YELLOW='\033[43m'
BG_BLUE='\033[44m'
BG_CYAN='\033[46m'
BG_PURPLE='\033[45m'
BG_GRAY='\033[47m'

CHECK_MARK="✅"
CROSS_MARK="❌"
WARNING="⚠️"
INFO="ℹ️"

TAG_INFO="${BG_BLUE}[INFO]${RESET}"
TAG_ERROR="${BG_RED}[ERROR]${RESET}"
TAG_WARN="${BG_YELLOW}[WARN]${RESET}"
TAG_SUCCESS="${BG_GREEN}[SUCCESS]${RESET}"
TAG_DEBUG="${BG_PURPLE}[DEBUG]${RESET}"

VERSION="${VERSION:-LATEST}"

cd /root

if [ "$EULA" != "TRUE" ]; then
    echo -e "${TAG_ERROR} ${CROSS_MARK} You must accept the Minecraft EULA to run the server."
    echo -e "${TAG_INFO} Set the environment variable EULA to TRUE to accept it."
    exit 1
fi

if [ ! -d "/root/.wine" ]; then
    echo -e "${TAG_INFO} Configuring Wine..."
    winecfg
    xvfb-run -a winetricks vcrun2022 -q
fi

export WINEDEBUG="${WINEDEBUG:--all}"

if [ ! -f "bedrock_server_mod.exe" ]; then
    if [ "$GITHUB_MIRROR_URL" != "" ]; then
        echo -e "${TAG_INFO} Setting GitHub Mirror URL..."
        lip config GitHubMirrorURL $GITHUB_MIRROR_URL
    fi

    if [ "$GO_MODULE_PROXY_URL" != "" ]; then
        echo -e "${TAG_INFO} Setting Go Module Proxy URL..."
        lip config GoModuleProxyURL $GO_MODULE_PROXY_URL
    fi

    if [ "$VERSION" = "LATEST" ]; then
        echo -e "${TAG_INFO} Installing LeviLamina (latest version)..."
        lip install -y github.com/LiteLDev/LeviLamina
    else
        echo -e "${TAG_INFO} Installing LeviLamina (version $VERSION)..."
        lip install -y github.com/LiteLDev/LeviLamina@$VERSION
    fi

    for package in $PACKAGES; do
        echo -e "${TAG_INFO} Installing package: $package..."
        lip install -y $package
    done
fi

if [ -d "/root/plugins/LeviLamina/config" ]; then
    echo -e "${TAG_INFO} Disabling crash logger in LeviLamina config..."
    sed -i -e '/"crashLogger": {/,/}/s/"enabled": true/"enabled": false/' /root/plugins/LeviLamina/config/Config.json
fi

if [ ! -f "/root/server.properties" ]; then
    echo -e "${TAG_INFO} Extracting server files..."
    unzip -o -d /root /root/.cache/bdsdown/*.zip
fi

echo -e "${TAG_SUCCESS} ${CHECK_MARK} Starting Minecraft Bedrock Server..."
cat | fold -w 100 | WINEDEBUG=-all wine64 bedrock_server_mod.exe

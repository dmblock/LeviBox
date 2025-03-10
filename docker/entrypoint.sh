#! /bin/ash

VERSION="${VERSION:-LATEST}"

cd /root

if [ "$EULA" != "TRUE" ]
then
    echo "You must accept the Minecraft EULA to run the server"
    echo "Set the environment variable EULA to TRUE to accept it"
    exit 1
fi

if [ ! -d "/root/.wine" ]
then
    winecfg
    xvfb-run -a winetricks vcrun2022 -q
fi

export WINEDEBUG="${WINEDEBUG:--all}"

if [ ! -f "bedrock_server_mod.exe" ]
then
    if [ "$GITHUB_MIRROR_URL" != "" ]
    then
        lip config GitHubMirrorURL $GITHUB_MIRROR_URL
    fi

    if [ "$GO_MODULE_PROXY_URL" != "" ]
    then
        lip config GoModuleProxyURL $GO_MODULE_PROXY_URL
    fi

    if [ "$VERSION" = "LATEST" ]
    then
        lip install -y github.com/LiteLDev/LeviLamina
    else
        lip install -y github.com/LiteLDev/LeviLamina@$VERSION
    fi

    for package in $PACKAGES
    do
        lip install -y $package
    done
fi

sed -i -e 's/"enabled": true/"enabled": false/' -e 's/"enableStatitics": true/"enableStatitics": false/' /root/plugins/LeviLamina/config/Config.json
cat | WINEDEBUG=-all wine64 bedrock_server_mod.exe

#!/usr/bin/env fish
#
# # Ghoster - Ghost upgrade script
#

# ## Config
set -l GHOST_INSTALL_PATH "/var/www/ghost/"

if test (count $argv) -lt 1
    echo ""
    echo "Ghoster command required. See the following command for help"
    echo "./ghoster help"
    echo ""
else
  switch $argv[1]
    case "help"
        echo ""
        echo "Commands:"
        echo ""
        echo "install <version>  # Install a Ghost version"
        echo ""
        echo "Example of Ghost install command:"
        echo ""
        echo "./ghoster.sh install <version>"
        echo ""
    exit 0

    case "install"
        echo ""
        if test $argv[2] = "latest"
            echo "Step 1: getting the latest Ghost version"
            and curl -LOk https://ghost.org/zip/ghost-latest.zip
            and mv ghost-latest.zip /tmp/ghost-temp.zip
        else
            echo "Step 1: getting Ghost version $argv[2]"
            and curl -LOk https://github.com/TryGhost/Ghost/archive/$argv[2].zip
            and mv $argv[2].zip /tmp/ghost-temp.zip
        end
        and echo ""

        and echo "Step 2: unziping to a temporary location"
        and unzip /tmp/ghost-temp.zip -d /tmp/ghost-temp
        and rm /tmp/ghost-temp.zip
        and echo ""

        and echo "Step 3: changing directory into your current ghost install"
        and cd $GHOST_INSTALL_PATH
        and echo ""

        and echo "Step 4: removing the core directory completely"
        and rm -rf core
        and echo ""

        and echo "Step 5: changing back to your download of Ghost latest"
        and cd /tmp/ghost-temp
        and echo ""

        and echo "Step 6: copying the new core directory to your Ghost install"
        and cp -R core $GHOST_INSTALL_PATH
        and echo ""

        and echo "Step 7: copying the other key files to your Ghost install directory"
        and cp index.js $GHOST_INSTALL_PATH
        and cp *.json $GHOST_INSTALL_PATH
        and echo ""

        and echo "Step 8: changing back to your ghost install directory"
        and cd $GHOST_INSTALL_PATH
        and echo ""

        and echo "Step 9: updating permissions"
        and chown -R ghost:ghost *
        and echo ""

        and echo "Step 10: upgrading dependencies"
        and npm install --production
        and echo ""

        and echo "Step 11: restarting Ghost!"
        and service ghost restart
        and rm -rf /tmp/ghost-temp
        and echo ""

        and echo "Step 12: Ghost upgrade finished!"
        and echo ""

        or begin
            set -l err $status
            echo "Ghost upgrade encountered an error. Exit status: $err."
            exit $err
        end
    exit 0
  end
end
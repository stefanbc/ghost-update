#!/usr/bin/env fish
#
# # Ghoster - Ghost update script
#

# ## Config
set -l GHOST_INSTALL_PATH "/var/www/ghost/"

if test (count $argv) -lt 1
  echo "
        Ghoster command required. See the following command for help
            ./ghoster help
        "
else
  switch $argv[1]
    case "help"
      echo "
Commands:

update   # Update Ghost instance

Example of Ghost update comand:

./ghoster update
"
      exit 0

    case "update"
        echo "Step 1: getting the latest Ghost version"
        and curl -LOk https://ghost.org/zip/ghost-latest.zip
        and mv ghost-latest.zip /tmp/ghost-latest.zip

        and echo "Step 2: unziping to a temporary location"
        and unzip /tmp/ghost-latest.zip -d /tmp/ghost-temp

        and echo "Step 3: changing directory into your current ghost install"
        and cd $GHOST_INSTALL_PATH
        
        and echo "Step 4: removing the core directory completely"
        and rm -rf core
        
        and echo "Step 5: changing back to your download of Ghost latest"
        and cd /tmp/ghost-temp
        
        and echo "Step 6: copying the new core directory to your Ghost install"
        and cp -R core $GHOST_INSTALL_PATH
        
        and echo "Step 7: copying the other key files to your Ghost install directory"
        and cp index.js $GHOST_INSTALL_PATH 
        and cp *.json $GHOST_INSTALL_PATH
        
        and echo "Step 8: changing back to your ghost install directory"
        and cd $GHOST_INSTALL_PATH
        
        and echo "Step 9: updating permissions"
        and chown -R ghost:ghost *
        
        and echo "Step 10: upgrading dependencies"
        and npm install --production
        
        and echo "Step 11: restarting Ghost!"
        and service restart ghost
        and rm /tmp/ghost-latest.zip
        and rm -rf /tmp/ghost-temp

        and echo "Step 12: Ghost update finished!"

        or begin
            set -l err $status
            echo "Ghost update encountered an error. Exit status: $err."
            exit $err
        end
  end
end
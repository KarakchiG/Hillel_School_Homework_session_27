export TERM=xterm-256color
ENV ONEDRIVE_DIR="OneDrive"

# cyan font
echo -e "\e[1;36m"

cat<<OneDrive_BANNER

Welcome to OneDrive Container

-------------------------------------------------------------------------------

To continue Onedrive personal setup for artifacts uploading use next commands:

    1. onedrive --syncdir .
    2. add required files and dirs into .
    3. onedrive --synchronize --upload-only

-------------------------------------------------------------------------------

To list available commands, please type:

OneDrive:                                               onedrive -h

    --source-directory <dir_name>           Source directory to rename or move on OneDrive - no sync will be performed.
    --create-directory                      Create a directory on OneDrive (remote) - no sync will be performed
    --syncdir <dir>                         Specify the local directory used for synchronization to OneDrive
    --synchronize:                          Perform a synchronization
        --single-directory '<dir_name>'     Perform a synchronization of a single directory
        --upload-only                       Replicate the locally configured sync_dir state to OneDrive,
                                            by only uploading local changes to OneDrive. Do not download changes from OneDrive.

-------------------------------------------------------------------------------

OneDrive_BANNER

# white font
echo -e "\e[0;37m"

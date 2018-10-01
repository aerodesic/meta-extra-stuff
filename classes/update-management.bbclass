
# Postprocess the image and collect all debs in tmp/deploy/debs/*/*.deb.
# Two support directories exist (or are created) to facilitate generation of updates.
# If 'updated-cache' exists, debs that are different to those in this directory
# are copied to updated-debs.  If updated-cache does not exist, it is created
# and filled with a copy of the files in the deployed debs dir.
# 
do_update_management() {
    if [ ! -d updated-cache ]; then
        # Create cache and copy deployed debs to it.
        mkdir updated-cache
        for file in tmp/deploy/deb/*/*.deb; do
            cp $file updated-cache/`basename $file`
        done
        rm -f updated-debs
    else
        if [ ! -e updated-debs ]; then
            mkdir updated-debs
        fi
          
        for file in tmp/deploy/deb/*/*.deb; do
           if ! cmp $file updated-cache/`basename $file`; then
               cp $file updated-debs/`basename $file`
           fi
        done
    fi
}

IMAGE_POSTPROCESS_COMMAND = "do_update_management"

echo "Zeroing out free space to reduce the size of the final image..."
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY
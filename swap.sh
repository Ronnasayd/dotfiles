sudo swapoff /swapfile
sudo dd if=/dev/zero of=/name.swap.tmp bs=1024 count=8388608
sudo mv /swapfile /swapfile.old
sudo mv /name.swap.tmp /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
swapon --show
sudo rm swapfile.old
sudo echo "/swapfile   none   swap  sw  0  0" >> /etc/fstab

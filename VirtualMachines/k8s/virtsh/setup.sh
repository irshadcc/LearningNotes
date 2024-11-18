CONTAINERD_URL="https://github.com/containerd/containerd/releases/download/v1.7.11/containerd-1.7.11-linux-amd64.tar.gz" 
CONTAINERD_SYSD_SERVICE_FILE="https://raw.githubusercontent.com/containerd/containerd/main/containerd.service" 
RUNC_URL="https://github.com/opencontainers/runc/releases/download/v1.1.11/runc.amd64"

CNI_URL="https://github.com/containernetworking/plugins/releases/download/v1.4.0/cni-plugins-linux-amd64-v1.4.0.tgz" 


function download() {
    local url=$1
    local output_file=$2

    if [[ ! -f $output_file ]]; then
	echo "Downloading $output_file" 
	wget $url -O $output_file
    fi
}


function install_utils() {

	#Basic utilities 
	sudo apt update -y
	sudo apt install -y net-tools passwd
}

#Basic setup
sudo echo 'PATH=$PATH:/usr/local/sbin' > /etc/profile.d/default_path.sh

#SSH

#Containerd
## Download
mkdir -p containerd && cd containerd
download $CONTAINERD_URL containerd.tar.gz
## Copy config.toml
sudo mkdir -p /etc/containerd
containerd config default > config.toml
sed 's/SystemdCgroup = false/SystemdCgroup = true' config.toml
sudo cp config.toml /etc/containerd

## Start the service
download $CONTAINERD_SYSD_SERVICE_FILE containerd.service
mkdir -p /usr/local/lib/systemd/system
sudo cp containerd.service /usr/local/lib/systemd/system/containerd.service
sudo tar Cxzvf /usr/local containerd.tar.gz
sudo systemctl daemon-reload
sudo systemctl enable --now containerd

#Runc 
download $RUNC_URL runc.
sudo install -m 755 runc.amd64 /usr/local/sbin/runc

#CNI
download $CNI_URL cni.tgz
sudo mkdir -p /opt/cni/bin
tar Cxzvf /opt/cni/bin cni.tgz


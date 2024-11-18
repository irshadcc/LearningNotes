export NAME="api-server-vm"

ISO_IMAGE_URL="https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-12.4.0-amd64-netinst.iso"
ISO_IMG_PATH="debian-12.4.0-amd64-netinst.iso"
DISK_PATH_IMG="${NAME}.qcow2"
DISK_SIZE=10

CPU_CORES=1
MEMORY=8192
NET="default"
MACHINE_ARCH="x86_64"
OS_VARIANT="debian10"

# Create VM
function create_vm() {
    if [[ -f ISO_IMG_PATH ]]; then
        wget $ISO_IMAGE_URL -o $ISO_IMG_PATH
    fi

    virt-install \
        --name ${NAME} \
        --memory ${MEMORY} \
        --vcpus ${CPU_CORES} \
        --disk path=${DISK_PATH_IMG},size=${DISK_SIZE},bus=virtio,format=qcow2 \
        --graphics none \
        --os-variant ${OS_VARIANT} \
        --extra-args="console=ttyS0" \
        --location ${ISO_IMG_PATH}
}

function run_api_server() {
    virt-install \
        --import \
        --name ${NAME} \
        --memory ${MEMORY} \
        --vcpus ${CPU_CORES} \
        --disk path=${DISK_PATH_IMG},size=${DISK_SIZE},bus=virtio,format=qcow2 \
        --graphics none \
        --os-variant ${OS_VARIANT} ;
}

# virsh list --all
# virsh shutdown ${NAME} 
# virsh console ${NAME} // username = api-server, password = password
# virsh undefine ${NAME} 



    

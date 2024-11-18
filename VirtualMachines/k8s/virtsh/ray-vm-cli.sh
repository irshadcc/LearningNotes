export NAME="ray-vm"

# Base image and 
ISO_IMAGE_URL="https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-12.4.0-amd64-netinst.iso"
ISO_IMG_PATH="debian-12.4.0-amd64-netinst.iso"
DISK_PATH_IMG="${NAME}.qcow2"
DISK_SIZE=10

# VM configuration
CPU_CORES=1
MEMORY=8192
NET="default"
MACHINE_ARCH="x86_64"
OS_VARIANT="debian10"

# Ray config
RAY_HEAD_NAME="${NAME}-head" 
RAY_NODE1_NAME="${NAME}-node1" 
RAY_NODE2_NAME="${NAME}-node2" 


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

function run_ray_vms() {

    virt-install \
        --import \
        --name ${NAME} \
        --memory ${MEMORY} \
        --vcpus ${CPU_CORES} \
        --disk path=${DISK_PATH_IMG},size=${DISK_SIZE},bus=virtio,format=qcow2 \
        --graphics none \
        --os-variant ${OS_VARIANT} ;

    virt-clone --original $NAME --name $RAY_HEAD_NAME  --file $RAY_HEAD_NAME.qcow2
    virt-clone --original $NAME --name $RAY_NODE1_NAME --file $RAY_NODE1_NAME.qcow2
    virt-clone --original $NAME --name $RAY_NODE2_NAME --file $RAY_NODE2_NAME.qcow2

    virsh start $RAY_HEAD_NAME
    virsh start $RAY_NODE1_NAME
    virsh start $RAY_NODE2_NAME
}


# virsh list --all
# virsh shutdown ${NAME} 
# virsh console ${NAME} 
# virsh undefine ${NAME} 
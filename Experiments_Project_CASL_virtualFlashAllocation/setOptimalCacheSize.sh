LIST_VM=`virsh list | grep running | awk '{print $2}'`
echo $LIST_VM
for lvm in $LIST_VM
do
echo $lvm
done

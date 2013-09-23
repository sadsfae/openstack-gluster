class gluster::variables {

    # common variables referenced here
    $mystorageip = "ipaddress_${gluster::variables::storageinterface}"
    $cinder_exists = "gluster volume info cinder_vol | grep Type | wc -l"
    $glance_exists = "gluster volume info glance_vol | grep Type | wc -l"
    $gluster_replica_peers = $gluster::variables::peers
}

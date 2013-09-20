class gluster::variables {

    # collect server peer IP addreses from parameters

    if $::gluster_server_peers {
        notice "gluster peers: ${::gluster_server_peers}"
        gluster-server::peers { $::gluster_server_peers:
    }

}

    # determine the interface used for storage

    if $::storage_interface {
        notice "storage interface check: ${::storage_interface}"
        gluster-server::storageinterface { $::storage_interface:
    }

}

    # set the replica count for new brick creation

    if $::replica_count {
        notice "brick replicas: ${::replica_count}"
        gluster-server::replica_count { $::replica_count:
    }

}

    # common variables referenced here

    $mystorageip = ipaddress_{$gluster::variables::storageinterface}
    $cinder_exists = "gluster volume info cinder_vol | grep Type | wc -l"
    $glance_exists = "gluster volume info glance_vol | grep Type | wc -l"
    $gluster_replica_peers = $gluster::variables::peers
}

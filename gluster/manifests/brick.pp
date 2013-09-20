# bare minimum needed for a new glusterfs brick
class gluster::brick {

    include gluster::variables

    # install necessary packages
    Package {
        ensure => installed
    }

    package { 'gluster-server' : }
    package { 'glusterfs' : }
    package { 'glusterfs-geo-replication' : }
    package { 'rpcbind' : }
    package { 'nfs-utils' : }

    # take care of the base gluster mount

    file { "/srv/gluster":
        ensure => "directory",
        owner  => "root",
        group  => "root",
        mode   => "0755",
    }

    # probe brick peers

    exec { "gluster_peer_probe":
        command => "gluster peer probe ${peers}",
    }

    # ensure glusterd server is running
    service { "glusterd":
        ensure => "running",
    }
}

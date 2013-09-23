# setup cinder and join existing cluster
class gluster::server::cinder {

    # ensure cinder dir exists
    file { "/srv/gluster/cinder":
        ensure => "directory",
        owner  => "cinder",
        group  => "cinder",
        mode   => "0750"
    }

    # exec glusterfs command to create cinder vol if it doesn't exist, join cluster
    if $cinder_exists == "0" {

    $replicacount = $::replicacount ? {
        ''      => 2,
         default => $::replicacount
    }

    $mystorageip = $::mystorageip ? {
        ''      => false,
        default => $::mystorageip
    }

    $gluster_server_peers = $::gluster_server_peers ? {
        ''      => false,
        default => $::gluster_server_peers
    }

    exec { "gluster create volume cinder":
      command => "gluster volume create cinder_vol replica ${replicacount} ${mystorageip}:/srv/gluster/glance ${gluster_server_peers}:/srv/gluster/glance",
    }

  }

}

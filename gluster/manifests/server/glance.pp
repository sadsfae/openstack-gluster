# setup glance and join existing cluster
class gluster::server::glance {

    # ensure glance directory exists
    file { "/srv/gluster/glance":
        ensure => "directory",
        owner  => "root",
        group  => "root",
        mode   => "0755",
    }

    # exec glusterfs command to create glance vol if it doesn't exist, join cluster
    if $glance_exists == "0" {

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

    exec { "gluster create volume glance":
      command => "gluster volume create glance_vol replica ${replicacount} ${mystorageip}:/srv/gluster/glance ${gluster_server_peers}:/srv/gluster/glance",
    }

  }

}

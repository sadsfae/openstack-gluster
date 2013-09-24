# bare minimum needed for a new glusterfs brick
class gluster::brick (
  $server_package_name          = $gluster::params::server_package_name,
  $geo-replication_package_name = $gluster::params::geo-replication_package_name,
  $server_service_name          = $gluster::params::server_service_name,
  ) inherits gluster::params {
    Package {
        ensure => installed
    }

  package { $server_package_name : }
  package { $geo-replication_package_name : }

# Included as dependencies:
#    package { 'glusterfs' : }
#    package { 'glusterfs-fuse' :}
#    package { 'glusterfs-cli' :}
#    package { 'glusterfs-libs' :}
#    package { 'rpcbind' : }

# Out of scope:
#    package { 'nfs-utils' : }


# Out of scope: Provisioning takes care of partitioning, including mount points
#
#    # take care of the base gluster mount
#    file { "/srv/gluster":
#        ensure => "directory",
#        owner  => "root",
#        group  => "root",
#        mode   => "0755",
#    }


# Not needed: Peers are probed when created a volume:
#    exec { "gluster_peer_probe":
#        command => "/usr/sbin/gluster peer probe ${gluster_server_peers}",
#    }

    service { $server_service_name :
      ensure => "running",
     }
}

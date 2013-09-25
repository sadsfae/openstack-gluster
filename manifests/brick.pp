# bare minimum needed for a new glusterfs brick
class gluster::brick (
  $server_package_name          = $gluster::params::server_package_name,
  $geo_replication_package_name = $gluster::params::geo_replication_package_name,
  $server_service_name          = $gluster::params::server_service_name,
  $server_peers                 = $gluster::params::server_peers,
  ) inherits gluster::params {

  Package {
    ensure => installed
  }

  package { [ $server_package_name, $geo_replication_package_name ]:
  } ->

  service { $server_service_name:
    ensure => 'running',
  } #->

  # Future version
  #$servers_peers.each { |$peer|
  #  exec { 'gluster_peer_probe':
  #    command => "/usr/sbin/gluster peer probe $peer"
  #  }
  #}
  # But in the meantime:
  if $server_peers {
    $probes = repeat_cmd('gluster peer probe', $server_peers)
    exec { 'gluster_peer_probe':
      command => $probes,
      path    => "/usr/sbin"
    }
  }
}

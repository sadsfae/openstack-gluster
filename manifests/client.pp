# setup the minimum for an OpenStack GlusterFS client
class gluster::client (
  $client_package_name          = $gluster::params::client_package_name,
  ) inherits gluster::params {

  Package {
    ensure => installed
  }

  package { [ $client_package_name, $geo_replication_package_name ]:
  } ->

}

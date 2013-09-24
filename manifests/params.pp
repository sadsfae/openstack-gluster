class gluster::params {
  case $::osfamily {
    'RedHat': {
      # Package
      $server_package_name          = 'glusterfs-server' 
      $geo_replication_package_name = 'glusterfs-geo-replication'
	 	  # Services
			$server_service_name          = 'glusterd'
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily} operatingsystem: ${::operatingsystem}, module ${module_name} only support osfamily RedHat")
    }
  }
}
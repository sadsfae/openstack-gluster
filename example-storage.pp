# quickstack storage class
class quickstack::storage {

  class { 'gluster::brick':
    server_peers => [ '192.168.0.2', '192.168.0.3', '192.168.0.4' ],
  }

  volume { 'glance':
    path     => '/srv/gluster',
    bricks   => [ '192.168.0.2', '192.168.0.3', '192.168.0.4' ],
    ensure   => present,
  }

  volume { 'cinder':
    path     => '/srv/gluster',
    bricks   => [ '192.168.0.2', '192.168.0.3', '192.168.0.4' ],
    ensure   => present,
  }
}

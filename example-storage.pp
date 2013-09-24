# quickstack storage class
class quickstack::storage {

  class { 'gluster::brick': }

  volume { 'glance':
    path     => '/srv/gluster',
    bricks   => [ '192.168.0.2', '192.168.0.3' ],
    ensure   => present,
  }

  volume { 'cinder':
    path     => '/srv/gluster',
    bricks   => [ '192.168.0.2', '192.168.0.3'],
    ensure   => present,
  }
}

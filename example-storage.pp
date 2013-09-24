# quickstack storage class
class quickstack::storage {

  class { 'gluster::brick': }

  volume { 'glance_vol':
    path     => '/srv/gluster',
    user     => 'glance',
    group    => 'glance',
    bricks   => [ '192.168.0.2', '192.168.0.3' ],
    ensure   => present,
  }

  volume { 'cinder_vol':
    path     => '/srv/gluster',
    user     => 'cinder',
    group    => 'cinder',
    bricks   => [ '192.168.0.2', '192.168.0.3'],
    ensure   => present,
  }
}

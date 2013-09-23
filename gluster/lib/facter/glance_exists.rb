require 'facter'
Facter.add(:glance_exists) do
  setcode "gluster volume info glance_vol | grep cinder_vol | wc -l"
end

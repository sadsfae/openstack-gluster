require 'puppet'

module Puppet
  Puppet::Type.newtype(:volume) do
    @doc = 'A storage volume'

    ensurable

    newparam(:name) do
      isnamevar
      desc 'Volune name'
    end

    newparam(:path) do
      desc 'Volume path'
    end

    newparam(:replica) do
      desc 'Replication count'

      defaultto 2

      validate do |value|
        if value.to_i.class != Fixnum || value.to_i < 0
          raise ArgumentError, "Requires a positive integer"
        else
          super
        end
      end
    end

    newparam(:bricks) do
      desc 'List of Glusterfs server (cluster)'
    end
  end
end

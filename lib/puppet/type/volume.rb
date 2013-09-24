require "puppet"

module Puppet
  Puppet::Type.newtype(:volume) do
    @doc = ""

    ensurable

    newparam(:name) do
      isnamevar
      desc "Volune name"
    end

    newproperty(:path) do
      desc "Volume path"
    end

    newparam(:user) do
      desc "User"
    end

    newparam(:group) do
      desc "Group"
    end

    newparam(:bricks) do
      desc "List of Glusterfs server (cluster)"
    end
  end
end

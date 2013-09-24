require 'puppet'

Puppet::Type.type(:volume).provide(:gluster) do
  desc 'glusterfs volume management'

  optional_commands :gluster => '/usr/sbin/gluster'

  def exists?
    gluster('volume', 'status', @resource[:name]) 
  rescue Puppet::ExecutionFailure
    return false
  end

  def create 
    if @resource[:bricks].class == String
      gluster('volume', 'create', @resource[:name], brick_list)
    else
      probe
      # Had to spawn directly because the optional_commands parameters nightmare!
      system("/usr/sbin/gluster volume create #{@resource[:name]} replica #{@resource[:bricks].size} #{brick_list}")
    end

    gluster('volume', 'start', @resource[:name])
  end

  def destroy
    # Not working: gluster command needs confirmation!
    # gluster('volume', 'stop', @resource[:name])
    # gluster('volume', 'delete', @resource[:name])
  end

  private 

  def brick_list
    volume = File.join(@resource[:path], @resource[:name])
    list = ''
    @resource[:bricks].each do |brick|
      list << "#{brick}:#{volume} "
    end
    return list
  end

  def info?(str)
    value = nil
    res = %x(/usr/sbin/gluster volume info #{@resource[:name]})
    if $?.success?
      res.each_line do |line|
        value = true if line =~ /#{str}/i
      end
    end
    return value
  end

  def probe
    @resource[:bricks].each do |peer|
      gluster('peer', 'probe', peer)
    end
  rescue
    return true
  end

end
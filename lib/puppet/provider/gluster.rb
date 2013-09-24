require "puppet"

Puppet::Type.type(:volume).provide(:gluster) do
  optional_commands :gluster => "/usr/sbin/gluster"

  def exists?
    gluster("volume", "info", @resource[:name])
  rescue Puppet::ExecutionFailure
    return false
  end

  def create
    @volume = File.join(@resource[:path], @resource[:name])  	
    if !Dir.exist?(@volume)
      Dir.mkdir(@volume, 0750)
      File.chown(@resource[:user], @resource[:group], @volume)
    end

    # WIP: gluster main server might have a list of bricks? => no bricks param
    if @resource[:bricks].size > 1
      gluster("volume", "create", @resource[:name], "replica #{@resource[:bricks].size}", bricks)
    else
      # 
      gluster("volume", "create", @resource[:name], bricks)
    end
  end

  def destroy
    gluster("remove", @resource[:name])
  end

  private

  def bricks
    list = ""
    @resource[:peers].each do |brick|
      list << "#{brick}:#{@volume}"
    end	
    return list
  end
end
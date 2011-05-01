require 'fileutils'
require File.join(File.dirname(__FILE__), 'growl')

class KindleSync
  attr_accessor :growl, :volume

  def initialize(volume)
    @volume = volume
    @growl = Growl.new "127.0.0.1", "Kindle Sync", sync_states
  end
  
  def ready?
    File.directory? volume_path
  end
  
  def process(source, dest)
    counter = 0
    pattern = Regexp.new("^#{source}/")
    
    begin
      notify("info", "Beginning transfer...")

      files = Dir["#{source}/*/*.*"]
      
      files.each do |source_file|
        filename = source_file.gsub(pattern, "")
        dest_file = File.join(volume_path, dest, filename)

        unless File.exists? dest_file
          FileUtils.mkdir_p(File.dirname(dest_file))
          FileUtils.cp(source_file, dest_file)
          counter += 1
        end
      end

      notify("success", "Transfered #{counter} files")
    rescue
      error($!)
    end
  end
  
  protected
  
  def volume_path
    "/Volumes/#{@volume}"
  end
  
  def sync_states
    ["sync-info", "sync-success", "sync-error"]
  end
  
  def notify(status, msg)
    @growl.notify "sync-#{status}", "Kindle Sync", msg
  end
  
  def error(msg)
    @growl.notify "sync-error", "Kindle Sync Error!", msg.to_s
  end
end
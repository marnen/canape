require File.join File.dirname(__FILE__), 'couchdb_api'

module CouchDBWorld
  class << self
    attr_reader :couch, :database
    
    def set_db(options)
      defaults = {:host => nil, :port => nil, :admin => nil, :password => nil, :database => nil}
      options = defaults.merge options
      @couch = CouchDBApi::Server.new options[:host], options[:port], "", {:user => options[:admin], :password => options[:password]}
      @database = options[:database]
      if @database !~ %r{\A/}
        @database = "/#{@database}"
      end
    end
  end
  
  def couch
    CouchDBWorld.couch
  end
  
  def database
    CouchDBWorld.database
  end
end

require File.join File.dirname(__FILE__), 'couchdb_api'

module CouchDBWorld
  class << self
    attr_reader :couch
    
    def set_db(options)
      defaults = {:host => nil, :port => nil, :admin => nil, :password => nil}
      options = defaults.merge options
      @couch = CouchDBHelper.new options[:host], options[:port], options[:admin], options[:password]
    end
    
    def method_missing(name, *args, &block)
      @couch.send name, args, block
    end
  end
 end

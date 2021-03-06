require 'capybara'
require 'capybara/dsl'
require 'capybara/cucumber'
require 'capybara/mechanize/cucumber'
require 'yaml'
require 'ruby-debug'
require 'rspec'
require File.join File.dirname(__FILE__), 'couchdb_helpers'
require File.join File.dirname(__FILE__), 'couchdb_world'

env = File.open('config/database.yml') { |yf| YAML::load yf  }["test"]
appname = 'canape'

module WithinHelpers
  def with_scope(locator)
    locator ? within(*selector_for(locator)) { yield } : yield
  end
end
World(WithinHelpers)

# Capybara.default_driver = :selenium
Capybara.default_driver = :mechanize
Capybara.app_host = "http://#{env['host']}:#{env['port']}/#{env['database']}/_design/#{appname}/_rewrite"
World(Capybara)

CouchDBWorld.set_db host: env['host'], port: env['port'], database: env['database'], admin: env['admin'], password: env['password']
World(CouchDBWorld)

# change auth db before testing
Before do
  helper = CouchDBHelper.new(env["host"], env["port"], env["admin"], env["password"], appname)
  helper.change_auth_db(env["authdb"])
end

Before "@withuser" do
  helper = CouchDBHelper.new(env["host"], env["port"], env["admin"], env["password"], appname)
  helper.signup_user(env["authdb"], "User", "secret")
end

# cleanup CouchDB after scenarios
After do
  helper = CouchDBHelper.new(env["host"], env["port"], env["admin"], env["password"], appname)
  helper.change_auth_db
  helper.delete_db(env["authdb"])
  helper.clear_db(env["database"])
end

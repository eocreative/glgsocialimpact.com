#!/usr/bin/env ruby
# encoding:utf-8
unless File.respond_to? :realpath
  class File #:nodoc:
    def self.realpath path
        return realpath(File.readlink(path)) if symlink?(path)
        path
      endartic
    end
  end
end

$: << File.expand_path(File.dirname(File.realpath(__FILE__)))
require 'sinatra'
require 'rubygems'
require 'json'
require 'logger'
require 'lib/helpers'
require 'net/smtp'
# require 'mustache'

# Start Sinatra

set :port, ARGV[0]
set :bind, '0.0.0.0'
# set :environment, :production

get '/' do
  content_type :html
  erb :home
end

get '/api' do
  content_type :html
  erb :reply
end


configure do
    disable :protection
    # sets root as the parent-directory of the current file
    set :root, File.join(File.dirname(__FILE__), '..')
    # sets the view directory correctly
    # set :views, Proc.new { File.join(root, "templates/views") } 
    set :public_folder, Proc.new { File.join(root, "public") }
end

after do
  # @logfile.close
end

before do
  @home = ENV['APP_DIRECTORY'] || '/home/glgapp/glgimpact'
  # @logfile = File.open("#{@home}/var/log/glgimpact-api.log", File::WRONLY | File::APPEND | File::CREAT)
  #@log = Logger.new(@logfile, 10, 1024000)
  #@log.level = ENV['GLGENV'] == 'PRD' ? Logger::INFO : Logger::DEBUG 
 

  #content_type :json 
  #setting response headers to handle CORS
  response.headers["Access-Control-Allow-Origin"] = "*"
  response.headers["Access-Control-Allow-Methods"] = "POST"
  response.headers["Access-Control-Allow-Headers"] = "*"

end #before



post '/api/contact' do

  begin
    puts params.to_json
    # @log.debug request.env.to_json
    template = render_file('application_email.mustache', params)
    # @log.debug template
    opts = {
      :body => template
    }
    send_email(opts)
  rescue Exception=>e
    return [500]
    @log.error e
  ensure
    return [200]
  end

end



__END__


@@reply
This is the api for GLGImpact.

@@home
healthy

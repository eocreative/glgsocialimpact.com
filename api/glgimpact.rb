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

require 'sinatra'
require 'rubygems'
require 'json'
require 'logger'
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
    set :views, Proc.new { File.join(root, "templates/views") } 
    set :public_folder, Proc.new { File.join(root, "public") }
end

after do
  @logfile.close
end

before do
  @home = ENV['APP_DIRECTORY'] || '/home/glgapp/glgimpact'
  @logfile = File.open("#{@home}/var/log/glgimpact-api.log", File::WRONLY | File::APPEND | File::CREAT)
  @log = Logger.new(@logfile, 10, 1024000)
  @log.level = ENV['GLGENV'] == 'PRD' ? Logger::INFO : Logger::DEBUG 
  def send_email(opts={})
    opts[:server]      ||= 'localhost'
    opts[:from]        ||= 'noreply@glgroup.com'
    opts[:to]          ||= ENV['GLGIMPACT_EMAIL_CONTACT'] || 'falleyne@glgroup.com'
    opts[:from_alias]  ||= 'GLGimpact.com Application'
    opts[:subject]     ||= "GLGimpact.com Application Submission"
    opts[:body]        ||= "Error processing the body of the message."

    msg = <<END_OF_MESSAGE
From: #{opts[:from_alias]} <#{opts[:from]}>
To: <#{opts[:to]}>
Subject: #{opts[:subject]}
MIME-Version: 1.0
Content-type: text/html
A message from the website:
\n\r
Name: #{opts[:ContactFrom]}
Email: #{opts[:ContactEmail]}
\n\r
Comments:
#{opts[:body]}
END_OF_MESSAGE

    Net::SMTP.start(opts[:server]) do |smtp|
      smtp.send_message msg, opts[:from], opts[:to]
    end
  end #send_email

  #content_type :json 
  #setting response headers to handle CORS
  response.headers["Access-Control-Allow-Origin"] = "*"
  response.headers["Access-Control-Allow-Methods"] = "POST"
  response.headers["Access-Control-Allow-Headers"] = "*"

end #before



post '/api/contact' do
  @log.info 'Params received: ' + params.to_json
  begin
    opts = {
      :form => params[:form] 
    }
    

    send_email(opts)
  rescue Exception=>e
    return "Error"
    @log.error e
  ensure
   return "success"
  end

end



__END__




@@home
healthy

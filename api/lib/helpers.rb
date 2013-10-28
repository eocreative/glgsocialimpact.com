require 'net/smtp'
require 'mustache'

def send_email(opts={})
  @log.debug "In SEND EMAIL"
  # @log.debug opts.to_json
    opts[:server]      ||= 'localhost'
    opts[:from]        ||= 'noreply@glgroup.com'
    opts[:to]          ||= ENV['GLGIMPACT_EMAIL_CONTACT'] || 'falleyne@glgroup.com'
    opts[:from_alias]  ||= 'GLGimpact.com Application'
    opts[:subject]     ||= "GLGimpact.com Application Submission"
    opts[:body]        ||= "Error processing the body of the message."
  @log.debug "TO address #{opts[:to]}"
    msg = <<END_OF_MESSAGE
From: #{opts[:from_alias]} <#{opts[:from]}>
To: <#{opts[:to]}>
Subject: #{opts[:subject]}
MIME-Version: 1.0
Content-type: text/html

#{opts[:body]}
END_OF_MESSAGE

    Net::SMTP.start(opts[:server]) do |smtp|
      begin
        @log.debug "#{msg} #{opts[:from]} #{opts[:to]}"
        response = smtp.send_message msg, opts[:from], opts[:to]
        @log.info "glgimpact_email_status=#{response.status}"
      rescue Exception=>e
        @log.error e
      end
    end
end #send_email

def render_file (filename, payload)
  @home = ENV['APP_DIRECTORY'] || '/home/glgapp/glgimpact'
  begin
	    @log.debug "Searching for file: #{filename}"
		Dir.chdir(@home + '/api/templates')
		file = Dir.glob("**/#{filename}")[0]
		@log.debug "Found File: #{file}"
		template = File.open("#{@home}/api/templates/#{file}", 'rb').read
		#@log.debug "Using Template: #{template}"
		return Mustache.render(template, payload)
  rescue Exception => e
    	@log.error "Issue with filename"
    	@log.error e
  end

end #render_file
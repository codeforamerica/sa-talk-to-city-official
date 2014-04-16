require 'twilio-ruby'
 
class TwilioController < ApplicationController
  include Webhookable
 
  after_filter :set_header
  
  skip_before_action :verify_authenticity_token
 
  def voice
    response = Twilio::TwiML::Response.new do |r|
      r.Say 'Hey there. Congrats on integrating Twilio into your Rails 4 app.', :voice => 'alice'
         # r.Play 'http://linode.rabasa.com/cantina.mp3'
         r.Record :maxLength => '60', :action => '/handle_record', :method => 'get'
    end
 
    render_twiml response
  end

  def handle_record
    Twilio::TwiML::Response.new do |r|
      r.Say 'Listen to your recording', :voice => 'alice'
      r.Play params['RecordingUrl']
      r.Say 'Goodbye.'
      puts params['RecordingUrl']
    
end
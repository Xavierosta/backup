# This controller deals with handling of webhooks received from the Dropbox servers. This webhook is received everytime there is a change in the files of a registered Dropbox User. On receiving this webhook, we initiate a Job Upload for that particular User.
class WebHooksController < ApplicationController
  
  skip_before_filter :verify_authenticity_token
  
  include DropboxManager
  
  # GET /webhook(.:format)
  # This request is made by the Dropbox servers only ONE TIME during the verification stage. A challange parameter is received from the servers which should be sent back as a response.
  def verify
    # Log.create(msg: params.to_s)
    render :text => "#{params[:challenge]}", :layout => false
  end
  
  # POST /webhook(.:format)
  # This request is made by the Dropbox server when they want to notify us of a change in registered users dropbox account. We are provided with a list of uids. Then their Job upload is triggered.
  def notify

    #move_files
    #recorder_archive
    backup
    
    render :text => "", :layout => false
  end
  
end
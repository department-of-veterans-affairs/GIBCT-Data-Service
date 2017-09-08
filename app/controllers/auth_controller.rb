# frozen_string_literal: true
require 'saml/settings'

class AuthController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def new
    request = OneLogin::RubySaml::Authrequest.new
    redirect_to(request.create(saml_settings))
  end

  def callback
    response = OneLogin::RubySaml::Response.new(params[:SAMLResponse], 
                                                settings: saml_settings)
    puts response.document
    response.attributes.each { |x| puts "#{x}: #{response.attributes[x]}" }
    if response.is_valid?
      session[:userid] = response.nameid
      session[:attributes] = response.attributes
      Rails.logger.info("Logged in user #{response.nameid}")
      redirect_to root_url
    else
      Rails.logger.info("Failed log in with response #{response}")
      redirect_to root_url + "?auth=fail"
    end
  end

  def metadata
    meta = OneLogin::RubySaml::Metadata.new
    render :xml => meta.generate(saml_settings), :content_type => "application/samlmetadata+xml"
  end
  
  def saml_settings
    @settings ||= SAML::Settings.settings
  end

end

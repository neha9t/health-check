require_relative '../workers/health_check_worker'
require 'pry'

class CheckController < ApplicationController
# post '/details/new' do
  def show
    render "new"
  end

  def new
    @details = Check.create(check_params)
    @details.save
    @details.to_json
    redirect_to("/")
  end

  # get '/details' do
  def index
    # protected!
    # if authorized?
      @details = Check.order(created_at: :desc)
      # redirect_to('/show') and return if @details.empty?
      @details.to_json
      render "view_all"
    # end
  end

  # get '/details/:id' do
  def check  
    @details = Check.find(params[:id])
    @title = "Edit note ##{params[:id]}"
    @details.to_json
    render "edit"
  end

  # put '/details/:id' do
  def update
    @details = Check.find(params[:id])
    if params[:enabled] != @details.enabled
      if params[:enabled] == true
        HealthCheckWorker.perform_async(@details.id)
      else
        
      end
    end
    @details.interval = params[:interval]
    @details.url = params[:url]
    @details.enabled = params[:enabled]
    @details.save
    @details.to_json
    redirect_to("/")
  end

  # get '/:id/delete' do
  def deletion_details
    @details = Check.find(params[:id])
    @title = "Edit note ##{params[:id]}"
    render "delete"
  end

  # delete '/:id' do
  def delete  
    @details = Check.find(params[:id])
    @details.destroy
    redirect_to("/")
  end

  def check_params
      params.permit(:url, :enabled, :interval)
  end
end
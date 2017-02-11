class CheckController < ApplicationController

# post '/details/new' do
  def new
    params.to_s
    "Hello, world, I am the new change!"
    @details = FormDetails.new(params)
    @details.save
    # binding.pry
    if params[:enabled] == "true"
      HealthCheck.perform_async(@details.id)
    end
    @details.to_json
    redirect to("/details")
  end

  # get '/details' do
  def index
    # protected!
    # if authorized?
      @details = FormDetails.all(:order => :created_at.desc)
      redirect to('/show') if @details.empty?
      @details.to_json
      erb :view_all
    # end
  end

  # get '/details/:id' do
  def check  
    @details = FormDetails.get(params[:id])
    @title = "Edit note ##{params[:id]}"
    @details.to_json
    erb :edit
  end

  # put '/details/:id' do
  def update
    @details = FormDetails.get(params[:id])
    if params[:enabled] != @details.enabled
      if params[:enabled] == true
        HealthCheck.perform_async(@details.id)
      else
        
      end
    end
    @details.method_name = params[:method_name]
    @details.interval = params[:interval]
    @details.url = params[:url]
    @details.enabled = params[:enabled]
    @details.save
    @details.to_json
    redirect to("/details")
  end

  # get '/:id/delete' do
  #   @details = FormDetails.get(params[:id])
  #   @title = "Edit note ##{params[:id]}"
  #   erb :delete
  # end

  # delete '/:id' do
  def delete  
    @details = FormDetails.get(params[:id])
    @details.destroy
    redirect to("/details")
  end

end
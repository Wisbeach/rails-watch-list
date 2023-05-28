class ListsController < ApplicationController
  def index
    @lists = List.all
  end

  def show
    @list = List.find(params[:id])
  end

  def new
    @list = List.new
  end
  require 'net/http'
  
  def create
    @list = List.new(list_params)

    # Add the API request code here
    url = URI("https://api.themoviedb.org/3/authentication")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(url)
    request["accept"] = 'application/json'
    response = http.request(request)
    puts response.read_body

    if @list.save
      redirect_to list_path(@list)
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    @list = List.find(params[:id])
    @list.destroy

    respond_to do |format|
      format.html { redirect_to lists_path, notice: 'List was successfully removed.' }
      format.js
    end
  end

  private

  def list_params
    params.require(:list).permit(:name)
  end
end

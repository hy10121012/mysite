class TagsController  < ApplicationController

  def index
    @tags = Tag.all;
    render json: @tags
  end

  def show
    @tag = Tag.find(params[:id])
  end


end
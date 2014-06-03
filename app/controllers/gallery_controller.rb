class GalleryController < ApplicationController

  def index

  end

  def get_pic
    @photo = Gallery.all.limit(10);
    render json: @photo
  end

end

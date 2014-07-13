class GalleryController < ApplicationController

  def album
    @albums = Album.all
  end

  def show
    @photos = Album.find(params[:id]).photos.order(:created_at).limit(20)
  end

  def get_more_photo
    @photos =  Album.find(params[:id]).photos.order(:created_at).limit(20).offset(params[:offset])
    @offset =  params[:offset]
    render :get_more_photo,:locals => {id:params[:id]}, :layout=>false
  end

  def get_pic
    @photo = Photo.all
    render json: @photo
  end

  def create
    @photo = Photo.new
    @album = Album.find(params[:id]);
    render :upload,:locals => {id:params[:id]}
  end

  def new

  end

  def new_create
    @album = Album.new
    @album.name = params[:gallery][:name]
    @album.description=params[:gallery][:description]
    @album.save

    redirect_to '/album/'+@album.id.to_s+'/upload'
  end

end

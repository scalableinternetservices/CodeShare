#app/controllers/photos_controller.rb
 
class PhotosController < ApplicationController
  before_action :set_photos, only: [:show, :edit, :update, :destroy]
 
  def index
    @photos = Photo.all
  end
 
  def new
    @photo = Photo.new
  end
 
  def create
    @photo = Photo.new(photo_params)
    if @photo.save
      redirect_to @photo.show
    else
      render :new
    end
  end
 
  def show
  end
   
  def edit
  end
 
  def update
    if @photo.update(photo_params)
      redirect_to @photo, notice: "photo successfully updated"
    else
      render :edit
    end
  end
 
  def destroy
    @photo.destroy
    redirect_to photos_url, notice: 'photo was successfully destroyed.'
  end
 
  private
 
  def photo_params
    params.require(:photo).permit(:image, :title)
  end
 
  def set_photos
    @photo = Photo.find(params[:id])
  end
end
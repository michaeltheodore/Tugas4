class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def create
    @photo = Photo.new(param_photo)
    if @photo.save
      redirect_to photos_path, :notice => "Upload image #{@photo.title} berhasil"
    else
      render "new", :error => "Upload image #{@photo.title} gagal"
    end
  end
  
  def new
    @photo = Photo.new
  end
  
  def edit
    @photo = Photo.find(param[:id])
  end

  def update
    @photo = Photo.find(param[:id])
    if @photo.update(param_photo)
      redirect_to photos_path, :notice => "Update image #{@photo.title} berhasil"
    else
      render "new", :error => "Update image #{@photo.title} gagal"
    end
  end
  
  def index
    @photos = Photo.all
  end

  def show
    @photo = Photo.find(param[:id])
  end

  def destroy
    @photo = Photo.find(param[:id])
    if @photo.destroy
      redirect_to photos_path, :notice => "Delete photo #{@photo.title} berhasil"
    else
      redirect_to photos_path, :error => "Delete photo #{@photo.title} gagal"
    end
  end

  def param_photo
    param.require(:photo).permit(:title, :photo_file_name)
  end
end

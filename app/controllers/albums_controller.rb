class AlbumsController < ApplicationController

  before_action :find_album,  only: [:show, :edit, :update]
  before_action :build_album, only: [:new, :create]
  before_action :build_form,  only: [:new, :create, :edit, :update]

  def index
    @albums = Album.all
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    if @form.validate(params[:album])
      @form.save
      redirect_to album_path(@album)
    else
      render :new
    end
  end

  def update
    if @form.validate(params[:album])
      @form.save
      redirect_to album_path(@album)
    else
      render :edit
    end
  end

private

  def find_album
    @album = Album.find(params[:id])
  end

  def build_album
    @album = Album.new
    # Build a Song object for each song that was submitted from the form
    count = params[:album] ? params[:album][:songs_attributes].size : (1+rand(7)).ceil
    count.times do
      @album.songs.build
    end
  end

  def build_form
    @form = Forms::AlbumForm.new(@album)
  end

end

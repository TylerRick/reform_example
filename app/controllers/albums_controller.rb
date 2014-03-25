class AlbumsController < ApplicationController
  respond_to :js, :html

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
    workflow = Workflows::AlbumWorkflow.new(@form, params[:album])
    workflow.process do |album|
      return respond_with album
    end
    render :new
  end

  def update
    workflow = Workflows::AlbumWorkflow.new(@form, params[:album])
    workflow.process do |album|
      return respond_with album
    end
    render :edit
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

class SongsController < ApplicationController
  def index
    #@songs = Song.all
    #allow the songs#index and songs#show actions to handle a valid song for the artist
    #in the songs index action, if the artist cant be found, redirect to the index of artists, and set a flash[:alert]
    #if somone passes in the artist id to index (index/:id)
    #find the artist id by the id params if there is no artist id, then return the alert
    #else if there is an id, return the songs, else if there are no params or fileters, return all the songs
    if params[:artist_id]
      @artist = Artist.find_by(id: params[:artist_id])
      if @artist.nil?
        redirect_to artists_path, alert: "Artist not found"
      else 
        @songs = @artist.songs
      end 
    else 
    @songs = Song.all
    end 
  end

  def show
    #@song = Song.find(params[:id])
    #songs#show action, if the song cant be found for a given artist, redirect to the index of the artist's songs and set a flash[:alert]
    #alert of "Song not found"
    #show artist_id, if @song.nil, redirect again to the artist song path and alert song not found
    if params[:artist_id]
      @artist = Artist.find_by(id: params[:artist_id])
      @song = @artist.songs.find_by(id: params[:id])
      if @song.nil?
        redirect_to artist_songs_path(@artist), alert: "Song not found"
      end 
    else 
      @song = Song.find(params[:id])
    end 
  end

  def new
    @song = Song.new
  end

  def create
    @song = Song.new(song_params)

    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def song_params
    params.require(:song).permit(:title, :artist_name)
  end
end


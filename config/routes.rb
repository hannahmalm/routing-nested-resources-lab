Rails.application.routes.draw do
  resources :artists do #parent
    resources :songs, only: [:index, :show] #child - index and show controllers 
  end 
  resources :songs
 end
  #create nested resource routes to show all songs for an artist
  #restrict nested sogns routes to index and show actions 
  #artist = parent, songs = child
  #/artists/1/songs - show all songs for an artist
  #/artists/1/songs/1 - Show individual songs for the artist 

  


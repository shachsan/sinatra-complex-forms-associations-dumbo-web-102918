require 'pry'

class OwnersController < ApplicationController

  get '/owners' do
    @owners = all_owners
    erb :'/owners/index'
  end

  get '/owners/new' do
    @pets = all_pets
    erb :'/owners/new'
  end

  post '/owners' do
    @owner = Owner.create(params[:owner])
    if !params["pet"]["name"].empty?
      @owner.pets << Pet.create(name: params["pet"]["name"])
    end
    # binding.pry
    redirect "owners/#{@owner.id}"
  end

  get '/owners/:id/edit' do
    @pets = all_pets
    @owner = owner_find_by_id(params[:id])
    erb :'/owners/edit'
  end

  get '/owners/:id' do
    @owner = owner_find_by_id(params[:id])
    # binding.pry
    erb :'/owners/show'
  end

  patch '/owners/:id' do
    if !params[:owner].keys.include?("pet_ids")
      params[:owner]["pet_ids"] = []
    end

    @owner = owner_find_by_id(params[:id])
    @owner.update(params[:owner])
    if !params["pet"]["name"].empty?
      @owner.pets << Pet.create(name:params["pet"]["name"])
    end
    binding.pry
    redirect "/owners/#{@owner.id}"
  end

  delete '/owners/:id' do
    @owner = owner_find_by_id(params[:id])
    @owner.destroy
    redirect '/owners'
  end

  def all_pets
    Pet.all
  end

  def owner_find_by_id(id)
    Owner.find(id)
  end

  def pet_find_by_id(id)
    Pet.find(id)
  end

  def all_owners
    Owner.all
  end
end

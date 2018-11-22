class PetsController < ApplicationController

  get '/pets' do
    @pets = all_pets
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owners=all_owners
    erb :'/pets/new'
  end

  post '/pets' do
    # binding.pry
    @pet = Pet.create(params[:pet])
    if !params[:owner][:name].empty?
      @owner = Owner.create(params[:owner][:name])
      @pet.owner=@owner.id
    end
    redirect to "pets/#{@pet.id}"
  end


  get '/pets/:id' do
    @pet = pet_find_by_id(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    # binding.pry
    @pet = pet_find_by_id(params[:id])
    @owners = all_owners
    erb :'/pets/edit'
  end

  patch '/pets/:id' do
    @pet = pet_find_by_id(params[:id])
    if params[:owner][:name].empty?
      @pet.update(params[:pet])
    else
      @owner = Owner.create(params[:owner])
      @pet.update(name:params[:pet][:name], owner_id:@owner.id)
      # @owner.pets << @pet
    end
    redirect to "pets/#{@pet.id}"
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

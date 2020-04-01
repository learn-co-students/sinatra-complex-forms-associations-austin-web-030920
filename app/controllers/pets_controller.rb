class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do 
    if !params[:pet][:owner_name].empty?
      @owner = Owner.create(name: params[:pet][:owner_name])
      params[:pet][:owner_id] = @owner.id
    end
    
    params[:pet].delete("owner_name")
    @pet = Pet.find_or_create_by(params[:pet])
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get "/pets/:id/edit" do
    @owners = Owner.all
    @pet = Pet.find(params[:id])
    erb :"pets/edit"
  end

  patch '/pets/:id' do 
    if !params[:owner][:name].empty?
      @owner = Owner.create(params[:owner])
      params[:pet][:owner_id] = @owner.id
    end
    
    @pet = Pet.find(params[:id])
    if @pet.update(params[:pet])
      redirect to "pets/#{@pet.id}"
    else
      erb :"/pets/#{@pet.id}/edit"
    end
  end
end
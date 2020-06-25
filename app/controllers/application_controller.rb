require 'pry'
class ApplicationController < Sinatra::Base
  set :views, "./app/views"

  get('/apartment-list') do 
    @apartments = Apartment.all
    erb :apartment_list
  end
  get('/get-apartment/:id') do
      @apartment = Apartment.find(params[:id])
      erb :one_apartment
  end

  post('/remove_apartment/:id') do
    @apartment = Apartment.find(params[:id])
    @apartment.destroy()
    redirect('/apartment-list')
  end

  get('/new-apartment-building') do 
    @apartment = Apartment.all
    erb :new_apartment
  end
  post('/new-apartment') do 
    @apartment = Apartment.create({
        address: params[:apartment_address]
    })
    redirect('/apartment-list')
  end

  get('/tenants-list') do 
    @tenant = Tenant.all
    erb :tenants_list
  end
  get('/get-tenant/:id') do
    @apartment = Apartment.all
    @tenant = Tenant.find(params[:id])
    erb :one_tenant
  end
  post('/remove_tenant/:id') do
    @tenant= Tenant.find(params[:id])
    @tenant.destroy()
    redirect('/tenants-list')
  end

  get('/new-tenant-create') do
    @all_apartments =  Apartment.all 
    @tenant = Tenant.all
    erb :new_tenant
  end
  post('/new-tenant') do 
    @tenant = Tenant.create({
        name: params[:tenant_name],
        apartment_id: params[:apartment_address]
    })
    redirect("/get-tenant/#{@tenant.id}") 
  end

  get("/get-tenant/:id")do
  @tenant = Tenant.find(params[:id])
  erb :one_tenant
  end

  post('/edit-tenant/:id') do
  @tenant= Tenant.find(params[:id])
  @tenant.update(name: params[:tenant_name], apartment_id: params[:apartment_address])
  redirect('/tenants-list')
  erb :one_tenant
  end

end
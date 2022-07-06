class AddressesController < ApplicationController

  PER_PAGE = 6

  def new 
    
    begin
      @address = current_user.addresses.build(address_params)
      @address.save
      redirect_to address_path, notice: "address was successfully created."
    rescue
      flash[:alert] = "Could not save address"
      render :new, status: :unprocessable_entity
    end

  end

  def address
    @addresses = current_user.addresses.order('created_at desc').page(params['page']).per(PER_PAGE)
  end

  def new_address
    @address = Address.new
    if params[:query]
      @addresses = AddressFinder.new(params[:query]).find_addresses['data']
    end
    render 'addresses/new', addresses: @addresses
  end

  private 

  def address_params
    params.permit(:street, :number, :region, :region_code, :county, :country, :country_code, :administrative_area, :latitude, :longitude, :label)
  end

end

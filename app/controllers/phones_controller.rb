class PhonesController < ApplicationController
  before_action :authenticate_user!

  PER_PAGE = 12

  def index
    @phones = current_user.phones.order('created_at desc').page(params['page']).per(PER_PAGE)
  end

  def new
    @phone = Phone.new
  end

  def save_new_phone 
      @phone = current_user.phones.build(phone_params)
      if @phone.save
        redirect_to phone_path, notice: "Phone was successfully created."
      else
        flash.now[alert:] = "could not save phone."
        render :new, status: :unprocessable_entity
      end
  end

  def delete
    begin
      @phone = current_user.phones.find_by(id: params[:phone])
      @phone.destroy
      redirect_to phone_path, notice: "Phone was successfully deleted."
    rescue
      flash.now[alert:] = "could not delete phone."
      render :index, status: :unprocessable_entity
    end
  end

  private 

  def phone_params
    params.permit(:phone, :country)
  end


end

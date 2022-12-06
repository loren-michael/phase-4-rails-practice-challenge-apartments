class ApartmentsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :apartment_errors

  def index
    apartments = Apartment.all
    render json: apartments, only: :number, include: [:tenants, :leases]
  end

  def show
    apartment = find_apartment
    render json: apartment, only: :number, include: [:tenants, :leases]
  end

  def create
    apartment = Apartment.create(apartment_params)
    if apartment.valid?
      render json: apartment, status: :created      
    end
  end

  def update
    apartment = find_apartment
    apartment.update(apartment_params)
    if apartment.valid?
      render json: apartment, status: :accepted
    end
  end

  def destroy
    apartment = find_apartment
    apartment.destroy
    render json: { message: "This apartment has been deleted." }, status: :no_content
  end

  private

  def find_apartment
    apartment = Apartment.find(params[:id])
  end

  def apartment_params
    params.permit(:number)
  en

  def apartment_errors
    render json: { errors: apartment.errors.full_messages }
  end

end

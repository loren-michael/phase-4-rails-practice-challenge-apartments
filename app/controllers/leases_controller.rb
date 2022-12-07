class LeasesController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :lease_errors

  def create
    lease = Lease.create(lease_params)
    if lease.valid?
      render json: lease, status: :created      
    end
  end

  def destroy
    lease = find_lease
    lease.destroy
    render json: { message: "This lease has been deleted." }, status: :accepted
  end

  private

  def find_lease
    lease = Lease.find(params[:id])
  end

  def lease_params
    params.permit(:rent, :apartment_id, :tenant_id)
  end

  def lease_errors
    render json: { errors: lease.errors.full_messages }
  end
end

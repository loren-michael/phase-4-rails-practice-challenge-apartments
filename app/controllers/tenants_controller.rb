class TenantsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :tenant_errors

  def index
    tenants = Tenant.all
    render json: tenants, only: [:name, :age], include: [:apartment, :lease]
  end

  def show
    tenant = find_tenant
    render json: tenant, only: [:name, :age], include: [:apartment, :lease]
  end

  def create
    tenant = Tenant.create(tenant_params)
    if tenant.valid?
      render json: tenant, status: :created      
    end
  end

  def update
    tenant = find_tenant
    tenant.update(tenant_params)
    if tenant.valid?
      render json: tenant, status: :accepted
    end
  end

  def destroy
    tenant = find_tenant
    tenant.destroy
    render json: { message: "This tenant has been deleted." }, status: :no_content
  end

  private

  def find_tenant
    tenant = Tenant.find(params[:id])
  end

  def tenant_params
    params.permit(:name, :age)
  end

  def tenant_errors
    render json: { errors: tenant.errors.full_messages }
  end
end

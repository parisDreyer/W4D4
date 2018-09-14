# bands     GET    /bands(.:format)                       bands#index
#           POST   /bands(.:format)                       bands#create
# new_band  GET    /bands/new(.:format)                   bands#new
# edit_band GET    /bands/:id/edit(.:format)              bands#edit
# band      GET    /bands/:id(.:format)                   bands#show
#           PATCH  /bands/:id(.:format)                   bands#update
#           PUT    /bands/:id(.:format)                   bands#update
#           DELETE /bands/:id(.:format)                   bands#destroy

class BandsController < ApplicationController

  def index
    @bands = Band.all
    render :index
  end

  def edit
    @band = Band.find(params[:id])
    render :edit
  end

  def new
    @band = Band.new
    render :new
  end

  def show
    @band = Band.find(params[:id])
    render :show
  end

  def destroy
    @band = Band.find(params[:id])
    @band.destroy
    redirect_to bands_url
  end

  def create

    @band = Band.new(band_params)

    if @band.save
      redirect_to bands_url(@band)
    else
      flash.now[:errors] = @band.errors.full_messages
      render :new
    end
  end

  def update
    @band = Band.find(params[:id])

    if @band.update(band_params)
      redirect_to band_url(@band)
    else
      render json: @band.errors.full_messages, status: 422
    end
  end



  private

  def band_params
    name = band_params_name
    if name
      member_id = find_member_id(name['band_member_name'])
      params[:member_id] = member_id if member_id
    end
    params.require(:band).permit(:name, :member_id)
  end

  # band_member_name set in the _form.html.erb
  def band_params_name
    params.require(:band).permit(:band_member_name)
  end

  def find_member_id(username)
    member = User.find_by(username: username)
    member ? member.id : nil
  end

end

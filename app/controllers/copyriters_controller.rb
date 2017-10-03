class CopyritersController < ApplicationController
  authorize_resource class: false

  # GET /copyriters/new
  def new
    @copyriter = User.new
  end

  # POST /copyriters
  def create
    @copyriter = User.new(copyriter_params)
    @copyriter.roles << Role.find_by_name(:copyriter)

    if @copyriter.save
      redirect_to redirect_path, notice: 'Copyriter was successfully created.'
    else
      render :new
    end
  end

  # DELETE /copyriters/1
  def destroy
    User.find(params[:id]).destroy
    redirect_to redirect_path, notice: 'Copyriter was successfully destroyed.'
  end

  private

  def redirect_path
    return_url || dashboard_url
  end

  def copyriter_params
    params.require(:user).permit(:email, :password)
  end
end

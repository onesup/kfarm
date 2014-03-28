class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :current_works]
  
  def show
  end

  def edit
  end

  def new
  end
  
  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update(user_params)
        format.json { head :no_content }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def current_works
    @works = @user.current_works
    # @works = self
  end
    
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :phone, :email, :data)
    end
end

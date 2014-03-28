class Mentor::UsersController < ApplicationController
  layout 'mentor'
  before_action :set_user, only: [:show, :edit, :password, :update, :destroy]
  # GET /users
  # GET /users.json
  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/1/edit
  def edit
  end
  
  def password
  end
  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to mentor_user_path(@user), notice: 'user was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to root_호h }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = current_user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params["user"]["uid"] = User.fb_username_to_fb_id(params["user"]["uid"])
      params.require(:user).permit(:id, :email, :password, :name, :phone, :avatar, :farm, 
                                    :mentor_major, :mentor_guide, :role_id, :uid)
    end
end

class UsersController < ApplicationController

  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to user_path(current_user)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    current_user.destroy
    redirect_to root_path, status: :see_other
  end


  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :phone_number, :overview)
  end
end

module UsersHelper

  def  current_supervisor?
    if @user.supervisor_id == current_user.id
      true
    else
      false
    end
  end
end

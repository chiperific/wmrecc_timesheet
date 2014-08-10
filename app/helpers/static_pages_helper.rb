module StaticPagesHelper
  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.digest(remember_token))
    self.current_user = user    
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    remember_token = User.digest(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  def sign_out
    current_user.update_attribute(:remember_token, User.digest(User.new_remember_token))
    cookies.delete(:remember_token)
    self.current_user = nil
  end

  def link_to_add_weekday(f)
    new_weekday = Weekday.new
    id = new_weekday.object_id
    fields = f.fields_for(:weekdays, new_weekday, child_index: id) do |w_f|
      render "weekdays_form", w_f: w_f
    end
    link_to("Add weekday", "#", class: "btn btn-success add_day", data: { id: id, fields: fields.gsub("\n", "")})
  end
    
end

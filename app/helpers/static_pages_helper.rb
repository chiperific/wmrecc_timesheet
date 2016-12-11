module StaticPagesHelper

  ############## sign_in methods
  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.digest(remember_token))
    self.current_user = user
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    remember_token = User.digest(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    current_user.update_attribute(:remember_token, User.digest(User.new_remember_token))
    cookies.delete(:remember_token)
    self.current_user = nil
  end

  ############## app_default methods
  def link_to_add_holiday(f)
    new_holiday = Holiday.new
    id = new_holiday.object_id
    fields = f.fields_for(:holidays, new_holiday, child_index: id ) do |h_f|
      render "holidays_form", h_f: h_f
    end
    link_to("Add holiday", "#", class: "btn btn-success add_holiday", data: { id: id, fields: fields.gsub("\n", "")})
  end

  def link_to_add_grant(f)
    new_grant = Grant.new
    id = new_grant.object_id
    fields = f.fields_for(:grants, new_grant, child_index: id) do |g_f|
      render "grants_config_form", g_f: g_f
    end
    link_to("Add grant", "#", class: "btn btn-success add_grant", data: { id: id, fields: fields.gsub("\n", "")})
  end

  # for payroll action
  def departments_lkup
    active_depts = Department.where(active: true)

    if active_depts.count > 1
      depts = ["All Depts"]
      active_depts.each do |d|
        depts << d.name
      end
    else
      depts = [active_depts.first.name]
    end
    depts
  end

  def payroll_relevant_users(start_date, end_date)
    # only users with either an hourly or salary rate
    if !params[:dept].blank?
      dept = Department.where(active: true).where(name: params[:dept]).first
      usr_ary = User.where(department_id: dept).where.has { (salary_rate > 0) | (hourly_rate > 0) }
    else
      usr_ary = User.where.has { (salary_rate > 0) | (hourly_rate > 0) }
    end
    # only users active in the payroll period: usr.start_date < end_date && usr.end_date > start_date
    result = []
    usr_ary.each do |usr|
      if usr.start_date < end_date
        if usr.end_date.blank?
          result << usr
        else
          if usr.end_date > start_date
            result << usr
          end
        end
      end
    end
    result
  end

  def payroll_active_cats
    if !params[:dept].nil? && params[:dept] != "All Depts"
      dept_name = params[:dept]
      dept = Department.find_by_name(dept_name)
      cats = Category.where active: true, department_id: dept.id
    else
      cats = Category.where(active: true)
    end
    cats
  end

  def payroll_active_grants(start_date, end_date)
    ts = Timesheet.where.has { |timesheet| (timesheet.start_date <= end_date) & (timesheet.end_date >= start_date) }

    results = []

    if ts.any?
      ts.each do |t|
        if t.grants.any?
          t.grants.each do |g|
            results << g
          end
        end
      end
    end
    results
  end


end

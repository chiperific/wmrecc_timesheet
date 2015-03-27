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

  def link_to_add_weekday(f)
    new_weekday = Weekday.new
    id = new_weekday.object_id
    fields = f.fields_for(:weekdays, new_weekday, child_index: id) do |w_f|
      render "weekdays_form", w_f: w_f
    end
    link_to("Add weekday", "#", class: "btn btn-success add_day", data: { id: id, fields: fields.gsub("\n", "")})
  end

  def link_to_add_holiday(f)
    new_holiday = Holiday.new
    id = new_holiday.object_id
    fields = f.fields_for(:holidays, new_holiday, child_index: id ) do |h_f|
      render "holidays_form", h_f: h_f
    end
    
    link_to("Add holiday", "#", class: "btn btn-success add_holiday", data: { id: id, fields: fields.gsub("\n", "")})
  end

  ############## payroll methods
  # turn 'mm-dd' and 'yyyy' into a date
  # def date_from_period_year(period, year)
  #   m_d = period.split('-')
  #   m = m_d[0].to_i
  #   d = m_d[1].to_i
  #   year_i = year.to_i
  #   date = Date.new(year_i,m,d)
  # end

  # def payroll_start
  #   pay_period_type = PayPeriod.first.period_type
  #   year = params[:year] || Date.today.year.to_s
  #   pay_period = params[:pay_period] || Time.now.in_time_zone.strftime("%m-%d")
  #   date = date_from_period_year(pay_period, year)

  #   start_of_fy_name = StartMonth.first.month
  #   start_of_fy_num = Date::MONTHNAMES.index(start_of_fy_name)
  #   period_first = Date.new(year.to_i, start_of_fy_num, 1)

  #   if pay_period_type == "Weekly"
  #     start = date.beginning_of_week
  #   elsif pay_period_type == "Bi-weekly"
  #     if date.cweek.odd?
  #       start = date.beginning_of_week
  #     else
  #       start = (date.beginning_of_week - 1.week)
  #     end
  #   elsif pay_period_type == "Monthly"
  #     start = date.beginning_of_month
  #   elsif pay_period_type == "Semi-monthly"
  #     period_second = (period_first + 6.months)
  #     if date >= period_first
  #       start = period_first
  #     else
  #       start = period_second
  #     end
  #   else # Annually
  #     start = period_first
  #   end
  #   start + 1.day
  # end

  # def payroll_end
  #   pay_period_type = PayPeriod.first.period_type
  #   year = params[:year] || Date.today.year.to_s
  #   pay_period = params[:pay_period] || Time.now.in_time_zone.strftime("%m-%d")
  #   date = date_from_period_year(pay_period, year)

  #   start_of_fy_name = StartMonth.first.month
  #   start_of_fy_num = Date::MONTHNAMES.index(start_of_fy_name)
  #   period_first = Date.new(year.to_i, start_of_fy_num, 1)

  #   if pay_period_type == "Weekly"
  #     ender = date.end_of_week
  #   elsif pay_period_type == "Bi-weekly"
  #     if date.cweek.even?
  #       ender = date.end_of_week
  #     else
  #       ender = (date.end_of_week + 1.week)
  #     end
  #   elsif pay_period_type == "Monthly"
  #     ender = date.end_of_month
  #   elsif pay_period_type == "Semi-monthly"
  #     period_second = (period_first + 6.months)
  #     if date >= period_first
  #       ender = (period_second - 1.day)
  #     else
  #       ender = (period_first - 1.day)
  #     end
  #   else # Annually
  #     ender = period_first - 1.day + 1.year
  #   end
  #   ender + 1.day
  # end

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
      if !params[:dept].blank?
        dept = Department.where(active: true).where(name: params[:dept]).first
        usr_ary = User.where(department_id: dept)
      else
        usr_ary = User.all
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
    
end

class GrantsController < ApplicationController

  def payroll_users
    grant = Grant.find(params[:grant_id])
    payroll_start = params[:payroll_start].gsub("-","/").to_date
    payroll_end = params[:payroll_end].gsub("-","/").to_date
    timesheet_ids = Timesheet.where.has { (start_date <= payroll_end) & (end_date >= payroll_start) }.map { |t| t.id } # thanks baby_squeel!!
    relevant_ts_grants = TimesheetGrant.where(timesheet_id: timesheet_ids, grant_id: grant.id).includes(:timesheet => :user).order('users.lname')
    # ary = []
    raw_ary = []
    relevant_ts_grants.each do |g|
      if g.hours > 0
        # hours = number_with_precision(g.hours.round(2), precision: 2)
        # rate = number_to_currency(g.timesheet.user.payroll_hourly_rate(payroll_start))
        # subttl = number_to_currency(g.hours.to_f * g.timesheet.user.payroll_hourly_rate(payroll_start).to_f)
        # ary << { "staff"=> g.timesheet.user.full_name, "hours"=>hours, "rate"=> rate, "subttl"=> subttl }
        raw_ary << { user_id: g.timesheet.user.id, staff: g.timesheet.user.full_name, hours: g.hours.to_f, rate: g.timesheet.user.payroll_hourly_rate(payroll_start).to_f, subttl: g.hours.to_f * g.timesheet.user.payroll_hourly_rate(payroll_start).to_f }
      end
    end

    ary = raw_ary.group_by { |item| item.values_at(:user_id) }.map do |user_id, properties|
      hours = properties.map { |p| p[:hours] }
      ttlhours = hours.all? ? hours.sum : nil
      hour = number_with_precision(ttlhours.round(2), precision: 2)

      rates = properties.map { |p| p[:rate] }
      ttlrates = rates.all? ? rates.sum : nil
      rate = number_to_currency(ttlrates)

      subttls = properties.map { |p| p[:subttl] }
      ttlsubttls = subttls.all? ? subttls.sum : nil
      subttl = number_to_currency(ttlsubttls)

      { staff: properties.first[:staff], hours: hour, rate: rate, subttl: subttl }
    end

    render text: ary.to_json
  end
end

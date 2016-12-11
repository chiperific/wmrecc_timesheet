class GrantsController < ApplicationController

  def payroll_users
    grant = Grant.find(params[:grant_id])
    payroll_start = params[:payroll_start].gsub("-","/").to_date
    payroll_end = params[:payroll_end].gsub("-","/").to_date
    timesheet_ids = Timesheet.where.has { (start_date <= payroll_end) & (end_date >= payroll_start) }.map { |t| t.id } # thanks baby_squeel!!
    relevant_ts_grants = TimesheetGrant.where(timesheet_id: timesheet_ids, grant_id: grant.id).includes(:timesheet => :user).order('users.lname')
    ary = []
    relevant_ts_grants.each do |g|
      if g.hours > 0
        hours = number_with_precision(g.hours.round(2), precision: 2)
        rate = number_to_currency(g.timesheet.user.payroll_hourly_rate(payroll_start))
        subttl = number_to_currency(g.hours.to_f * g.timesheet.user.payroll_hourly_rate(payroll_start).to_f)
        ary << { "staff"=> g.timesheet.user.full_name, "hours"=>hours, "rate"=> rate, "subttl"=> subttl }
      end
    end
    render text: ary.to_json
  end
end

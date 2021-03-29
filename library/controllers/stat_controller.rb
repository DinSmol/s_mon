class StatController < ApplicationController

  def get
    raise 'Check params address' unless address = @params['address']

    address = @params['address']
    from = @params['from'] || Time.now - 1.hour
    to = @params['to'] || Time.now

    query = "SELECT MIN(sd.min), AVG(sd.avg), MAX(sd.max), PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY sd.avg) as median_score,
STDDEV(sd.avg) as st_avg, COUNT(sd.address) as cnt, (COUNT(CASE WHEN sd.loss = 100 THEN 1 END)/COUNT(sd.address))*100 as loss
FROM stat_data sd WHERE sd.address='#{address}' AND (sd.created_at BETWEEN '#{from}' AND '#{to}' AND sd.avg IS NOT NULL)"
    begin
      data = StatObject.sql_exec(query).to_a
    rescue ActiveRecord::StatementInvalid
      data = []
    end

    data.length > 0 ? data.first : (raise 'No valid data in db')
  end
end

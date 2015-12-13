class ChartsController < ApplicationController

  before_filter :get_date
  before_filter :chart_options
  # before_filter :google_chart_init

  def chart_by_learn
    @chart = learn_and_add_report_chart
    @tag_chart = tag_usage_report_chart
  end

  private

    def get_date
      start_date = params[:start_date] || Date.today
      @days = params[:days] ? params[:days] : 30
      @date = start_date - @days
    end

    def google_visular_init_table(table_fields)
      data_table = GoogleVisualr::DataTable.new
      table_fields.each do |field|
        data_table.new_column(field[0], field[1])
      end
      data_table
    end

    def learn_and_add_report_chart
      data_table = google_visular_init_table([ ['date', 'Day'], ['number', 'Learn Count'], ['number', 'Add Count'] ])
      @chart_by_learn = current_user.user_learn_count_till(@date)
      @total_links = current_user.links_till(@date)
      all = ((Date.today-30)..Date.today).inject([]) do |all, date |
        learn_count = @chart_by_learn[date] || 0
        link_count = @total_links[date] || 0
        all << [date, learn_count, link_count ]
      end
      data_table.add_rows(all)
      GoogleVisualr::Interactive::LineChart.new(data_table, @chart_options)
    end

    def tag_usage_report_chart
      tags_question_data = google_visular_init_table([['string', 'Tag'], ['number', 'Tag Count']])
      @tags = ActsAsTaggableOn::Tag.all
      tags_usage_data = @tags.map{|tag|[ tag.name, current_user.links.tagged_with(tag).count]}
      tags_question_data.add_rows(tags_usage_data.sort {|a,b| a[1] <=> b[1]}.reverse.first(10))
      GoogleVisualr::Interactive::PieChart.new(tags_question_data, @chart_options)
    end

    def chart_options
      @chart_options = { width: 450, height: 400, title: '', legend: 'bottom' }
    end

end

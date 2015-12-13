class AddColumnLearnTimesCountToLinks < ActiveRecord::Migration
  def change
    add_column :links, :learn_times_count, :integer, default: 0
    Link.all.each do |link|
      link.update_column(:learn_times_count, link.learn_time.count) unless link.learn_time.empty?
    end
  end
end

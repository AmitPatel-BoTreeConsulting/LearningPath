class AddColumnLastLearnedAtToLink < ActiveRecord::Migration
  def change
    add_column :links, :last_learned_at, :datetime
    Link.all.each do |link|
      link.update_column(:last_learned_at, link.learn_time.last.created_at) unless link.learn_time.empty?
    end
  end
end

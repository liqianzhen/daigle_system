class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.belongs_to :user, index:true
      t.belongs_to :pen, index:true
      t.datetime "check_in"
      t.timestamps
      t.integer  :pen_pull_num
      t.integer  :pen_dead_num
      t.integer  :pen_feed_check
      t.integer  :pen_water_check
      t.integer  :pen_mud_check
      t.integer  :pen_maintenance_check
    end
  end
end

class AddDigsiteInfoToTickets < ActiveRecord::Migration[7.0]
  def change
    add_column :tickets, :digsite_info, :json
  end
end

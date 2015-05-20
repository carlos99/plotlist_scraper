class RenameNeighborhoodField < ActiveRecord::Migration
  def change
  	rename_column :lands, :neigborhood, :neighborhood
  end
end

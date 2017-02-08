class AddFacultyStatusAndCommitteeStatusToIrbs < ActiveRecord::Migration[5.0]
  def change
    add_column :irbs, :faculty_status, :string, :default => 0
    add_column :irbs, :committee_status, :string, :default => 2
  end
end

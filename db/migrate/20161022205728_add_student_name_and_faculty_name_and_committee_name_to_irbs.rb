class AddStudentNameAndFacultyNameAndCommitteeNameToIrbs < ActiveRecord::Migration[5.0]
  def change
    add_column :irbs, :student_name, :string
    add_column :irbs, :faculty_name, :string
    add_column :irbs, :committee_name, :string
  end
end

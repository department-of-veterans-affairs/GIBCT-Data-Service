class AddSchoolClosuresToInstitutions < ActiveRecord::Migration
  def change
    add_column :institutions, :school_closing, :boolean, default: false
    add_column :institutions, :school_closing_on, :date
    add_column :institutions, :school_closing_message, :string
  end
end

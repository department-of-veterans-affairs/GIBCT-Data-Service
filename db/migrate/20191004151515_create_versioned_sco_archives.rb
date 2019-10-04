class CreateVersionedScoArchives < ActiveRecord::Migration[4.2]
    def up
      safety_assured do
        execute "create table versioned_sco_archives (like versioned_school_certifying_officials
          including defaults
          including constraints
          including indexes
      );"
      end
    end
  
     def down
      drop_table :versioned_sco_archives
    end
  end
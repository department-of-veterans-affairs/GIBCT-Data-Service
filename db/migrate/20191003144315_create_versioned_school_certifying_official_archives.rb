class CreateVersionedSchoolCertifyingOfficialArchive < ActiveRecord::Migration[4.2]
    def up
      safety_assured do
        execute "create table versioned_school_certifying_official_archives (like versioned_school_certifying_officials
          including defaults
          including constraints
          including indexes
      );"
      end
    end
  
    def down
      drop_table :versioned_school_certifying_official_archives
    end
  end
  
class CreateScorecards < ActiveRecord::Migration
  def change
    create_table :scorecards do |t|
      # Used in the building of DataCsv
      t.string :cross, null: false
      t.string :insturl
      t.integer :pred_degree_awarded
      t.integer :locale
      t.integer :undergrad_enrollment
      t.float :retention_all_students_ba
      t.float :retention_all_students_otb
      t.integer :salary_all_students
      t.float :avg_stu_loan_debt
      t.float :repayment_rate_all_students
      t.float :c150_l4_pooled_supp
      t.float :c150_4_pooled_supp
      t.float :graduation_rate_all_students

      # Not used in building DataCsv, but used in exporting source csv
      t.string :ope
      t.string :ope6
      t.string :institution
      t.string :city
      t.string :state
      t.string :npcurl
      t.integer :hcm2
      t.integer :control
      t.integer :hbcu
      t.integer :pbi
      t.integer :annhi
      t.integer :tribal
      t.integer :aanapii
      t.integer :hsi
      t.integer :nanti
      t.integer :menonly
      t.integer :womenonly
      t.integer :relaffil
      t.integer :satvr25
      t.integer :satvr75
      t.integer :satmt25
      t.integer :satmt75
      t.integer :satwr25
      t.integer :satwr75
      t.integer :satvrmid
      t.integer :satmtmid
      t.integer :satwrmid
      t.integer :actcm25
      t.integer :actcm75
      t.integer :acten25
      t.integer :acten75
      t.integer :actmt25
      t.integer :actmt75
      t.integer :actwr25
      t.integer :actwr75
      t.integer :actcmmid
      t.integer :actenmid
      t.integer :actmtmid
      t.integer :actwrmid
      t.integer :sat_avg
      t.integer :sat_avg_all
      t.float :pcip01
      t.float :pcip03
      t.float :pcip04
      t.float :pcip05
      t.float :pcip09
      t.float :pcip10
      t.float :pcip11
      t.float :pcip12
      t.float :pcip13
      t.float :pcip14
      t.float :pcip15
      t.float :pcip16
      t.float :pcip19
      t.float :pcip22
      t.float :pcip23
      t.float :pcip24
      t.float :pcip25
      t.float :pcip26
      t.float :pcip27
      t.float :pcip29
      t.float :pcip30
      t.float :pcip31
      t.float :pcip38
      t.float :pcip39
      t.float :pcip40
      t.float :pcip41
      t.float :pcip42
      t.float :pcip43
      t.float :pcip44
      t.float :pcip45
      t.float :pcip46
      t.float :pcip47
      t.float :pcip48
      t.float :pcip49
      t.float :pcip50
      t.float :pcip51
      t.float :pcip52
      t.float :pcip54
      t.integer :distanceonly
      t.float :ugds_white
      t.float :ugds_black
      t.float :ugds_hisp
      t.float :ugds_asian
      t.float :ugds_aian
      t.float :ugds_nhpi
      t.float :ugds_2mor
      t.float :ugds_nra
      t.float :ugds_unkn
      t.float :pptug_ef
      t.integer :curroper
      t.integer :npt4_pub
      t.integer :npt4_priv
      t.integer :npt41_pub
      t.integer :npt42_pub
      t.integer :npt43_pub
      t.integer :npt44_pub
      t.integer :npt45_pub
      t.integer :npt41_priv
      t.integer :npt42_priv
      t.integer :npt43_priv
      t.integer :npt44_priv
      t.integer :npt45_priv
      t.float :pctpell
      t.float :ret_pt4
      t.float :ret_ptl4
      t.float :pctfloan
      t.float :ug25abv
      t.float :gt_25k_p6
      t.float :grad_debt_mdn10yr_supp

      t.timestamps null: false

      t.index :cross, unique: true
      t.index :ope, unique: true
    end
  end
end

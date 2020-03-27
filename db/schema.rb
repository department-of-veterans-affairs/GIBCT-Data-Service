# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_03_27_142848) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_trgm"
  enable_extension "plpgsql"

  create_table "accreditation_actions", id: :serial, force: :cascade do |t|
    t.integer "dapip_id"
    t.integer "agency_id"
    t.string "agency_name"
    t.integer "program_id"
    t.string "program_name"
    t.integer "sequential_id"
    t.string "action_description"
    t.date "action_date"
    t.string "justification_description"
    t.string "justification_other"
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dapip_id"], name: "index_accreditation_actions_on_dapip_id"
  end

  create_table "accreditation_institute_campuses", id: :serial, force: :cascade do |t|
    t.integer "dapip_id"
    t.string "ope"
    t.string "ope6"
    t.string "location_name"
    t.string "parent_name"
    t.integer "parent_dapip_id"
    t.string "location_type"
    t.string "address"
    t.string "general_phone"
    t.string "admin_name"
    t.string "admin_phone"
    t.string "admin_email"
    t.string "fax"
    t.date "update_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dapip_id"], name: "index_accreditation_institute_campuses_on_dapip_id"
    t.index ["ope"], name: "index_accreditation_institute_campuses_on_ope"
    t.index ["ope6"], name: "index_accreditation_institute_campuses_on_ope6"
  end

  create_table "accreditation_records", id: :serial, force: :cascade do |t|
    t.integer "dapip_id"
    t.integer "agency_id"
    t.string "agency_name"
    t.integer "program_id"
    t.string "program_name"
    t.integer "sequential_id"
    t.string "initial_date_flag"
    t.date "accreditation_date"
    t.string "accreditation_status"
    t.date "review_date"
    t.string "department_description"
    t.date "accreditation_end_date"
    t.integer "ending_action_id"
    t.string "accreditation_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dapip_id"], name: "index_accreditation_records_on_dapip_id"
  end

  create_table "arf_gi_bills", id: :serial, force: :cascade do |t|
    t.string "facility_code", null: false
    t.integer "gibill"
    t.integer "total_paid"
    t.string "institution"
    t.integer "station"
    t.integer "count_of_adv_pay_students"
    t.integer "count_of_reg_students"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["facility_code"], name: "index_arf_gi_bills_on_facility_code", unique: true
  end

  create_table "calculator_constants", id: :serial, force: :cascade do |t|
    t.string "name"
    t.float "float_value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
    t.index ["name"], name: "index_calculator_constants_on_name"
  end

  create_table "caution_flag_rules", force: :cascade do |t|
    t.integer "rule_id"
    t.string "title"
    t.string "description"
    t.string "link_text"
    t.string "link_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "caution_flags", force: :cascade do |t|
    t.integer "institution_id"
    t.integer "version_id"
    t.string "source"
    t.string "reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.string "description"
    t.string "link_text"
    t.string "link_url"
  end

  create_table "complaints", id: :serial, force: :cascade do |t|
    t.string "status"
    t.string "ope"
    t.string "ope6"
    t.string "facility_code"
    t.string "closed_reason"
    t.string "issues"
    t.integer "cfc", default: 0
    t.integer "cfbfc", default: 0
    t.integer "cqbfc", default: 0
    t.integer "crbfc", default: 0
    t.integer "cmbfc", default: 0
    t.integer "cabfc", default: 0
    t.integer "cdrbfc", default: 0
    t.integer "cslbfc", default: 0
    t.integer "cgbfc", default: 0
    t.integer "cctbfc", default: 0
    t.integer "cjbfc", default: 0
    t.integer "ctbfc", default: 0
    t.integer "cobfc", default: 0
    t.string "case_id"
    t.string "level"
    t.string "case_owner"
    t.string "institution"
    t.string "city"
    t.string "state"
    t.string "submitted"
    t.string "closed"
    t.string "education_benefits"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["facility_code"], name: "index_complaints_on_facility_code"
    t.index ["ope6"], name: "index_complaints_on_ope6"
  end

  create_table "crosswalk_issues", force: :cascade do |t|
    t.bigint "weam_id"
    t.bigint "crosswalk_id"
    t.bigint "ipeds_hd_id"
    t.string "issue_type"
    t.index ["crosswalk_id"], name: "index_crosswalk_issues_on_crosswalk_id"
    t.index ["ipeds_hd_id"], name: "index_crosswalk_issues_on_ipeds_hd_id"
    t.index ["weam_id"], name: "index_crosswalk_issues_on_weam_id"
  end

  create_table "crosswalks", id: :serial, force: :cascade do |t|
    t.string "facility_code", null: false
    t.string "cross"
    t.string "ope"
    t.string "ope6"
    t.string "city"
    t.string "state"
    t.string "institution"
    t.string "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cross"], name: "index_crosswalks_on_cross"
    t.index ["facility_code"], name: "index_crosswalks_on_facility_code", unique: true
    t.index ["institution"], name: "index_crosswalks_on_institution"
    t.index ["ope"], name: "index_crosswalks_on_ope"
    t.index ["ope6"], name: "index_crosswalks_on_ope6"
  end

  create_table "edu_programs", id: :serial, force: :cascade do |t|
    t.string "facility_code"
    t.string "institution_name"
    t.string "school_locale"
    t.string "provider_website"
    t.string "provider_email_address"
    t.string "phone_area_code"
    t.string "phone_number"
    t.string "student_vet_group"
    t.string "student_vet_group_website"
    t.string "vet_success_name"
    t.string "vet_success_email"
    t.string "vet_tec_program"
    t.integer "tuition_amount"
    t.integer "length_in_weeks"
    t.index ["facility_code", "vet_tec_program"], name: "index_edu_programs_on_facility_code_and_vet_tec_program"
  end

  create_table "eight_keys", id: :serial, force: :cascade do |t|
    t.string "cross"
    t.string "institution"
    t.string "city"
    t.string "state"
    t.string "ope"
    t.string "ope6"
    t.string "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cross"], name: "index_eight_keys_on_cross"
    t.index ["institution"], name: "index_eight_keys_on_institution"
    t.index ["ope"], name: "index_eight_keys_on_ope"
    t.index ["ope6"], name: "index_eight_keys_on_ope6"
  end

  create_table "hcms", id: :serial, force: :cascade do |t|
    t.string "ope", null: false
    t.string "ope6", null: false
    t.string "institution"
    t.string "city"
    t.string "state"
    t.string "country"
    t.string "institution_type"
    t.string "hcm_type"
    t.string "hcm_reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ope"], name: "index_hcms_on_ope"
    t.index ["ope6"], name: "index_hcms_on_ope6"
  end

  create_table "ignored_crosswalk_issues", force: :cascade do |t|
    t.string "facility_code"
    t.string "cross"
    t.string "ope"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "institution_programs", id: :serial, force: :cascade do |t|
    t.string "facility_code"
    t.string "program_type"
    t.string "description", null: false
    t.string "full_time_undergraduate"
    t.string "graduate"
    t.string "full_time_modifier"
    t.string "length_in_hours"
    t.integer "version"
    t.string "school_locale"
    t.string "provider_website"
    t.string "provider_email_address"
    t.string "phone_area_code"
    t.string "phone_number"
    t.string "student_vet_group"
    t.string "student_vet_group_website"
    t.string "vet_success_name"
    t.string "vet_success_email"
    t.string "vet_tec_program"
    t.integer "tuition_amount"
    t.integer "length_in_weeks"
    t.integer "institution_id"
    t.index ["description", "version"], name: "index_institution_programs"
    t.index ["institution_id"], name: "index_institution_programs_on_institution_id"
  end

  create_table "institution_programs_archives", id: :integer, default: -> { "nextval('institution_programs_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "facility_code"
    t.string "program_type"
    t.string "description", null: false
    t.string "full_time_undergraduate"
    t.string "graduate"
    t.string "full_time_modifier"
    t.string "length_in_hours"
    t.integer "version"
    t.string "school_locale"
    t.string "provider_website"
    t.string "provider_email_address"
    t.string "phone_area_code"
    t.string "phone_number"
    t.string "student_vet_group"
    t.string "student_vet_group_website"
    t.string "vet_success_name"
    t.string "vet_success_email"
    t.string "vet_tec_program"
    t.integer "tuition_amount"
    t.integer "length_in_weeks"
    t.integer "institution_id"
    t.index ["description", "version"], name: "index_institution_programs_archives"
    t.index ["institution_id"], name: "index_institution_programs_archives_on_institution_id"
  end

  create_table "institutions", id: :serial, force: :cascade do |t|
    t.integer "version"
    t.string "institution_type_name"
    t.string "facility_code"
    t.string "institution"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "country"
    t.boolean "flight"
    t.boolean "correspondence"
    t.float "bah"
    t.string "cross"
    t.string "ope"
    t.string "ope6"
    t.string "insturl"
    t.string "vet_tuition_policy_url"
    t.integer "pred_degree_awarded"
    t.integer "locale"
    t.integer "gibill"
    t.integer "undergrad_enrollment"
    t.boolean "yr"
    t.boolean "student_veteran"
    t.string "student_veteran_link"
    t.boolean "poe"
    t.boolean "eight_keys"
    t.boolean "dodmou"
    t.boolean "sec_702"
    t.string "vetsuccess_name"
    t.string "vetsuccess_email"
    t.boolean "credit_for_mil_training"
    t.boolean "vet_poc"
    t.boolean "student_vet_grp_ipeds"
    t.boolean "soc_member"
    t.string "va_highest_degree_offered"
    t.float "retention_rate_veteran_ba"
    t.float "retention_all_students_ba"
    t.float "retention_rate_veteran_otb"
    t.float "retention_all_students_otb"
    t.float "persistance_rate_veteran_ba"
    t.float "persistance_rate_veteran_otb"
    t.float "graduation_rate_veteran"
    t.float "graduation_rate_all_students"
    t.float "transfer_out_rate_veteran"
    t.float "transfer_out_rate_all_students"
    t.float "salary_all_students"
    t.float "repayment_rate_all_students"
    t.float "avg_stu_loan_debt"
    t.string "calendar"
    t.integer "tuition_in_state"
    t.integer "tuition_out_of_state"
    t.integer "books"
    t.boolean "online_all"
    t.float "p911_tuition_fees"
    t.integer "p911_recipients"
    t.float "p911_yellow_ribbon"
    t.integer "p911_yr_recipients"
    t.boolean "accredited"
    t.string "accreditation_type"
    t.string "accreditation_status"
    t.boolean "caution_flag"
    t.string "caution_flag_reason"
    t.integer "complaints_facility_code"
    t.integer "complaints_financial_by_fac_code"
    t.integer "complaints_quality_by_fac_code"
    t.integer "complaints_refund_by_fac_code"
    t.integer "complaints_marketing_by_fac_code"
    t.integer "complaints_accreditation_by_fac_code"
    t.integer "complaints_degree_requirements_by_fac_code"
    t.integer "complaints_student_loans_by_fac_code"
    t.integer "complaints_grades_by_fac_code"
    t.integer "complaints_credit_transfer_by_fac_code"
    t.integer "complaints_credit_job_by_fac_code"
    t.integer "complaints_job_by_fac_code"
    t.integer "complaints_transcript_by_fac_code"
    t.integer "complaints_other_by_fac_code"
    t.integer "complaints_main_campus_roll_up"
    t.integer "complaints_financial_by_ope_id_do_not_sum"
    t.integer "complaints_quality_by_ope_id_do_not_sum"
    t.integer "complaints_refund_by_ope_id_do_not_sum"
    t.integer "complaints_marketing_by_ope_id_do_not_sum"
    t.integer "complaints_accreditation_by_ope_id_do_not_sum"
    t.integer "complaints_degree_requirements_by_ope_id_do_not_sum"
    t.integer "complaints_student_loans_by_ope_id_do_not_sum"
    t.integer "complaints_grades_by_ope_id_do_not_sum"
    t.integer "complaints_credit_transfer_by_ope_id_do_not_sum"
    t.integer "complaints_jobs_by_ope_id_do_not_sum"
    t.integer "complaints_transcript_by_ope_id_do_not_sum"
    t.integer "complaints_other_by_ope_id_do_not_sum"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "f1sysnam"
    t.integer "f1syscod"
    t.string "ialias"
    t.string "approval_status"
    t.boolean "school_closing", default: false
    t.date "school_closing_on"
    t.string "school_closing_message"
    t.boolean "stem_offered", default: false
    t.boolean "priority_enrollment"
    t.boolean "online_only"
    t.boolean "independent_study"
    t.boolean "distance_learning"
    t.string "address_1"
    t.string "address_2"
    t.string "address_3"
    t.string "physical_address_1"
    t.string "physical_address_2"
    t.string "physical_address_3"
    t.string "physical_city"
    t.string "physical_state"
    t.string "physical_zip"
    t.string "physical_country"
    t.integer "dod_bah"
    t.boolean "approved", default: false
    t.boolean "vet_tec_provider", default: false
    t.boolean "closure109"
    t.boolean "preferred_provider", default: false
    t.boolean "stem_indicator", default: false
    t.string "campus_type"
    t.string "parent_facility_code_id"
    t.bigint "version_id"
    t.boolean "complies_with_sec_103"
    t.boolean "solely_requires_coe"
    t.boolean "requires_coe_and_criteria"
    t.index "lower((address_1)::text) gin_trgm_ops", name: "index_institutions_on_address_1", using: :gin
    t.index "lower((address_2)::text) gin_trgm_ops", name: "index_institutions_on_address_2", using: :gin
    t.index "lower((address_3)::text) gin_trgm_ops", name: "index_institutions_on_address_3", using: :gin
    t.index ["city"], name: "index_institutions_on_city", opclass: :gin_trgm_ops, using: :gin
    t.index ["country"], name: "index_institutions_on_country"
    t.index ["cross"], name: "index_institutions_on_cross"
    t.index ["distance_learning"], name: "index_institutions_on_distance_learning"
    t.index ["facility_code"], name: "index_institutions_on_facility_code"
    t.index ["institution"], name: "index_institutions_on_institution", opclass: :gin_trgm_ops, using: :gin
    t.index ["institution_type_name"], name: "index_institutions_on_institution_type_name"
    t.index ["online_only"], name: "index_institutions_on_online_only"
    t.index ["ope"], name: "index_institutions_on_ope"
    t.index ["ope6"], name: "index_institutions_on_ope6"
    t.index ["parent_facility_code_id"], name: "index_institutions_on_parent_facility_code_id"
    t.index ["state"], name: "index_institutions_on_state"
    t.index ["stem_offered"], name: "index_institutions_on_stem_offered"
    t.index ["version", "parent_facility_code_id"], name: "index_institutions_on_version_and_parent_facility_code_id"
    t.index ["version"], name: "index_institutions_on_version"
    t.index ["version_id"], name: "index_institutions_on_version_id"
  end

  create_table "institutions_archives", id: :integer, default: -> { "nextval('institutions_id_seq'::regclass)" }, force: :cascade do |t|
    t.integer "version"
    t.string "institution_type_name"
    t.string "facility_code"
    t.string "institution"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "country"
    t.boolean "flight"
    t.boolean "correspondence"
    t.float "bah"
    t.string "cross"
    t.string "ope"
    t.string "ope6"
    t.string "insturl"
    t.string "vet_tuition_policy_url"
    t.integer "pred_degree_awarded"
    t.integer "locale"
    t.integer "gibill"
    t.integer "undergrad_enrollment"
    t.boolean "yr"
    t.boolean "student_veteran"
    t.string "student_veteran_link"
    t.boolean "poe"
    t.boolean "eight_keys"
    t.boolean "dodmou"
    t.boolean "sec_702"
    t.string "vetsuccess_name"
    t.string "vetsuccess_email"
    t.boolean "credit_for_mil_training"
    t.boolean "vet_poc"
    t.boolean "student_vet_grp_ipeds"
    t.boolean "soc_member"
    t.string "va_highest_degree_offered"
    t.float "retention_rate_veteran_ba"
    t.float "retention_all_students_ba"
    t.float "retention_rate_veteran_otb"
    t.float "retention_all_students_otb"
    t.float "persistance_rate_veteran_ba"
    t.float "persistance_rate_veteran_otb"
    t.float "graduation_rate_veteran"
    t.float "graduation_rate_all_students"
    t.float "transfer_out_rate_veteran"
    t.float "transfer_out_rate_all_students"
    t.float "salary_all_students"
    t.float "repayment_rate_all_students"
    t.float "avg_stu_loan_debt"
    t.string "calendar"
    t.integer "tuition_in_state"
    t.integer "tuition_out_of_state"
    t.integer "books"
    t.boolean "online_all"
    t.float "p911_tuition_fees"
    t.integer "p911_recipients"
    t.float "p911_yellow_ribbon"
    t.integer "p911_yr_recipients"
    t.boolean "accredited"
    t.string "accreditation_type"
    t.string "accreditation_status"
    t.boolean "caution_flag"
    t.string "caution_flag_reason"
    t.integer "complaints_facility_code"
    t.integer "complaints_financial_by_fac_code"
    t.integer "complaints_quality_by_fac_code"
    t.integer "complaints_refund_by_fac_code"
    t.integer "complaints_marketing_by_fac_code"
    t.integer "complaints_accreditation_by_fac_code"
    t.integer "complaints_degree_requirements_by_fac_code"
    t.integer "complaints_student_loans_by_fac_code"
    t.integer "complaints_grades_by_fac_code"
    t.integer "complaints_credit_transfer_by_fac_code"
    t.integer "complaints_credit_job_by_fac_code"
    t.integer "complaints_job_by_fac_code"
    t.integer "complaints_transcript_by_fac_code"
    t.integer "complaints_other_by_fac_code"
    t.integer "complaints_main_campus_roll_up"
    t.integer "complaints_financial_by_ope_id_do_not_sum"
    t.integer "complaints_quality_by_ope_id_do_not_sum"
    t.integer "complaints_refund_by_ope_id_do_not_sum"
    t.integer "complaints_marketing_by_ope_id_do_not_sum"
    t.integer "complaints_accreditation_by_ope_id_do_not_sum"
    t.integer "complaints_degree_requirements_by_ope_id_do_not_sum"
    t.integer "complaints_student_loans_by_ope_id_do_not_sum"
    t.integer "complaints_grades_by_ope_id_do_not_sum"
    t.integer "complaints_credit_transfer_by_ope_id_do_not_sum"
    t.integer "complaints_jobs_by_ope_id_do_not_sum"
    t.integer "complaints_transcript_by_ope_id_do_not_sum"
    t.integer "complaints_other_by_ope_id_do_not_sum"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "f1sysnam"
    t.integer "f1syscod"
    t.string "ialias"
    t.string "approval_status"
    t.boolean "school_closing", default: false
    t.date "school_closing_on"
    t.string "school_closing_message"
    t.boolean "stem_offered", default: false
    t.boolean "priority_enrollment"
    t.boolean "online_only"
    t.boolean "independent_study"
    t.boolean "distance_learning"
    t.string "address_1"
    t.string "address_2"
    t.string "address_3"
    t.string "physical_address_1"
    t.string "physical_address_2"
    t.string "physical_address_3"
    t.string "physical_city"
    t.string "physical_state"
    t.string "physical_zip"
    t.string "physical_country"
    t.integer "dod_bah"
    t.boolean "approved", default: false
    t.boolean "vet_tec_provider", default: false
    t.boolean "closure109"
    t.boolean "preferred_provider", default: false
    t.boolean "stem_indicator", default: false
    t.string "campus_type"
    t.string "parent_facility_code_id"
    t.bigint "version_id"
    t.boolean "complies_with_sec_103"
    t.boolean "solely_requires_coe"
    t.boolean "requires_coe_and_criteria"
  end

  create_table "ipeds_cip_codes", id: :serial, force: :cascade do |t|
    t.string "cross", null: false
    t.string "cipcode"
    t.integer "ctotalt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cipcode"], name: "index_ipeds_cip_codes_on_cipcode"
    t.index ["cross"], name: "index_ipeds_cip_codes_on_cross"
    t.index ["ctotalt"], name: "index_ipeds_cip_codes_on_ctotalt"
  end

  create_table "ipeds_hds", id: :serial, force: :cascade do |t|
    t.string "cross", null: false
    t.string "vet_tuition_policy_url"
    t.string "institution"
    t.string "addr"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.integer "fips"
    t.integer "obereg"
    t.string "chfnm"
    t.string "chftitle"
    t.string "gentele"
    t.string "ein"
    t.string "ope"
    t.integer "opeflag"
    t.string "webaddr"
    t.string "adminurl"
    t.string "faidurl"
    t.string "applurl"
    t.string "npricurl"
    t.string "athurl"
    t.integer "sector"
    t.integer "iclevel"
    t.integer "control"
    t.integer "hloffer"
    t.integer "ugoffer"
    t.integer "groffer"
    t.integer "hdegofr1"
    t.integer "deggrant"
    t.integer "hbcu"
    t.integer "hospital"
    t.integer "medical"
    t.integer "tribal"
    t.integer "locale"
    t.integer "openpubl"
    t.string "act"
    t.integer "newid"
    t.integer "deathyr"
    t.string "closedat"
    t.integer "cyactive"
    t.integer "postsec"
    t.integer "pseflag"
    t.integer "pset4flg"
    t.integer "rptmth"
    t.string "ialias"
    t.integer "instcat"
    t.integer "ccbasic"
    t.integer "ccipug"
    t.integer "ccipgrad"
    t.integer "ccugprof"
    t.integer "ccenrprf"
    t.integer "ccsizset"
    t.integer "carnegie"
    t.integer "landgrnt"
    t.integer "instsize"
    t.integer "cbsa"
    t.integer "cbsatype"
    t.integer "csa"
    t.integer "necta"
    t.integer "f1systyp"
    t.string "f1sysnam"
    t.integer "f1syscod"
    t.integer "countycd"
    t.string "countynm"
    t.integer "cngdstcd"
    t.float "longitud"
    t.float "latitude"
    t.integer "dfrcgid"
    t.integer "dfrcuscg"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cross"], name: "index_ipeds_hds_on_cross"
    t.index ["institution"], name: "index_ipeds_hds_on_institution"
    t.index ["ope"], name: "index_ipeds_hds_on_ope"
  end

  create_table "ipeds_ic_ays", id: :serial, force: :cascade do |t|
    t.string "cross", null: false
    t.integer "tuition_in_state"
    t.integer "tuition_out_of_state"
    t.integer "books"
    t.string "xtuit1"
    t.integer "tuition1"
    t.string "xfee1"
    t.integer "fee1"
    t.string "xhrchg1"
    t.integer "hrchg1"
    t.string "xtuit2"
    t.integer "tuition2"
    t.string "xfee2"
    t.integer "fee2"
    t.string "xhrchg2"
    t.integer "hrchg2"
    t.string "xtuit3"
    t.integer "tuition3"
    t.string "xfee3"
    t.integer "fee3"
    t.string "xhrchg3"
    t.integer "hrchg3"
    t.string "xtuit5"
    t.integer "tuition5"
    t.string "xfee5"
    t.integer "fee5"
    t.string "xhrchg5"
    t.integer "hrchg5"
    t.string "xtuit6"
    t.integer "tuition6"
    t.string "xfee6"
    t.integer "fee6"
    t.string "xhrchg6"
    t.integer "hrchg6"
    t.string "xtuit7"
    t.integer "tuition7"
    t.string "xfee7"
    t.integer "fee7"
    t.string "xhrchg7"
    t.integer "hrchg7"
    t.string "xispro1"
    t.integer "isprof1"
    t.string "xispfe1"
    t.integer "ispfee1"
    t.string "xospro1"
    t.integer "osprof1"
    t.string "xospfe1"
    t.integer "ospfee1"
    t.string "xispro2"
    t.integer "isprof2"
    t.string "xispfe2"
    t.integer "ispfee2"
    t.string "xospro2"
    t.integer "osprof2"
    t.string "xospfe2"
    t.integer "ospfee2"
    t.string "xispro3"
    t.integer "isprof3"
    t.string "xispfe3"
    t.integer "ispfee3"
    t.string "xospro3"
    t.integer "osprof3"
    t.string "xospfe3"
    t.integer "ospfee3"
    t.string "xispro4"
    t.integer "isprof4"
    t.string "xispfe4"
    t.integer "ispfee4"
    t.string "xospro4"
    t.integer "osprof4"
    t.string "xospfe4"
    t.integer "ospfee4"
    t.string "xispro5"
    t.integer "isprof5"
    t.string "xispfe5"
    t.integer "ispfee5"
    t.string "xospro5"
    t.integer "osprof5"
    t.string "xospfe5"
    t.integer "ospfee5"
    t.string "xispro6"
    t.integer "isprof6"
    t.string "xispfe6"
    t.integer "ispfee6"
    t.string "xospro6"
    t.integer "osprof6"
    t.string "xospfe6"
    t.integer "ospfee6"
    t.string "xispro7"
    t.integer "isprof7"
    t.string "xispfe7"
    t.integer "ispfee7"
    t.string "xospro7"
    t.integer "osprof7"
    t.string "xospfe7"
    t.integer "ospfee7"
    t.string "xispro8"
    t.integer "isprof8"
    t.string "xispfe8"
    t.integer "ispfee8"
    t.string "xospro8"
    t.integer "osprof8"
    t.string "xospfe8"
    t.integer "ospfee8"
    t.string "xispro9"
    t.integer "isprof9"
    t.string "xispfe9"
    t.integer "ispfee9"
    t.string "xospro9"
    t.integer "osprof9"
    t.string "xospfe9"
    t.integer "ospfee9"
    t.string "xchg1at0"
    t.integer "chg1at0"
    t.string "xchg1af0"
    t.integer "chg1af0"
    t.string "xchg1ay0"
    t.integer "chg1ay0"
    t.string "xchg1at1"
    t.integer "chg1at1"
    t.string "xchg1af1"
    t.integer "chg1af1"
    t.string "xchg1ay1"
    t.integer "chg1ay1"
    t.string "xchg1at2"
    t.integer "chg1at2"
    t.string "xchg1af2"
    t.integer "chg1af2"
    t.string "xchg1ay2"
    t.integer "chg1ay2"
    t.string "xchg1at3"
    t.integer "chg1at3"
    t.string "xchg1af3"
    t.integer "chg1af3"
    t.string "xchg1ay3"
    t.integer "chg1ay3"
    t.integer "chg1tgtd"
    t.integer "chg1fgtd"
    t.string "xchg2at0"
    t.integer "chg2at0"
    t.string "xchg2af0"
    t.integer "chg2af0"
    t.string "xchg2ay0"
    t.integer "chg2ay0"
    t.string "xchg2at1"
    t.integer "chg2at1"
    t.string "xchg2af1"
    t.integer "chg2af1"
    t.string "xchg2ay1"
    t.integer "chg2ay1"
    t.string "xchg2at2"
    t.integer "chg2at2"
    t.string "xchg2af2"
    t.integer "chg2af2"
    t.string "xchg2ay2"
    t.integer "chg2ay2"
    t.string "xchg2at3"
    t.integer "chg2at3"
    t.string "xchg2af3"
    t.integer "chg2af3"
    t.string "xchg2ay3"
    t.integer "chg2tgtd"
    t.integer "chg2fgtd"
    t.string "xchg3at0"
    t.integer "chg3at0"
    t.string "xchg3af0"
    t.integer "chg3af0"
    t.string "xchg3ay0"
    t.integer "chg3ay0"
    t.string "xchg3at1"
    t.integer "chg3at1"
    t.string "xchg3af1"
    t.integer "chg3af1"
    t.string "xchg3ay1"
    t.integer "chg3ay1"
    t.string "xchg3at2"
    t.integer "chg3at2"
    t.string "xchg3af2"
    t.integer "chg3af2"
    t.string "xchg3ay2"
    t.integer "chg3ay2"
    t.string "xchg3at3"
    t.integer "chg3at3"
    t.string "xchg3af3"
    t.integer "chg3af3"
    t.string "xchg3ay3"
    t.integer "chg3tgtd"
    t.integer "chg3fgtd"
    t.string "xchg4ay0"
    t.integer "chg4ay0"
    t.string "xchg4ay1"
    t.integer "chg4ay1"
    t.string "xchg4ay2"
    t.integer "chg4ay2"
    t.string "xchg4ay3"
    t.string "xchg5ay0"
    t.integer "chg5ay0"
    t.string "xchg5ay1"
    t.integer "chg5ay1"
    t.string "xchg5ay2"
    t.integer "chg5ay2"
    t.string "xchg5ay3"
    t.integer "chg5ay3"
    t.string "xchg6ay0"
    t.integer "chg6ay0"
    t.string "xchg6ay1"
    t.integer "chg6ay1"
    t.string "xchg6ay2"
    t.integer "chg6ay2"
    t.string "xchg6ay3"
    t.integer "chg6ay3"
    t.string "xchg7ay0"
    t.integer "chg7ay0"
    t.string "xchg7ay1"
    t.integer "chg7ay1"
    t.string "xchg7ay2"
    t.integer "chg7ay2"
    t.string "xchg7ay3"
    t.integer "chg7ay3"
    t.string "xchg8ay0"
    t.integer "chg8ay0"
    t.string "xchg8ay1"
    t.integer "chg8ay1"
    t.string "xchg8ay2"
    t.integer "chg8ay2"
    t.string "xchg8ay3"
    t.integer "chg8ay3"
    t.string "xchg9ay0"
    t.integer "chg9ay0"
    t.string "xchg9ay1"
    t.integer "chg9ay1"
    t.string "xchg9ay2"
    t.integer "chg9ay2"
    t.string "xchg9ay3"
    t.integer "chg9ay3"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cross"], name: "index_ipeds_ic_ays_on_cross"
  end

  create_table "ipeds_ic_pies", id: :serial, force: :cascade do |t|
    t.string "cross", null: false
    t.integer "tuition_in_state"
    t.integer "tuition_out_of_state"
    t.integer "books"
    t.integer "prgmofr"
    t.float "cipcode1"
    t.string "xciptui1"
    t.integer "ciptuit1"
    t.string "xcipsup1"
    t.integer "cipsupp1"
    t.string "xciplgt1"
    t.integer "ciplgth1"
    t.integer "prgmsr1"
    t.string "xmthcmp1"
    t.integer "mthcmp1"
    t.string "xwkcmp1"
    t.integer "wkcmp1"
    t.string "xlnayhr1"
    t.integer "lnayhr1"
    t.string "xlnaywk1"
    t.integer "lnaywk1"
    t.string "xchg1py0"
    t.integer "chg1py0"
    t.string "xchg1py1"
    t.integer "chg1py1"
    t.string "xchg1py2"
    t.integer "chg1py2"
    t.string "xchg1py3"
    t.integer "chg1py3"
    t.string "xchg4py0"
    t.integer "chg4py0"
    t.string "xchg4py1"
    t.integer "chg4py1"
    t.string "xchg4py2"
    t.integer "chg4py2"
    t.string "xchg4py3"
    t.string "xchg5py0"
    t.integer "chg5py0"
    t.string "xchg5py1"
    t.integer "chg5py1"
    t.string "xchg5py2"
    t.integer "chg5py2"
    t.string "xchg5py3"
    t.integer "chg5py3"
    t.string "xchg6py0"
    t.integer "chg6py0"
    t.string "xchg6py1"
    t.integer "chg6py1"
    t.string "xchg6py2"
    t.integer "chg6py2"
    t.string "xchg6py3"
    t.integer "chg6py3"
    t.string "xchg7py0"
    t.integer "chg7py0"
    t.string "xchg7py1"
    t.integer "chg7py1"
    t.string "xchg7py2"
    t.integer "chg7py2"
    t.string "xchg7py3"
    t.integer "chg7py3"
    t.string "xchg8py0"
    t.integer "chg8py0"
    t.string "xchg8py1"
    t.integer "chg8py1"
    t.string "xchg8py2"
    t.integer "chg8py2"
    t.string "xchg8py3"
    t.integer "chg8py3"
    t.string "xchg9py0"
    t.integer "chg9py0"
    t.string "xchg9py1"
    t.integer "chg9py1"
    t.string "xchg9py2"
    t.integer "chg9py2"
    t.string "xchg9py3"
    t.integer "chg9py3"
    t.float "cipcode2"
    t.string "xciptui2"
    t.integer "ciptuit2"
    t.string "xcipsup2"
    t.integer "cipsupp2"
    t.string "xciplgt2"
    t.integer "ciplgth2"
    t.integer "prgmsr2"
    t.string "xmthcmp2"
    t.integer "mthcmp2"
    t.float "cipcode3"
    t.string "xciptui3"
    t.integer "ciptuit3"
    t.string "xcipsup3"
    t.integer "cipsupp3"
    t.string "xciplgt3"
    t.integer "ciplgth3"
    t.integer "prgmsr3"
    t.string "xmthcmp3"
    t.integer "mthcmp3"
    t.float "cipcode4"
    t.string "xciptui4"
    t.integer "ciptuit4"
    t.string "xcipsup4"
    t.integer "cipsupp4"
    t.string "xciplgt4"
    t.integer "ciplgth4"
    t.integer "prgmsr4"
    t.string "xmthcmp4"
    t.integer "mthcmp4"
    t.float "cipcode5"
    t.string "xciptui5"
    t.integer "ciptuit5"
    t.string "xcipsup5"
    t.integer "cipsupp5"
    t.string "xciplgt5"
    t.integer "ciplgth5"
    t.integer "prgmsr5"
    t.string "xmthcmp5"
    t.integer "mthcmp5"
    t.float "cipcode6"
    t.string "xciptui6"
    t.integer "ciptuit6"
    t.string "xcipsup6"
    t.integer "cipsupp6"
    t.string "xciplgt6"
    t.integer "ciplgth6"
    t.integer "prgmsr6"
    t.string "xmthcmp6"
    t.integer "mthcmp6"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cross"], name: "index_ipeds_ic_pies_on_cross"
  end

  create_table "ipeds_ics", id: :serial, force: :cascade do |t|
    t.string "cross", null: false
    t.boolean "credit_for_mil_training"
    t.boolean "vet_poc"
    t.boolean "student_vet_grp_ipeds"
    t.boolean "soc_member"
    t.string "calendar"
    t.boolean "online_all"
    t.integer "calsys", null: false
    t.integer "distnced", null: false
    t.integer "vet2", null: false
    t.integer "vet3", null: false
    t.integer "vet4", null: false
    t.integer "vet5", null: false
    t.integer "peo1istr"
    t.integer "peo2istr"
    t.integer "peo3istr"
    t.integer "peo4istr"
    t.integer "peo5istr"
    t.integer "peo6istr"
    t.integer "cntlaffi"
    t.integer "pubprime"
    t.integer "pubsecon"
    t.integer "relaffil"
    t.integer "level1"
    t.integer "level2"
    t.integer "level3"
    t.integer "level4"
    t.integer "level5"
    t.integer "level6"
    t.integer "level7"
    t.integer "level8"
    t.integer "level12"
    t.integer "level17"
    t.integer "level18"
    t.integer "level19"
    t.integer "openadmp"
    t.integer "credits1"
    t.integer "credits2"
    t.integer "credits3"
    t.integer "credits4"
    t.integer "slo5"
    t.integer "slo51"
    t.integer "slo52"
    t.integer "slo53"
    t.integer "slo6"
    t.integer "slo7"
    t.integer "slo8"
    t.integer "slo81"
    t.integer "slo82"
    t.integer "slo83"
    t.integer "slo9"
    t.integer "yrscoll"
    t.integer "stusrv1"
    t.integer "stusrv2"
    t.integer "stusrv3"
    t.integer "stusrv4"
    t.integer "stusrv8"
    t.integer "stusrv9"
    t.integer "libfac"
    t.integer "athassoc"
    t.integer "assoc1"
    t.integer "assoc2"
    t.integer "assoc3"
    t.integer "assoc4"
    t.integer "assoc5"
    t.integer "assoc6"
    t.integer "sport1"
    t.integer "confno1"
    t.integer "sport2"
    t.integer "confno2"
    t.integer "sport3"
    t.integer "confno3"
    t.integer "sport4"
    t.integer "confno4"
    t.string "xappfeeu"
    t.integer "applfeeu"
    t.string "xappfeeg"
    t.integer "applfeeg"
    t.integer "ft_ug"
    t.integer "ft_ftug"
    t.integer "ftgdnidp"
    t.integer "pt_ug"
    t.integer "pt_ftug"
    t.integer "ptgdnidp"
    t.integer "docpp"
    t.integer "docppsp"
    t.integer "tuitvary"
    t.integer "room"
    t.integer "xroomcap"
    t.integer "roomcap"
    t.integer "board"
    t.string "xmealswk"
    t.integer "mealswk"
    t.string "xroomamt"
    t.integer "roomamt"
    t.string "xbordamt"
    t.integer "boardamt"
    t.string "xrmbdamt"
    t.integer "rmbrdamt"
    t.integer "alloncam"
    t.integer "tuitpl"
    t.integer "tuitpl1"
    t.integer "tuitpl2"
    t.integer "tuitpl3"
    t.integer "tuitpl4"
    t.integer "disab"
    t.string "xdisabpc"
    t.integer "disabpct"
    t.integer "dstnced1"
    t.integer "dstnced2"
    t.integer "dstnced3"
    t.integer "vet1"
    t.integer "vet9"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cross"], name: "index_ipeds_ics_on_cross"
  end

  create_table "mous", id: :serial, force: :cascade do |t|
    t.string "ope", null: false
    t.string "ope6", null: false
    t.string "status"
    t.boolean "dodmou"
    t.boolean "dod_status"
    t.string "institution"
    t.string "trade_name"
    t.string "city"
    t.string "state"
    t.string "institution_type"
    t.string "approval_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ope"], name: "index_mous_on_ope"
    t.index ["ope6"], name: "index_mous_on_ope6"
  end

  create_table "outcomes", id: :serial, force: :cascade do |t|
    t.string "facility_code", null: false
    t.float "retention_rate_veteran_ba"
    t.float "retention_rate_veteran_otb"
    t.float "persistance_rate_veteran_ba"
    t.float "persistance_rate_veteran_otb"
    t.float "graduation_rate_veteran"
    t.float "transfer_out_rate_veteran"
    t.string "institution"
    t.string "school_level_va"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["facility_code"], name: "index_outcomes_on_facility_code", unique: true
  end

  create_table "p911_tfs", id: :serial, force: :cascade do |t|
    t.string "facility_code", null: false
    t.float "p911_tuition_fees", null: false
    t.integer "p911_recipients", null: false
    t.string "institution"
    t.string "state"
    t.string "country"
    t.string "profit_status"
    t.string "type_of_payment"
    t.integer "number_of_payments"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["facility_code"], name: "index_p911_tfs_on_facility_code", unique: true
  end

  create_table "p911_yrs", id: :serial, force: :cascade do |t|
    t.string "facility_code", null: false
    t.float "p911_yellow_ribbon", null: false
    t.integer "p911_yr_recipients", null: false
    t.string "institution"
    t.string "state"
    t.string "country"
    t.string "profit_status"
    t.string "type_of_payment"
    t.integer "number_of_payments"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["facility_code"], name: "index_p911_yrs_on_facility_code", unique: true
  end

  create_table "programs", id: :serial, force: :cascade do |t|
    t.string "facility_code", limit: 8, null: false
    t.string "institution_name", limit: 80, null: false
    t.string "program_type", null: false
    t.string "description", limit: 40
    t.string "full_time_undergraduate", limit: 15
    t.string "graduate", limit: 15
    t.string "full_time_modifier", limit: 1
    t.string "length", limit: 7
    t.integer "csv_row"
    t.index ["facility_code", "description"], name: "index_programs_on_facility_code_and_description"
  end

  create_table "rules", force: :cascade do |t|
    t.string "rule_name", null: false
    t.string "matcher", null: false
    t.string "action", null: false
    t.string "subject"
    t.string "object"
    t.string "predicate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "school_certifying_officials", id: :serial, force: :cascade do |t|
    t.string "facility_code"
    t.string "institution_name"
    t.string "priority"
    t.string "first_name"
    t.string "last_name"
    t.string "title"
    t.string "phone_area_code"
    t.string "phone_number"
    t.string "phone_extension"
    t.string "email"
    t.index ["facility_code"], name: "index_school_certifying_officials_on_facility_code"
  end

  create_table "school_closures", id: :serial, force: :cascade do |t|
    t.string "facility_code", null: false
    t.string "institution_name"
    t.boolean "school_closing"
    t.string "school_closing_date"
    t.date "school_closing_on"
    t.text "school_closing_message"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["facility_code"], name: "index_school_closures_on_facility_code", unique: true
  end

  create_table "scorecards", id: :serial, force: :cascade do |t|
    t.string "cross", null: false
    t.string "insturl"
    t.integer "pred_degree_awarded"
    t.integer "locale"
    t.integer "undergrad_enrollment"
    t.float "retention_all_students_ba"
    t.float "retention_all_students_otb"
    t.integer "salary_all_students"
    t.float "avg_stu_loan_debt"
    t.float "repayment_rate_all_students"
    t.float "c150_l4_pooled_supp"
    t.float "c150_4_pooled_supp"
    t.float "graduation_rate_all_students"
    t.string "ope"
    t.string "ope6"
    t.string "institution"
    t.string "city"
    t.string "state"
    t.string "npcurl"
    t.integer "hcm2"
    t.integer "control"
    t.integer "hbcu"
    t.integer "pbi"
    t.integer "annhi"
    t.integer "tribal"
    t.integer "aanapii"
    t.integer "hsi"
    t.integer "nanti"
    t.integer "menonly"
    t.integer "womenonly"
    t.integer "relaffil"
    t.integer "satvr25"
    t.integer "satvr75"
    t.integer "satmt25"
    t.integer "satmt75"
    t.integer "satwr25"
    t.integer "satwr75"
    t.integer "satvrmid"
    t.integer "satmtmid"
    t.integer "satwrmid"
    t.integer "actcm25"
    t.integer "actcm75"
    t.integer "acten25"
    t.integer "acten75"
    t.integer "actmt25"
    t.integer "actmt75"
    t.integer "actwr25"
    t.integer "actwr75"
    t.integer "actcmmid"
    t.integer "actenmid"
    t.integer "actmtmid"
    t.integer "actwrmid"
    t.integer "sat_avg"
    t.integer "sat_avg_all"
    t.float "pcip01"
    t.float "pcip03"
    t.float "pcip04"
    t.float "pcip05"
    t.float "pcip09"
    t.float "pcip10"
    t.float "pcip11"
    t.float "pcip12"
    t.float "pcip13"
    t.float "pcip14"
    t.float "pcip15"
    t.float "pcip16"
    t.float "pcip19"
    t.float "pcip22"
    t.float "pcip23"
    t.float "pcip24"
    t.float "pcip25"
    t.float "pcip26"
    t.float "pcip27"
    t.float "pcip29"
    t.float "pcip30"
    t.float "pcip31"
    t.float "pcip38"
    t.float "pcip39"
    t.float "pcip40"
    t.float "pcip41"
    t.float "pcip42"
    t.float "pcip43"
    t.float "pcip44"
    t.float "pcip45"
    t.float "pcip46"
    t.float "pcip47"
    t.float "pcip48"
    t.float "pcip49"
    t.float "pcip50"
    t.float "pcip51"
    t.float "pcip52"
    t.float "pcip54"
    t.integer "distanceonly"
    t.float "ugds_white"
    t.float "ugds_black"
    t.float "ugds_hisp"
    t.float "ugds_asian"
    t.float "ugds_aian"
    t.float "ugds_nhpi"
    t.float "ugds_2mor"
    t.float "ugds_nra"
    t.float "ugds_unkn"
    t.float "pptug_ef"
    t.integer "curroper"
    t.integer "npt4_pub"
    t.integer "npt4_priv"
    t.integer "npt41_pub"
    t.integer "npt42_pub"
    t.integer "npt43_pub"
    t.integer "npt44_pub"
    t.integer "npt45_pub"
    t.integer "npt41_priv"
    t.integer "npt42_priv"
    t.integer "npt43_priv"
    t.integer "npt44_priv"
    t.integer "npt45_priv"
    t.float "pctpell"
    t.float "ret_pt4"
    t.float "ret_ptl4"
    t.float "pctfloan"
    t.float "ug25abv"
    t.float "gt_25k_p6"
    t.float "grad_debt_mdn10yr_supp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cross"], name: "index_scorecards_on_cross"
    t.index ["ope"], name: "index_scorecards_on_ope"
  end

  create_table "sec103s", force: :cascade do |t|
    t.string "name"
    t.string "facility_code", null: false
    t.boolean "complies_with_sec_103"
    t.boolean "solely_requires_coe"
    t.boolean "requires_coe_and_criteria"
  end

  create_table "sec109_closed_schools", id: :serial, force: :cascade do |t|
    t.string "facility_code"
    t.string "school_name"
    t.boolean "closure109"
    t.index ["facility_code"], name: "index_sec109_closed_schools_on_facility_code"
  end

  create_table "sec702_schools", id: :serial, force: :cascade do |t|
    t.string "facility_code", null: false
    t.boolean "sec_702"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["facility_code"], name: "index_sec702_schools_on_facility_code", unique: true
  end

  create_table "sec702s", id: :serial, force: :cascade do |t|
    t.string "state", null: false
    t.boolean "sec_702"
    t.string "state_full_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["state"], name: "index_sec702s_on_state", unique: true
  end

  create_table "sessions", id: :serial, force: :cascade do |t|
    t.string "session_id", null: false
    t.text "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "settlements", id: :serial, force: :cascade do |t|
    t.string "cross", null: false
    t.string "settlement_description", null: false
    t.string "institution"
    t.integer "school_system_code"
    t.string "school_system_name"
    t.string "settlement_date"
    t.string "settlement_link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cross"], name: "index_settlements_on_cross"
  end

  create_table "stem_cip_codes", id: :serial, force: :cascade do |t|
    t.integer "two_digit_series"
    t.string "twentyten_cip_code"
    t.string "cip_code_title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["twentyten_cip_code"], name: "index_stem_cip_codes_on_twentyten_cip_code"
  end

  create_table "storages", id: :serial, force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "csv", null: false
    t.string "csv_type", null: false
    t.string "comment"
    t.binary "data", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["csv_type"], name: "index_storages_on_csv_type", unique: true
    t.index ["updated_at"], name: "index_storages_on_updated_at"
    t.index ["user_id"], name: "index_storages_on_user_id"
  end

  create_table "svas", id: :serial, force: :cascade do |t|
    t.string "cross"
    t.string "student_veteran_link"
    t.integer "csv_id"
    t.string "institution"
    t.string "city"
    t.string "state"
    t.string "ipeds_code"
    t.string "website"
    t.string "sva_yes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cross"], name: "index_svas_on_cross"
  end

  create_table "uploads", id: :serial, force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "csv", null: false
    t.string "csv_type", null: false
    t.string "comment"
    t.boolean "ok", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "completed_at"
    t.index ["csv_type"], name: "index_uploads_on_csv_type"
    t.index ["updated_at"], name: "index_uploads_on_updated_at"
    t.index ["user_id"], name: "index_uploads_on_user_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "versioned_school_certifying_officials", id: :serial, force: :cascade do |t|
    t.string "facility_code"
    t.string "institution_name"
    t.string "priority"
    t.string "first_name"
    t.string "last_name"
    t.string "title"
    t.string "phone_area_code"
    t.string "phone_number"
    t.string "phone_extension"
    t.string "email"
    t.integer "version"
    t.bigint "institution_id"
    t.index ["institution_id"], name: "index_versioned_school_certifying_officials_on_institution_id"
  end

  create_table "versioned_school_certifying_officials_archives", id: :integer, default: -> { "nextval('versioned_school_certifying_officials_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "facility_code"
    t.string "institution_name"
    t.string "priority"
    t.string "first_name"
    t.string "last_name"
    t.string "title"
    t.string "phone_area_code"
    t.string "phone_number"
    t.string "phone_extension"
    t.string "email"
    t.integer "version"
    t.bigint "institution_id"
  end

  create_table "versions", id: :serial, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "number", null: false
    t.boolean "production", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.binary "uuid", null: false
    t.datetime "completed_at"
    t.index ["number"], name: "index_versions_on_number"
    t.index ["user_id"], name: "index_versions_on_user_id"
    t.index ["uuid"], name: "index_versions_on_uuid", unique: true
  end

  create_table "vsocs", id: :serial, force: :cascade do |t|
    t.string "facility_code", null: false
    t.string "vetsuccess_name"
    t.string "vetsuccess_email"
    t.string "institution"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["facility_code"], name: "index_vsocs_on_facility_code", unique: true
  end

  create_table "weams", id: :serial, force: :cascade do |t|
    t.string "facility_code", null: false
    t.string "institution", null: false
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "country"
    t.integer "bah"
    t.boolean "poe"
    t.boolean "yr"
    t.string "va_highest_degree_offered"
    t.string "institution_type_name", null: false
    t.boolean "flight"
    t.boolean "correspondence"
    t.boolean "accredited"
    t.boolean "ojt_indicator"
    t.boolean "correspondence_indicator"
    t.boolean "flight_indicator"
    t.boolean "non_college_degree_indicator"
    t.boolean "institution_of_higher_learning_indicator"
    t.string "poo_status"
    t.string "applicable_law_code"
    t.boolean "approved"
    t.string "address_1"
    t.string "address_2"
    t.string "address_3"
    t.string "cross"
    t.string "ope"
    t.string "ope6"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "approval_status"
    t.boolean "priority_enrollment"
    t.boolean "online_only"
    t.boolean "independent_study"
    t.boolean "distance_learning"
    t.string "physical_address_1"
    t.string "physical_address_2"
    t.string "physical_address_3"
    t.string "physical_city"
    t.string "physical_state"
    t.string "physical_zip"
    t.string "physical_country"
    t.integer "dod_bah"
    t.boolean "preferred_provider", default: false
    t.boolean "stem_indicator", default: false
    t.string "campus_type"
    t.string "parent_facility_code_id"
    t.integer "csv_row"
    t.index ["cross"], name: "index_weams_on_cross"
    t.index ["facility_code"], name: "index_weams_on_facility_code"
    t.index ["institution"], name: "index_weams_on_institution"
    t.index ["ope"], name: "index_weams_on_ope"
    t.index ["state"], name: "index_weams_on_state"
  end

  create_table "yellow_ribbon_program_sources", id: :serial, force: :cascade do |t|
    t.string "facility_code"
    t.string "school_name_in_yr_database"
    t.string "school_name_in_weams"
    t.string "campus"
    t.string "street_address"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "public_private"
    t.string "degree_level"
    t.string "division_professional_school"
    t.integer "number_of_students"
    t.decimal "contribution_amount", precision: 12, scale: 2
    t.boolean "updated_for_2011_2012"
    t.boolean "missed_deadline"
    t.boolean "ineligible"
    t.date "date_agreement_received"
    t.date "date_yr_signed_by_yr_official"
    t.date "amendment_date"
    t.boolean "flight_school"
    t.date "date_confirmation_sent"
    t.boolean "consolidated_agreement"
    t.boolean "new_school"
    t.boolean "open_ended_agreement"
    t.boolean "modified"
    t.boolean "withdrawn"
    t.string "sco_name"
    t.string "sco_telephone_number"
    t.string "sco_email_address"
    t.string "sfr_name"
    t.string "sfr_telephone_number"
    t.string "sfr_email_address"
    t.string "initials_yr_processor"
    t.string "year_of_yr_participation"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["facility_code"], name: "index_yellow_ribbon_program_sources_on_facility_code"
  end

  create_table "yellow_ribbon_programs", id: :serial, force: :cascade do |t|
    t.integer "version", null: false
    t.integer "institution_id", null: false
    t.string "degree_level"
    t.string "division_professional_school"
    t.integer "number_of_students"
    t.decimal "contribution_amount", precision: 12, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "amendment_date"
    t.string "campus"
    t.string "city"
    t.boolean "consolidated_agreement"
    t.date "date_agreement_received"
    t.date "date_confirmation_sent"
    t.date "date_yr_signed_by_yr_official"
    t.string "facility_code"
    t.boolean "flight_school"
    t.boolean "ineligible"
    t.string "initials_yr_processor"
    t.boolean "missed_deadline"
    t.boolean "modified"
    t.boolean "new_school"
    t.text "notes"
    t.boolean "open_ended_agreement"
    t.string "public_private"
    t.string "school_name_in_weams"
    t.string "school_name_in_yr_database"
    t.string "sco_email_address"
    t.string "sco_name"
    t.string "sco_telephone_number"
    t.string "sfr_email_address"
    t.string "sfr_name"
    t.string "sfr_telephone_number"
    t.string "state"
    t.string "street_address"
    t.boolean "updated_for_2011_2012"
    t.boolean "withdrawn"
    t.string "year_of_yr_participation"
    t.string "zip"
    t.index ["institution_id"], name: "index_yellow_ribbon_programs_on_institution_id"
    t.index ["version"], name: "index_yellow_ribbon_programs_on_version"
  end

  create_table "zipcode_rates", id: :serial, force: :cascade do |t|
    t.string "zip_code"
    t.string "mha_code"
    t.string "mha_name"
    t.float "mha_rate"
    t.float "mha_rate_grandfathered"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "version"
    t.bigint "version_id"
    t.index ["version", "zip_code"], name: "index_zipcode_rates_on_version_and_zip_code"
    t.index ["version_id"], name: "index_zipcode_rates_on_version_id"
  end

  create_table "zipcode_rates_archives", id: :integer, default: -> { "nextval('zipcode_rates_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "zip_code"
    t.string "mha_code"
    t.string "mha_name"
    t.float "mha_rate"
    t.float "mha_rate_grandfathered"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "version"
    t.bigint "version_id"
    t.index ["version", "zip_code"], name: "zipcode_rates_archives_version_zip_code_idx"
  end

  add_foreign_key "caution_flag_rules", "rules"
  add_foreign_key "caution_flags", "institutions"
  add_foreign_key "caution_flags", "versions"
  add_foreign_key "crosswalk_issues", "crosswalks"
  add_foreign_key "crosswalk_issues", "ipeds_hds"
  add_foreign_key "crosswalk_issues", "weams"
  add_foreign_key "institutions", "versions"
  add_foreign_key "versioned_school_certifying_officials", "institutions"
  add_foreign_key "zipcode_rates", "versions"
end

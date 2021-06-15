CSV_TYPES_TABLES = [
  { klass: AccreditationAction, required?: true },
  { klass: AccreditationInstituteCampus, required?: true },
  { klass: AccreditationRecord, required?: true },
  { klass: ArfGiBill, required?: true },
  { klass: CipCode, required?: false },
  { klass: Complaint, required?: true },
  { klass: Crosswalk, required?: true },
  { klass: EightKey, required?: true },
  { klass: Hcm, required?: true },
  { klass: IpedsHd, required?: true },
  { klass: IpedsIcAy, required?: true },
  { klass: IpedsIcPy, required?: true },
  { klass: IpedsIc, required?: true },
  { klass: Mou, required?: true },
  { klass: Outcome, required?: true },
  { klass: Scorecard, required?: true, has_api?: true },
  { klass: ScorecardDegreeProgram, required?: false, has_api?: true },
  { klass: Sec702, required?: true },
  { klass: Sva, required?: true },
  { klass: Vsoc, required?: true },
  { klass: Weam, required?: true },
  { klass: CalculatorConstant, required?: false },
  { klass: IpedsCipCode, required?: true },
  { klass: StemCipCode, required?: true },
  { klass: YellowRibbonProgramSource, required?: true },
  { klass: Sec109ClosedSchool, required?: true },
  { klass: Program, required?: false },
  { klass: SchoolCertifyingOfficial, required?: false},
  { klass: EduProgram, required?: false },
  { klass: Sec103, required?: false },
  { klass: VaCautionFlag, required?: false },
  { klass: Post911Stat, required?: false },
  { klass: SchoolRating, required?: false },
  { klass: VrrapProvider, required?: false },
].freeze

CSV_TYPES_HAS_API_TABLE_NAMES = CSV_TYPES_TABLES.select { |table| table[:has_api?] }.map { |table| table[:klass].name }.freeze
CSV_TYPES_ALL_TABLES_CLASSES = CSV_TYPES_TABLES.map { |table| table[:klass] }.freeze

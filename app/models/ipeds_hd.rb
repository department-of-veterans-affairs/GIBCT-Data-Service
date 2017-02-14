# frozen_string_literal: true
class IpedsHd < ActiveRecord::Base
  include CsvHelper

  CSV_CONVERTER_INFO = {
    'unitid' => { column: :cross, converter: CrossConverter },
    'instnm' => { column: :institution, converter: InstitutionConverter },
    'addr' => { column: :addr, converter: BaseConverter },
    'city' => { column: :city, converter: BaseConverter },
    'stabbr' => { column: :state, converter: BaseConverter },
    'zip' => { column: :zip, converter: ZipConverter },
    'fips' => { column: :fips, converter: BaseConverter },
    'obereg' => { column: :obereg, converter: BaseConverter },
    'chfnm' => { column: :chfnm, converter: BaseConverter },
    'chftitle' => { column: :chftitle, converter: BaseConverter },
    'gentele' => { column: :gentele, converter: BaseConverter },
    'ein' => { column: :ein, converter: BaseConverter },
    'opeid' => { column: :ope, converter: OpeConverter },
    'opeflag' => { column: :opeflag, converter: BaseConverter },
    'webaddr' => { column: :webaddr, converter: BaseConverter },
    'adminurl' => { column: :adminurl, converter: BaseConverter },
    'faidurl' => { column: :faidurl, converter: BaseConverter },
    'applurl' => { column: :applurl, converter: BaseConverter },
    'npricurl' => { column: :npricurl, converter: BaseConverter },
    'veturl' => { column: :vet_tuition_policy_url, converter: BaseConverter },
    'athurl' => { column: :athurl, converter: BaseConverter },
    'sector' => { column: :sector, converter: BaseConverter },
    'iclevel' => { column: :iclevel, converter: BaseConverter },
    'control' => { column: :control, converter: BaseConverter },
    'hloffer' => { column: :hloffer, converter: BaseConverter },
    'ugoffer' => { column: :ugoffer, converter: BaseConverter },
    'groffer' => { column: :groffer, converter: BaseConverter },
    'hdegofr1' => { column: :hdegofr1, converter: BaseConverter },
    'deggrant' => { column: :deggrant, converter: BaseConverter },
    'hbcu' => { column: :hbcu, converter: BaseConverter },
    'hospital' => { column: :hospital, converter: BaseConverter },
    'medical' => { column: :medical, converter: BaseConverter },
    'tribal' => { column: :tribal, converter: BaseConverter },
    'locale' => { column: :locale, converter: BaseConverter },
    'openpubl' => { column: :openpubl, converter: BaseConverter },
    'newid' => { column: :newid, converter: BaseConverter },
    'act' => { column: :act, converter: BaseConverter },
    'deathyr' => { column: :deathyr, converter: BaseConverter },
    'closedat' => { column: :closedat, converter: BaseConverter },
    'cyactive' => { column: :cyactive, converter: BaseConverter },
    'postsec' => { column: :postsec, converter: BaseConverter },
    'pseflag' => { column: :pseflag, converter: BaseConverter },
    'pset4flg' => { column: :pset4flg, converter: BaseConverter },
    'rptmth' => { column: :rptmth, converter: BaseConverter },
    'ialias' => { column: :ialias, converter: BaseConverter },
    'instcat' => { column: :instcat, converter: BaseConverter },
    'ccbasic' => { column: :ccbasic, converter: BaseConverter },
    'ccipug' => { column: :ccipug, converter: BaseConverter },
    'ccipgrad' => { column: :ccipgrad, converter: BaseConverter },
    'ccugprof' => { column: :ccugprof, converter: BaseConverter },
    'ccenrprf' => { column: :ccenrprf, converter: BaseConverter },
    'ccsizset' => { column: :ccsizset, converter: BaseConverter },
    'carnegie' => { column: :carnegie, converter: BaseConverter },
    'landgrnt' => { column: :landgrnt, converter: BaseConverter },
    'instsize' => { column: :instsize, converter: BaseConverter },
    'cbsa' => { column: :cbsa, converter: BaseConverter },
    'cbsatype' => { column: :cbsatype, converter: BaseConverter },
    'csa' => { column: :csa, converter: BaseConverter },
    'necta' => { column: :necta, converter: BaseConverter },
    'f1systyp' => { column: :f1systyp, converter: BaseConverter },
    'f1sysnam' => { column: :f1sysnam, converter: BaseConverter },
    'f1syscod' => { column: :f1syscod, converter: BaseConverter },
    'countycd' => { column: :countycd, converter: BaseConverter },
    'countynm' => { column: :countynm, converter: BaseConverter },
    'cngdstcd' => { column: :cngdstcd, converter: BaseConverter },
    'longitud' => { column: :longitud, converter: BaseConverter },
    'latitude' => { column: :latitude, converter: BaseConverter },
    'dfrcgid' => { column: :dfrcgid, converter: BaseConverter },
    'dfrcuscg' => { column: :dfrcuscg, converter: BaseConverter }
  }.freeze

  validates :cross, presence: true
end

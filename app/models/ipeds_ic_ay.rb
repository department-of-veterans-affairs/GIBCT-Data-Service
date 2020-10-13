# frozen_string_literal: true

class IpedsIcAy < ApplicationRecord


  COLS_USED_IN_INSTITUTION = %i[tuition_in_state tuition_out_of_state books].freeze

  CSV_CONVERTER_INFO = {
    'unitid' => { column: :cross, converter: CrossConverter },
    'xtuit1' => { column: :xtuit1, converter: BaseConverter },
    'tuition1' => { column: :tuition1, converter: NumberConverter },
    'xfee1' => { column: :xfee1, converter: BaseConverter },
    'fee1' => { column: :fee1, converter: NumberConverter },
    'xhrchg1' => { column: :xhrchg1, converter: BaseConverter },
    'hrchg1' => { column: :hrchg1, converter: NumberConverter },
    'xtuit2' => { column: :xtuit2, converter: BaseConverter },
    'tuition2' => { column: :tuition2, converter: NumberConverter },
    'xfee2' => { column: :xfee2, converter: BaseConverter },
    'fee2' => { column: :fee2, converter: NumberConverter },
    'xhrchg2' => { column: :xhrchg2, converter: BaseConverter },
    'hrchg2' => { column: :hrchg2, converter: NumberConverter },
    'xtuit3' => { column: :xtuit3, converter: BaseConverter },
    'tuition3' => { column: :tuition3, converter: NumberConverter },
    'xfee3' => { column: :xfee3, converter: BaseConverter },
    'fee3' => { column: :fee3, converter: NumberConverter },
    'xhrchg3' => { column: :xhrchg3, converter: BaseConverter },
    'hrchg3' => { column: :hrchg3, converter: NumberConverter },
    'xtuit5' => { column: :xtuit5, converter: BaseConverter },
    'tuition5' => { column: :tuition5, converter: NumberConverter },
    'xfee5' => { column: :xfee5, converter: BaseConverter },
    'fee5' => { column: :fee5, converter: NumberConverter },
    'xhrchg5' => { column: :xhrchg5, converter: BaseConverter },
    'hrchg5' => { column: :hrchg5, converter: NumberConverter },
    'xtuit6' => { column: :xtuit6, converter: BaseConverter },
    'tuition6' => { column: :tuition6, converter: NumberConverter },
    'xfee6' => { column: :xfee6, converter: BaseConverter },
    'fee6' => { column: :fee6, converter: NumberConverter },
    'xhrchg6' => { column: :xhrchg6, converter: BaseConverter },
    'hrchg6' => { column: :hrchg6, converter: NumberConverter },
    'xtuit7' => { column: :xtuit7, converter: BaseConverter },
    'tuition7' => { column: :tuition7, converter: NumberConverter },
    'xfee7' => { column: :xfee7, converter: BaseConverter },
    'fee7' => { column: :fee7, converter: NumberConverter },
    'xhrchg7' => { column: :xhrchg7, converter: BaseConverter },
    'hrchg7' => { column: :hrchg7, converter: NumberConverter },
    'xispro1' => { column: :xispro1, converter: BaseConverter },
    'isprof1' => { column: :isprof1, converter: NumberConverter },
    'xispfe1' => { column: :xispfe1, converter: BaseConverter },
    'ispfee1' => { column: :ispfee1, converter: NumberConverter },
    'xospro1' => { column: :xospro1, converter: BaseConverter },
    'osprof1' => { column: :osprof1, converter: NumberConverter },
    'xospfe1' => { column: :xospfe1, converter: BaseConverter },
    'ospfee1' => { column: :ospfee1, converter: NumberConverter },
    'xispro2' => { column: :xispro2, converter: BaseConverter },
    'isprof2' => { column: :isprof2, converter: NumberConverter },
    'xispfe2' => { column: :xispfe2, converter: BaseConverter },
    'ispfee2' => { column: :ispfee2, converter: NumberConverter },
    'xospro2' => { column: :xospro2, converter: BaseConverter },
    'osprof2' => { column: :osprof2, converter: NumberConverter },
    'xospfe2' => { column: :xospfe2, converter: BaseConverter },
    'ospfee2' => { column: :ospfee2, converter: NumberConverter },
    'xispro3' => { column: :xispro3, converter: BaseConverter },
    'isprof3' => { column: :isprof3, converter: NumberConverter },
    'xispfe3' => { column: :xispfe3, converter: BaseConverter },
    'ispfee3' => { column: :ispfee3, converter: NumberConverter },
    'xospro3' => { column: :xospro3, converter: BaseConverter },
    'osprof3' => { column: :osprof3, converter: NumberConverter },
    'xospfe3' => { column: :xospfe3, converter: BaseConverter },
    'ospfee3' => { column: :ospfee3, converter: NumberConverter },
    'xispro4' => { column: :xispro4, converter: BaseConverter },
    'isprof4' => { column: :isprof4, converter: NumberConverter },
    'xispfe4' => { column: :xispfe4, converter: BaseConverter },
    'ispfee4' => { column: :ispfee4, converter: NumberConverter },
    'xospro4' => { column: :xospro4, converter: BaseConverter },
    'osprof4' => { column: :osprof4, converter: NumberConverter },
    'xospfe4' => { column: :xospfe4, converter: BaseConverter },
    'ospfee4' => { column: :ospfee4, converter: NumberConverter },
    'xispro5' => { column: :xispro5, converter: BaseConverter },
    'isprof5' => { column: :isprof5, converter: NumberConverter },
    'xispfe5' => { column: :xispfe5, converter: BaseConverter },
    'ispfee5' => { column: :ispfee5, converter: NumberConverter },
    'xospro5' => { column: :xospro5, converter: BaseConverter },
    'osprof5' => { column: :osprof5, converter: NumberConverter },
    'xospfe5' => { column: :xospfe5, converter: BaseConverter },
    'ospfee5' => { column: :ospfee5, converter: NumberConverter },
    'xispro6' => { column: :xispro6, converter: BaseConverter },
    'isprof6' => { column: :isprof6, converter: NumberConverter },
    'xispfe6' => { column: :xispfe6, converter: BaseConverter },
    'ispfee6' => { column: :ispfee6, converter: NumberConverter },
    'xospro6' => { column: :xospro6, converter: BaseConverter },
    'osprof6' => { column: :osprof6, converter: NumberConverter },
    'xospfe6' => { column: :xospfe6, converter: BaseConverter },
    'ospfee6' => { column: :ospfee6, converter: NumberConverter },
    'xispro7' => { column: :xispro7, converter: BaseConverter },
    'isprof7' => { column: :isprof7, converter: NumberConverter },
    'xispfe7' => { column: :xispfe7, converter: BaseConverter },
    'ispfee7' => { column: :ispfee7, converter: NumberConverter },
    'xospro7' => { column: :xospro7, converter: BaseConverter },
    'osprof7' => { column: :osprof7, converter: NumberConverter },
    'xospfe7' => { column: :xospfe7, converter: BaseConverter },
    'ospfee7' => { column: :ospfee7, converter: NumberConverter },
    'xispro8' => { column: :xispro8, converter: BaseConverter },
    'isprof8' => { column: :isprof8, converter: NumberConverter },
    'xispfe8' => { column: :xispfe8, converter: BaseConverter },
    'ispfee8' => { column: :ispfee8, converter: NumberConverter },
    'xospro8' => { column: :xospro8, converter: BaseConverter },
    'osprof8' => { column: :osprof8, converter: NumberConverter },
    'xospfe8' => { column: :xospfe8, converter: BaseConverter },
    'ospfee8' => { column: :ospfee8, converter: NumberConverter },
    'xispro9' => { column: :xispro9, converter: BaseConverter },
    'isprof9' => { column: :isprof9, converter: NumberConverter },
    'xispfe9' => { column: :xispfe9, converter: BaseConverter },
    'ispfee9' => { column: :ispfee9, converter: NumberConverter },
    'xospro9' => { column: :xospro9, converter: BaseConverter },
    'osprof9' => { column: :osprof9, converter: NumberConverter },
    'xospfe9' => { column: :xospfe9, converter: BaseConverter },
    'ospfee9' => { column: :ospfee9, converter: NumberConverter },
    'xchg1at0' => { column: :xchg1at0, converter: BaseConverter },
    'chg1at0' => { column: :chg1at0, converter: NumberConverter },
    'xchg1af0' => { column: :xchg1af0, converter: BaseConverter },
    'chg1af0' => { column: :chg1af0, converter: NumberConverter },
    'xchg1ay0' => { column: :xchg1ay0, converter: BaseConverter },
    'chg1ay0' => { column: :chg1ay0, converter: NumberConverter },
    'xchg1at1' => { column: :xchg1at1, converter: BaseConverter },
    'chg1at1' => { column: :chg1at1, converter: NumberConverter },
    'xchg1af1' => { column: :xchg1af1, converter: BaseConverter },
    'chg1af1' => { column: :chg1af1, converter: NumberConverter },
    'xchg1ay1' => { column: :xchg1ay1, converter: BaseConverter },
    'chg1ay1' => { column: :chg1ay1, converter: NumberConverter },
    'xchg1at2' => { column: :xchg1at2, converter: BaseConverter },
    'chg1at2' => { column: :chg1at2, converter: NumberConverter },
    'xchg1af2' => { column: :xchg1af2, converter: BaseConverter },
    'chg1af2' => { column: :chg1af2, converter: NumberConverter },
    'xchg1ay2' => { column: :xchg1ay2, converter: BaseConverter },
    'chg1ay2' => { column: :chg1ay2, converter: NumberConverter },
    'xchg1at3' => { column: :xchg1at3, converter: BaseConverter },
    'chg1at3' => { column: :chg1at3, converter: NumberConverter },
    'xchg1af3' => { column: :xchg1af3, converter: BaseConverter },
    'chg1af3' => { column: :chg1af3, converter: NumberConverter },
    'xchg1ay3' => { column: :xchg1ay3, converter: BaseConverter },
    'chg1ay3' => { column: :chg1ay3, converter: NumberConverter },
    'chg1tgtd' => { column: :chg1tgtd, converter: NumberConverter },
    'chg1fgtd' => { column: :chg1fgtd, converter: NumberConverter },
    'xchg2at0' => { column: :xchg2at0, converter: BaseConverter },
    'chg2at0' => { column: :chg2at0, converter: NumberConverter },
    'xchg2af0' => { column: :xchg2af0, converter: BaseConverter },
    'chg2af0' => { column: :chg2af0, converter: NumberConverter },
    'xchg2ay0' => { column: :xchg2ay0, converter: BaseConverter },
    'chg2ay0' => { column: :chg2ay0, converter: NumberConverter },
    'xchg2at1' => { column: :xchg2at1, converter: BaseConverter },
    'chg2at1' => { column: :chg2at1, converter: NumberConverter },
    'xchg2af1' => { column: :xchg2af1, converter: BaseConverter },
    'chg2af1' => { column: :chg2af1, converter: NumberConverter },
    'xchg2ay1' => { column: :xchg2ay1, converter: BaseConverter },
    'chg2ay1' => { column: :chg2ay1, converter: NumberConverter },
    'xchg2at2' => { column: :xchg2at2, converter: BaseConverter },
    'chg2at2' => { column: :chg2at2, converter: NumberConverter },
    'xchg2af2' => { column: :xchg2af2, converter: BaseConverter },
    'chg2af2' => { column: :chg2af2, converter: NumberConverter },
    'xchg2ay2' => { column: :xchg2ay2, converter: BaseConverter },
    'chg2ay2' => { column: :chg2ay2, converter: NumberConverter },
    'xchg2at3' => { column: :xchg2at3, converter: BaseConverter },
    'chg2at3' => { column: :chg2at3, converter: NumberConverter },
    'xchg2af3' => { column: :xchg2af3, converter: BaseConverter },
    'chg2af3' => { column: :chg2af3, converter: NumberConverter },
    'xchg2ay3' => { column: :xchg2ay3, converter: BaseConverter },
    'chg2ay3' => { column: :tuition_in_state, converter: NumberConverter },
    'chg2tgtd' => { column: :chg2tgtd, converter: NumberConverter },
    'chg2fgtd' => { column: :chg2fgtd, converter: NumberConverter },
    'xchg3at0' => { column: :xchg3at0, converter: BaseConverter },
    'chg3at0' => { column: :chg3at0, converter: NumberConverter },
    'xchg3af0' => { column: :xchg3af0, converter: BaseConverter },
    'chg3af0' => { column: :chg3af0, converter: NumberConverter },
    'xchg3ay0' => { column: :xchg3ay0, converter: BaseConverter },
    'chg3ay0' => { column: :chg3ay0, converter: NumberConverter },
    'xchg3at1' => { column: :xchg3at1, converter: BaseConverter },
    'chg3at1' => { column: :chg3at1, converter: NumberConverter },
    'xchg3af1' => { column: :xchg3af1, converter: BaseConverter },
    'chg3af1' => { column: :chg3af1, converter: NumberConverter },
    'xchg3ay1' => { column: :xchg3ay1, converter: BaseConverter },
    'chg3ay1' => { column: :chg3ay1, converter: NumberConverter },
    'xchg3at2' => { column: :xchg3at2, converter: BaseConverter },
    'chg3at2' => { column: :chg3at2, converter: NumberConverter },
    'xchg3af2' => { column: :xchg3af2, converter: BaseConverter },
    'chg3af2' => { column: :chg3af2, converter: NumberConverter },
    'xchg3ay2' => { column: :xchg3ay2, converter: BaseConverter },
    'chg3ay2' => { column: :chg3ay2, converter: NumberConverter },
    'xchg3at3' => { column: :xchg3at3, converter: BaseConverter },
    'chg3at3' => { column: :chg3at3, converter: NumberConverter },
    'xchg3af3' => { column: :xchg3af3, converter: BaseConverter },
    'chg3af3' => { column: :chg3af3, converter: NumberConverter },
    'xchg3ay3' => { column: :xchg3ay3, converter: BaseConverter },
    'chg3ay3' => { column: :tuition_out_of_state, converter: NumberConverter },
    'chg3tgtd' => { column: :chg3tgtd, converter: NumberConverter },
    'chg3fgtd' => { column: :chg3fgtd, converter: NumberConverter },
    'xchg4ay0' => { column: :xchg4ay0, converter: BaseConverter },
    'chg4ay0' => { column: :chg4ay0, converter: NumberConverter },
    'xchg4ay1' => { column: :xchg4ay1, converter: BaseConverter },
    'chg4ay1' => { column: :chg4ay1, converter: NumberConverter },
    'xchg4ay2' => { column: :xchg4ay2, converter: BaseConverter },
    'chg4ay2' => { column: :chg4ay2, converter: NumberConverter },
    'xchg4ay3' => { column: :xchg4ay3, converter: BaseConverter },
    'chg4ay3' => { column: :books, converter: NumberConverter },
    'xchg5ay0' => { column: :xchg5ay0, converter: BaseConverter },
    'chg5ay0' => { column: :chg5ay0, converter: NumberConverter },
    'xchg5ay1' => { column: :xchg5ay1, converter: BaseConverter },
    'chg5ay1' => { column: :chg5ay1, converter: NumberConverter },
    'xchg5ay2' => { column: :xchg5ay2, converter: BaseConverter },
    'chg5ay2' => { column: :chg5ay2, converter: NumberConverter },
    'xchg5ay3' => { column: :xchg5ay3, converter: BaseConverter },
    'chg5ay3' => { column: :chg5ay3, converter: NumberConverter },
    'xchg6ay0' => { column: :xchg6ay0, converter: BaseConverter },
    'chg6ay0' => { column: :chg6ay0, converter: NumberConverter },
    'xchg6ay1' => { column: :xchg6ay1, converter: BaseConverter },
    'chg6ay1' => { column: :chg6ay1, converter: NumberConverter },
    'xchg6ay2' => { column: :xchg6ay2, converter: BaseConverter },
    'chg6ay2' => { column: :chg6ay2, converter: NumberConverter },
    'xchg6ay3' => { column: :xchg6ay3, converter: BaseConverter },
    'chg6ay3' => { column: :chg6ay3, converter: NumberConverter },
    'xchg7ay0' => { column: :xchg7ay0, converter: BaseConverter },
    'chg7ay0' => { column: :chg7ay0, converter: NumberConverter },
    'xchg7ay1' => { column: :xchg7ay1, converter: BaseConverter },
    'chg7ay1' => { column: :chg7ay1, converter: NumberConverter },
    'xchg7ay2' => { column: :xchg7ay2, converter: BaseConverter },
    'chg7ay2' => { column: :chg7ay2, converter: NumberConverter },
    'xchg7ay3' => { column: :xchg7ay3, converter: BaseConverter },
    'chg7ay3' => { column: :chg7ay3, converter: NumberConverter },
    'xchg8ay0' => { column: :xchg8ay0, converter: BaseConverter },
    'chg8ay0' => { column: :chg8ay0, converter: NumberConverter },
    'xchg8ay1' => { column: :xchg8ay1, converter: BaseConverter },
    'chg8ay1' => { column: :chg8ay1, converter: NumberConverter },
    'xchg8ay2' => { column: :xchg8ay2, converter: BaseConverter },
    'chg8ay2' => { column: :chg8ay2, converter: NumberConverter },
    'xchg8ay3' => { column: :xchg8ay3, converter: BaseConverter },
    'chg8ay3' => { column: :chg8ay3, converter: NumberConverter },
    'xchg9ay0' => { column: :xchg9ay0, converter: BaseConverter },
    'chg9ay0' => { column: :chg9ay0, converter: NumberConverter },
    'xchg9ay1' => { column: :xchg9ay1, converter: BaseConverter },
    'chg9ay1' => { column: :chg9ay1, converter: NumberConverter },
    'xchg9ay2' => { column: :xchg9ay2, converter: BaseConverter },
    'chg9ay2' => { column: :chg9ay2, converter: NumberConverter },
    'xchg9ay3' => { column: :xchg9ay3, converter: BaseConverter },
    'chg9ay3' => { column: :chg9ay3, converter: NumberConverter }
  }.freeze

  validates :cross, presence: true

  validates :tuition_in_state, numericality: true, allow_blank: true
  validates :tuition_out_of_state, numericality: true, allow_blank: true
  validates :books, numericality: true, allow_blank: true
end

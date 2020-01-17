# frozen_string_literal: true

require 'rails_helper'
require 'models/shared_examples/shared_examples_for_archivable_by_parent_id'

RSpec.describe InstitutionProgramsArchive, type: :model do
  it_behaves_like 'an archivable model by parent id', original_type: InstitutionProgram, factory: :institution_program
end

FactoryGirl.define do
  factory :hcm do
    institution { Faker::University.name }
    sequence(:ope) { |n| DS::OpeId.pad(n.to_s) }

    hcm_type { ['HCM - Cash Monitoring 1', 'HCM - Cash Monitoring 2'].sample }
    hcm_reason do
      ['Financial Responsibility',
       'Audit Late/Missing', 'Program Review', 'Other -CIO Problems (Eligibility)',
       'F/S Late/Missing', 'Program Review - Severe Findings', 'OIG',
       'Denied Recert - PPA Not Expired', 'Payment Method Changed',
       'Accreditation Problems', 'Administrative Capability',
       'Provisional Certification'
      ].sample
    end
  end
end

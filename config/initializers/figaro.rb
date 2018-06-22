# frozen_string_literal: true

Figaro.require_keys(
  'LINK_HOST',
  'SECRET_KEY_BASE',
  'GIBCT_URL',
  'SAML_IDP_METADATA_FILE',
  'SAML_CALLBACK_URL',
  'SAML_IDP_SSO_URL',
  'SAML_ISSUER'
)

# Remove all private keys, certificates and CSR
rm *.key
rm *.pem
rm *.csr
# Get profile ID using name
profile_id=$(aws rolesanywhere list-profiles --query 'profiles[?name==`demo-profile`].profileId' --output text)
# Get trust anchor ID using name
trust_anchor_id=$(aws rolesanywhere list-trust-anchors --query 'trustAnchors[?name==`demo-trust-anchor`].trustAnchorId' --output text)
# Delete profile
aws rolesanywhere delete-profile --profile-id $profile_id
# Delete role
aws iam delete-role --role-name demo-rolesanywhere
# Delete trust anchor
aws rolesanywhere delete-trust-anchor --trust-anchor-id $trust_anchor_id

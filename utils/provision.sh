# stop pre-existing vault service
sudo service vault stop
# install the vault enterprise version
sudo cp /home/vagrant/vault /usr/local/bin
# restart vault
sudo service vault start 

sleep 3

# create namespace education
vault namespace create education

# configure  vault server approle
vault login root

# Create db_readonly policy
vault policy write db_readonly - <<POL
path "database/creds/readonly" {
  capabilities = [ "read" ]
}

path "/sys/leases/renew" {
  capabilities = [ "update" ]
}

path "auth/token/create" {
  capabilities = ["update"]
}
POL

# Setup approle
vault auth enable -namespace=education  approle
vault write -namespace=education auth/approle/role/apps policies="db_readonly"
echo $(vault read -namespace=education -format=json auth/approle/role/apps/role-id | jq  -r '.data.role_id') > /home/vagrant/roleID
echo $(vault write -namespace=education -f -format=json auth/approle/role/apps/secret-id | jq -r '.data.secret_id') > /home/vagrant/secretID

# enable server logging 
vault audit enable -path=file_raw file file_path=/vault/audit-law.log log_raw=true

# run manually after vagrant ssh
#cd /home/vagrant
#sudo vault agent -config=agent-config.hcl -log-level=debug
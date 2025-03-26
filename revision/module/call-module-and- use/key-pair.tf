module "key-pair" {
  source = "../module" # put the name of the folder where the variabl is found
  # bellow is the variable that has been declear on the above folder , now we are only putting our own value
  key_name = terraform
  filename = my_key.pem
  file_permission = 400
}
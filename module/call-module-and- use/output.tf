module "output" {
  source = "../module"
  output_pemfile = local_file.ssh_key.filename
  output_keyname = aws_key_pair.aws_key.key_name
  
}
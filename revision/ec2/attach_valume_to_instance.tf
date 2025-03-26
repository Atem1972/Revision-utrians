resource "aws_volume_attachment" "attach" {
    device_name = "/dev/sdc"
    volume_id = aws_ebs_volume.ebs.id
    instance_id = aws_instance.dnk.id
  
}
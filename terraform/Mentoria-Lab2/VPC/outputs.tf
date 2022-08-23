#outputs que permiten usar los recursos creados en este modulo desde otros modulos.

output "vpcidout" {
  value = "${aws_vpc.vpc01.id}"
}
output "servicessgrid" {
  value = "${aws_security_group.servicessgr.id}"
}
output "publicsgrid" {
  value = "${aws_security_group.publicsgr.id}"
}
output "rdssgrid" {
  value = "${aws_security_group.rdssgr.id}"
}
output "subnetsid" {
  value = "${aws_subnet.subnets.*.id}"
}
output "PrivIPbastion" {
  value = local.PrivIPBastion
}

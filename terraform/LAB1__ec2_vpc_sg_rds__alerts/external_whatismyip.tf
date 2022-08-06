#-----------------------------------------
# Obtain current Public Internet IP
#-----------------------------------------

data "external" "whatismyip" {
  program = ["/bin/bash" , "${path.module}/whatismyip.sh"]
}

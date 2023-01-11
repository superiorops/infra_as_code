ls -l
cat $(id_demo.secureFilePath)
cat $(id_demo.secureFilePath) > id_demo

ls -l
chmod 400 id_demo
sed  "s,#PREFIX#,$PREFIX," terraform.tfvars.tpl > terraform.tfvars
sed -i "s,#LOCATION#,$LOCATION," terraform.tfvars
sed -i "s,#VMPASSWORD#,$VMPASSWORD," terraform.tfvars
sed -i "s,#ENVIRONMENT#,$ENVIRONMENT," terraform.tfvars
sed -i "s,#ADMINUSER#,$ADMINUSER,g" terraform.tfvars
cat terraform.tfvars



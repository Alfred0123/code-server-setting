# data "template_cloudinit_config" "this" {
#   gzip = true
#   base64_encode = true

#   part {
#     content_type = "text/cloud-config" # "text/x-shellscript"
#     # filename = "code-server-config.yaml"
#     # content = "${data.template_file.code_server_config.rendered}"

#     #! 주의사항 / path 값을 /home/ubuntu 로 잡으면, 유저가 생기기 전에 ubuntu 폴더가 생기게 됨으로 주의!
#     content = jsonencode({
#       write_files = [
#         {
#           encoding = "b64"
#           # content = filebase64("${data.template_file.code_server_config.rendered}")
#           content = filebase64("${path.module}/init/config.yaml")
#           # content = data.template_file.code_server_config.rendered
#           owner = "root:root"
#           path = "/tmp/config.yaml"
#           permissions = "0755"
#         },
#         {
#           encoding = "b64"
#           content = filebase64("${path.module}/init/code-server-install.sh")
#           owner = "root:root"
#           path = "/tmp/code-server-install.sh"
#           permissions = "0755"
#         }
#       ]
#     })
#   }
# #   part {
# #     content_type = "text/x-shellscript"
# #     content = <<EOF
# # #!/bin/bash
# # sudo sh /tmp/code-server-install.sh &
# # # sudo ls /tmp > /tmp.log
# # # sudo ls /home > /home.log
# # sudo echo "end!!!" >> /temp.log
# # EOF
# #   }

#   #
#   # lifecycle {
#   #   ignore_changes = [user_data]
#   # }
# }

# data "template_file" "code_server_config" {
#   template = file("${path.module}/init/config.yaml")
#   vars = {
#     # password = var.password
#   }
# }
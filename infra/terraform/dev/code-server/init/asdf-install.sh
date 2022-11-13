git clone https://github.com/asdf-vm/asdf.git /home/ubuntu/.asdf --branch v0.10.2

echo '. /home/ubuntu/.asdf/asdf.sh' >> /home/ubuntu/.bashrc
echo '. /home/ubuntu/.asdf/completions/asdf.bash' >> /home/ubuntu/.bashrc

#
source /home/ubuntu/.bashrc

# golang plugin
asdf plugin-add golang https://github.com/kennyp/asdf-golang.git
# go 1.17
asdf install golang 1.17
asdf global golang 1.17
# go required module
go get -u github.com/cosmtrek/air
echo 'alias air="$(go env GOPATH)/bin/air"' >> /home/ubuntu/.bashrc
# go required module / vscode
go install -v github.com/stamblerre/gocode@v1.0.0
go install -v golang.org/x/tools/gopls@latest
go install -v golang.org/x/tools/cmd/goimports@latest
# 이부분 인스톨 잘 되는지 확인

# make install
sudo apt install make

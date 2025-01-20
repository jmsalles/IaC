# Curso Docker DCA 
**Curso 100% Gratuito!**

Material do Curso  

[![caiodelgadonew/docker](https://img.shields.io/github/stars/caiodelgadonew/docker?label=caiodelgadonew%2Fdocker&logo=github&style=for-the-badge)](https://github.com/caiodelgadonew/docker)

Redes Sociais

[![Linktr.ee](https://img.shields.io/website?down_message=caiodelgadonew&label=LINKTR.EE&logo=linktree&style=for-the-badge&up_message=caiodelgadonew&url=https%3A%2F%2Flinktr.ee%2Fcaiodelgadonew)](https://linktr.ee/caiodelgadonew)


O conteúdo será ministrado ao vivo no canal do Youtube

[![Youtube Channel Subscribers](https://img.shields.io/youtube/channel/subscribers/UCQnpN5AUd36lnMHuIl_rihA?label=YOUTUBE&logo=youtube&style=for-the-badge&logoColor=red)](https://www.youtube.com/caiodelgadonew) 

## Preparação do Ambiente

> **IMPORTANTE!** - no momentro que estou escrevendo esse guia o vagrant esta na versão 2.4.3 sem suporte a versão atual o virtualbox 7.1 por isso fazer o download da versao 6.1.48 do virtual ( ultima versão suportado pelo vagrant usando nesse guia)

1. Garantir que o [Intel VMX/VT](https://www.asus.com/br/support/FAQ/1043786/) ou [AMD-V/SVM](https://www.asus.com/br/support/FAQ/1038245/) está habilitado na BIOS

3. Instalar os pacotes:
  - [Virtualbox 6.1](https://www.virtualbox.org/wiki/Download_Old_Builds_6_1)
  - [Vagrant](https://www.vagrantup.com/downloads)
  - [git](https://git-scm.com/download/)

4. Clonar este repositório
```bash
git clone https://github.com/jmsalles/docker.git
```

5. Fazer o Download das Vagrant Boxes
> **IMPORTANTE!** - Link para pesquisa das Boxes Disponveis 
  - [Vagrant Box](https://portal.cloud.hashicorp.com/vagrant/discover?query=ubuntu)
```bash
$ vagrant box add --provider virtualbox ubuntu/focal64
``` 
#a
6. Provisionar as VM no VirtualBox
```bash
# Provisionar todas as VM ndo Vagrantfile
$ vagrant up 
# Provisionar apenas uma VM Especifica Ex master
$ vagrant up master 
``` 

7. Acessar VM Provisionada
```bash
$ vagrant ssh master
``` 

7. Acessar VM Provisionada
```bash
$ vagrant ssh master
``` 

7. Listar as Boxes
```bash
$ vagrant box list
``` 

7. Listar as portas de uma vm
```bash
$ vagrant port node01
``` 

8. Destruir as VM no VirtualBox
```bash
# Destruir todas as VM ndo Vagrantfile
$ vagrant destroy 
# Destruir todas as VM ndo Vagrantfile -sem confirmação
$ vagrant destroy -f
# Provisionar apenas uma VM Especifica Ex master
$ vagrant destroy master 
``` 

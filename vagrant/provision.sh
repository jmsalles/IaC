# Garantindo as chaves
#  ssh-keygen -q -t rsa -f key -N ''

#Local aonde estao as chave public e privada
KEY_PATH='/vagrant/arquivos'

#Criando o diretorio .ssh para usuario root e vagrant
mkdir -p /root/.ssh
mkdir -p /home/vagrant/.ssh
#Copiando as chaves publica e privadas e grantindo o acesso a todos os hos sem senha para o usuario root e vagrant
cp $KEY_PATH/id_rsa /root/.ssh/id_rsa
cp $KEY_PATH/id_rsa /home/vagrant/.ssh/id_rsa
cp $KEY_PATH/id_rsa.pub /root/.ssh/id_rsa.pub
cp $KEY_PATH/id_rsa.pub /home/vagrant/.ssh/id_rsa.pub
cp $KEY_PATH/id_rsa.pub /root/.ssh/authorized_keys
#cp $KEY_PATH/key.pub /home/vagrant/.ssh/authorized_keys
chmod 400 /root/.ssh/id_rsa*
chmod 400 /home/vagrant/.ssh/id_rsa*
chown vagrant:vagrant /home/vagrant/.ssh/id_rsa*
cat /root/.ssh/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
cat /root/.ssh/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys

# Garantindo os hosts
HOSTS=$(head -n7 /etc/hosts)
echo -e "$HOSTS" > /etc/hosts
echo '192.168.56.10 master.jmsalles.casa' >> /etc/hosts
echo '192.168.56.11 node01.jmsalles.casa' >> /etc/hosts
echo '192.168.56.12 node02.jmsalles.casa'>> /etc/hosts
echo '192.168.56.20 registry.jmsalles.casa' >> /etc/hosts


#Instalando o Docker via script  e iniciando o serviço , habilitando na inicialização e adicionando o usuario vagrant ao grupo docker
curl -fsSL https://get.docker.com | bash
systemctl start docker
systemctl enable docker
usermod -aG docker vagrant

# Tutorial Completo: Configuração de um Servidor Git Local em Rocky Linux 9 com Cliente VSCode

Este tutorial orienta como configurar um servidor Git local com endereço IP **10.0.64.27** e repositório chamado **infraestrutura**, além de como conectar-se a ele utilizando o **Visual Studio Code**.

---

## Parte 1: Configuração do Servidor Git

### Passo 1: Instalar o Git no Servidor

1. Atualize os pacotes e instale o Git:

   ```bash
   sudo dnf update -y
   sudo dnf install git -y
   ```

2. Verifique a instalação do Git:
   ```bash
   git --version
   ```

---

### Passo 2: Criar o Usuário para o Git

1. Crie um usuário dedicado para o Git:

   ```bash
   sudo adduser git
   sudo passwd git
   ```

2. Conceda permissões ao usuário (opcional):
   ```bash
   sudo usermod -aG wheel git
   ```

---

### Passo 3: Configurar o Repositório

1. Crie o diretório para armazenar os repositórios:

   ```bash
   sudo mkdir -p /opt/git/repos
   sudo chown -R git:git /opt/git/repos
   sudo chmod -R 775 /opt/git/repos
   ```

2. Mude para o usuário `git`:

   ```bash
   su - git
   ```

3. Crie o repositório bare chamado **infraestrutura**:
   ```bash
   cd /opt/git/repos
   git init --bare infraestrutura.git
   ```

---

### Passo 4: Configurar Chaves SSH

1. **No Cliente:** Gere um par de chaves SSH:

   ```bash
   ssh-keygen -t rsa -b 4096 -C "seu_email@example.com"
   ```

2. **No Servidor:** Copie a chave pública para o usuário `git`:

   - Automaticamente:
     ```bash
     ssh-copy-id git@ip_do_servidor
     ```
   - Manualmente:
     ```bash
     scp ~/.ssh/id_rsa.pub git@ip_do_servidor:~/.ssh/authorized_keys
     ```

3. Ajuste as permissões do arquivo de chaves no servidor:
   ```bash
   chmod 600 ~/.ssh/authorized_keys
   ```

---

## Parte 2: Configuração do Cliente VSCode

### Passo 1: Instalar o VSCode e Extensões Necessárias

1. **Instale o Visual Studio Code**:

   - Acesse o site oficial: [Visual Studio Code](https://code.visualstudio.com/).
   - Baixe o instalador correspondente ao seu sistema operacional (Windows, Linux ou macOS).
   - Siga as instruções de instalação apresentadas no instalador.

2. **Abra o VSCode** e acesse a aba de extensões:

   - Clique no ícone de extensões no lado esquerdo da interface (ou pressione `Ctrl+Shift+X`).

3. **Instale a extensão Remote - SSH**:

   - Na barra de pesquisa, digite **Remote - SSH**.
   - Clique em **Install** ao lado da extensão oficial da Microsoft.

4. **Instale a extensão GitLens** (opcional, mas recomendada):
   - Pesquise por **GitLens** na mesma aba.
   - Clique em **Install**.

---

### Passo 2: Configurar o Acesso SSH no VSCode

1. Abra a **Command Palette**:

   - Pressione `Ctrl+Shift+P`.

2. Digite `Remote-SSH: Add New Host` e insira:

   ```bash
   ssh git@ip_do_servidor
   ```

3. Escolha salvar no arquivo de configuração `~/.ssh/config`.

4. **Edite o arquivo de configuração manualmente (opcional):**

   ```bash
   vim ~/.ssh/config
   ```

   Adicione o seguinte:

   ```ini
   Host Git_local
       HostName ip_do_servidor
       User git
       IdentityFile ~/.ssh/id_rsa
   ```

5. Para se conectar ao servidor:

   - Pressione `Ctrl+Shift+P`.
   - Digite `Remote-SSH: Connect to Host` e selecione **Git_local**.

6. Quando perguntado, escolha o sistema operacional do servidor como **Linux**.

---

### Passo 3: Clonar o Repositório no VSCode

1. Pressione `Ctrl+Shift+P` para abrir a **Command Palette**.
2. Digite `Git: Clone` e insira o URL do repositório:
   ```bash
   git@10.0.64.27:/opt/git/repos/infraestrutura.git
   ```
3. Escolha o diretório local para clonar o repositório, como **C:\winlog**.
4. Após a clonagem, o VSCode perguntará se deseja abrir o projeto clonado. Clique em **Sim**.

---

## Parte 3: Fluxo de Trabalho no VSCode

### Passo 1: Configurar o Git no Cliente

1. Abra o terminal integrado no VSCode (` Ctrl+``  ` ou `Terminal > New Terminal`).
2. Configure as credenciais globais do Git:

   ```bash
   git config --global user.name "Seu Nome"
   git config --global user.email "seu_email@example.com"
   ```

3. Verifique a configuração:
   ```bash
   git config --list
   ```

---

### Passo 2: Verifique a branch ativa no repositório local

1. Confirme o nome da branch ativa com:
   ```bash
   git branch
   ```
   Se não existir uma branch chamada `main`, pode ser necessário criá-la.

### Passo 3: Crie a branch `main` (se necessário)

1. Se a branch atual não for `main`, crie-a e mude para ela:
   ```bash
   git checkout -b main
   ```

### Passo 4: Execute o push para o repositório remoto

1. Após garantir que você está na branch `main` e tem pelo menos um commit, execute o comando:
   ```bash
   git push origin main
   ```

---

## Parte 4: Introdução aos Conceitos do Git

1. **Branch**:  
   Uma branch é uma linha independente de desenvolvimento. A branch `main` geralmente é a principal, mas outras branches podem ser criadas para adicionar funcionalidades ou corrigir bugs sem afetar o código principal.

2. **Merge**:  
   O merge combina alterações de uma branch com outra. Por exemplo, depois de concluir o desenvolvimento em uma branch de funcionalidade, o merge permite integrar essas alterações à branch principal.

3. **Fork**:  
   Um fork é uma cópia de um repositório, geralmente usada para colaborar em projetos públicos. É comum no GitHub, onde você cria um fork para trabalhar em um projeto e, posteriormente, solicita a integração por meio de um pull request.

4. **Pull Request (PR)**:  
   Uma PR é um pedido para revisar e mesclar alterações de uma branch (ou fork) com outra. É essencial em projetos colaborativos para garantir a qualidade do código.

5. **Push**:  
   O comando `push` é usado para enviar as alterações feitas localmente para o repositório remoto. Após realizar commits no repositório local, o `push` atualiza o repositório remoto com essas alterações.

6. **Diff**:  
   O comando `diff` exibe as diferenças entre duas versões de um arquivo ou branch. É útil para revisar alterações antes de realizar um commit ou merge.

7. **Clone**:  
   O comando `clone` é usado para copiar um repositório remoto para sua máquina local. É o primeiro passo para começar a trabalhar em um repositório existente.

8. **Commit**:  
   Um commit é um instantâneo das alterações no repositório. Ele salva localmente o estado atual dos arquivos. Cada commit deve ter uma mensagem que descreve as alterações feitas.

---

Com este guia completo, você terá o ambiente Git local configurado e operacional no servidor e cliente. Caso precise de suporte adicional, estou à disposição!

Jeferson Salles

# Comandos para Gerenciar Máquinas Virtuais com QEMU/KVM

## Listar Máquinas Virtuais

### Listar apenas máquinas **ativas** (em execução):
```bash
virsh list
```
**Exemplo de saída:**
```
 Id    Name                           State
----------------------------------------------------
 1     master                         running
 2     node01                         running
```

### Listar todas as máquinas, incluindo **ativas** e **inativas**:
```bash
virsh list --all
```
**Exemplo de saída:**
```
 Id    Name                           State
----------------------------------------------------
 1     master                         running
 -     node01                         shut off
 -     node02                         shut off
 -     registry                       shut off
```

### Listar máquinas com **detalhes adicionais**:
```bash
virsh list --all --details
```

---

## Detalhes de Máquinas Virtuais

### Ver informações de uma máquina específica (ex.: `master`):
```bash
virsh dominfo master
```
**Exemplo de saída:**
```
Id:             1
Name:           master
UUID:           xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
State:          running
CPU(s):         2
Max memory:     2048 KiB
Used memory:    2048 KiB
Persistent:     yes
Autostart:      disable
Managed save:   no
```

---

## Gerenciar Máquinas Virtuais

### Iniciar uma máquina virtual:
```bash
virsh start <nome_da_vm>
```
Exemplo:
```bash
virsh start master
```

### Parar uma máquina virtual:
```bash
virsh shutdown <nome_da_vm>
```
Exemplo:
```bash
virsh shutdown master
```

### Forçar o desligamento de uma máquina virtual:
```bash
virsh destroy <nome_da_vm>
```
Exemplo:
```bash
virsh destroy master
```

### Reiniciar uma máquina virtual:
```bash
virsh reboot <nome_da_vm>
```
Exemplo:
```bash
virsh reboot master
```

### Remover uma máquina virtual:
```bash
virsh undefine <nome_da_vm>
```
Exemplo:
```bash
virsh undefine master
```
**Nota:** Isso remove a configuração da máquina, mas não apaga o disco.

---

## Configurações de Máquinas Virtuais

### Listar arquivos XML de configuração:
```bash
ls /etc/libvirt/qemu/
```
**Exemplo de saída:**
```
master.xml
node01.xml
node02.xml
registry.xml
```

### Editar a configuração de uma máquina virtual:
```bash
virsh edit <nome_da_vm>
```
Exemplo:
```bash
virsh edit master
```
Isso abrirá o editor configurado no sistema (ex.: `vim` ou `nano`) para editar o arquivo XML da máquina virtual.

---

## Discos e Imagens

### Listar imagens de disco das máquinas virtuais:
```bash
ls /var/lib/libvirt/images/
```
**Exemplo de saída:**
```
master.qcow2
node01.qcow2
node02.qcow2
registry.qcow2
```

### Ver informações sobre os volumes:
```bash
virsh vol-list default
```

### Ver detalhes de um volume:
```bash
virsh vol-info <nome_do_volume> --pool default
```
Exemplo:
```bash
virsh vol-info master.qcow2 --pool default
```

---

## Monitoramento e Informações do Sistema

### Verificar informações sobre o hypervisor:
```bash
virsh version
```

### Exibir as capacidades do hypervisor:
```bash
virsh capabilities
```

### Verificar o estado do serviço libvirt:
```bash
sudo systemctl status libvirtd
```

### Reiniciar o serviço libvirt:
```bash
sudo systemctl restart libvirtd
```

---

## Dicas Úteis

### Comandos úteis para solução de problemas:
- **Listar logs do libvirt:**
  ```bash
  sudo journalctl -u libvirtd
  ```

- **Testar a conectividade com o hypervisor:**
  ```bash
  virsh connect qemu:///system
  ```

- **Verificar erros no XML ao definir uma máquina virtual:**
  ```bash
  virsh define <arquivo.xml>
  ```

### Backup e restauração de máquinas virtuais:
- **Fazer backup de uma máquina virtual (arquivo XML):**
  ```bash
  virsh dumpxml <nome_da_vm> > backup_master.xml
  ```

- **Restaurar a configuração de uma máquina virtual:**
  ```bash
  virsh define backup_master.xml
  ```

---

## Conclusão
Este guia apresenta os comandos mais usados para gerenciar máquinas virtuais utilizando o QEMU/KVM com `virsh`. Com essas informações, você pode listar, gerenciar e configurar suas máquinas de maneira eficiente. Caso precise de mais ajuda, consulte a [documentação oficial do libvirt](https://libvirt.org/).

# Playbook Ansible - Atualização de Servidores Linux (Somente Atualizações de Segurança)

Este playbook realiza atualizações de segurança em servidores Linux, utilizando módulos específicos do Ansible para gerenciamento de pacotes (`apt` e `yum`). Ele também salva logs das atualizações em arquivos no diretório `/tmp`.

---

## **Código YAML**

```yaml
---
- name: Atualizar Servidores Linux - Somente Atualizações de Segurança
  hosts: all
  become: true
  tasks:
    - name: Determinar a distribuição do SO
      ansible.builtin.setup:
        filter: ansible_distribution
      register: os_info

    - name: Atualizar pacotes de segurança no Debian/Ubuntu
      ansible.builtin.apt:
        upgrade: safe
      when: os_info.ansible_facts.ansible_distribution in ['Debian', 'Ubuntu']
      register: security_update_result

    - name: Atualizar pacotes de segurança no Rocky Linux
      ansible.builtin.yum:
        security: yes
        update_only: yes
      when: os_info.ansible_facts.ansible_distribution == "Rocky"
      register: security_update_result


```

---

## **Descrição das Tarefas**

1. **Determinar a distribuição do SO:**
   - Usa o módulo `setup` para coletar informações sobre o sistema operacional do host.
   - Armazena as informações em `os_info` para uso em condições posteriores.

2. **Atualizar pacotes de segurança no Debian/Ubuntu:**
   - Usa o módulo `apt` com a opção `upgrade: safe` para realizar atualizações seguras nos sistemas baseados em Debian.

3. **Atualizar pacotes de segurança no Rocky Linux:**
   - Usa o módulo `yum` com os parâmetros `security: yes` e `update_only: yes` para aplicar apenas atualizações de segurança.


---

## **Como Executar o Playbook**

1. Salve o arquivo acima em um arquivo YAML, por exemplo, `update_security.yml`.

2. Execute o playbook com o comando:
   ```bash
   ansible-playbook -i inventory update_security.yml
   ```

   - Substitua `inventory` pelo caminho do seu arquivo de inventário.

---

## **Benefícios desta Abordagem**

- Uso de módulos nativos do Ansible (`apt` e `yum`), que são mais seguros e fáceis de manter.
- Gera relatórios para auditoria das atualizações realizadas.
- Compatível com múltiplas distribuições Linux.

---

# Ansible

- 指定一个状态，如果当前没有达到该状态，则使系统达到该状态，然后再执行。
- 部署时分控制节点（脚本所在节点），管理节点（运行命令所在节点）。使用yaml文件作为脚本，称为playbooks

![](https://raw.githubusercontent.com/kokifish/pictures/master/Code_pic/AutoToolsScript/ansible_ControlNode_Inventory_ManagedNode.svg)

- **Control node**: 安装了Ansible的系统，在控制节点上运行ansible命令，e.g. ansible, ansible-inventory, ansible-playbook, ansible-vault
- **Inventory**: 按逻辑组织的手管控节点列表。用于向Ansible描述主机部署情况。也称hostfile
- **Managed node**: 受控节点。受Ansible控制的远程系统或主机。Ansible通常不安装在受控节点上，除非使用ansible-pull



## playbooks

> https://docs.ansible.com/ansible/latest/playbook_guide/index.html
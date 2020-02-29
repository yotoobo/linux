# jenkins 集成 openldap

## openldap

先通过 `docker-compose up -d` 启动 openldap 服务, 其中 phpldapadmin 是一个 web 管理界面.

```yaml
version: '3.2'

services:
  openldap:
    image: osixia/openldap:1.3.0
    ports:
      - "389:389"
      - "636:636"
    environment:
      - LDAP_TLS=false
      - LDAP_ORGANISATION=My Inc
      - LDAP_DOMAIN=my-domain.com
    volumes:
      - "./config:/etc/ldap/slapd.d"
      - "./data:/var/lib/ldap"
    container_name: "openldap"
    restart: always

  phpldap:
    image: osixia/phpldapadmin:0.9.0
    ports:
      - "10080:80"
    environment:
      - PHPLDAPADMIN_LDAP_HOSTS=openldap
      - PHPLDAPADMIN_HTTPS=false
    container_name: "phpldap"
    restart: always
```

### OpenLDAP 新增 ou 和 cn

1. 新增 ou
![](https://img.pycoder.org/blog/20200229233616.png)
![](https://img.pycoder.org/blog/20200229233726.png)
![](https://img.pycoder.org/blog/20200229233756.png)
2. 新增 cn
![](https://img.pycoder.org/blog/20200229234039.png)
![](https://img.pycoder.org/blog/20200229234105.png)
![](https://img.pycoder.org/blog/20200229234214.png)
![](https://img.pycoder.org/blog/20200229234254.png)

### Jenkins 安装 LDAP 插件

进入系统管理->插件管理->搜索 LDAP 进行安装.

### Jenkins 配置 LDAP 插件

进入系统管理->全局安全配置.

![](https://img.pycoder.org/blog/20200229234727.png)


### 配置用户权限和项目权限

首先, 安装一下插件: Role-based Authorization Strategy

进入系统管理->全局安全配置, 启用授权策略.

![](https://img.pycoder.org/blog/20200229235313.png)

然后返回系统管理->Manage and Assign Roles.

![](https://img.pycoder.org/blog/20200301000113.png)

在"管理角色"中有三种角色, 一种是和用户相关, 一种是和 Job 相关, 还有一个和节点相关.

根据实际情况, 可以定义不同的用户角色, 比如要执行 Job 权限的, 要管理 Job 权限的. 当然默认已经有一个 admin 的权限,它可以做任何事.

![](https://img.pycoder.org/blog/20200301000625.png)
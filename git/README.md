## Git是什么?
   Git,世界第一的分布式的版本控制系统.

## 你要知道这些 ...
  * 分布存储系统-通常假设你在一个分布存储系统中工作，那真个存储都在你本地的开发框内。Git就是一种分布版本控制系统。如果你需要从存储中查询数据，你可以拉出数据。如果你需要添加或者检查文本到存储中，你可以推进数据。强烈建议，即使不需要用到SSH去和存储交互如果它在一个远程服务其中。
  * 存储-存储是个普遍术语。版本控制系统管理一个存储，在Git中存储实际上就是一个数据库，在那里文本和历史都得到维护和保存。
  * 工作集-工作集包括文件和文件夹。通常你会看到一个存储包含多个工作集，这些工作集组织在通常称作项目中。当你编辑一个工作集时，你顺带地就会升级存储。版本控制最重要的事情就是，当你升级你的存储时，你自动地创建了一个源代码支持，不仅是保存。关于工作集有一点需要记住的是，文件包含潜在的变化已不在存储中了。
  * 添加和检入-正如你猜测的那样，添加是一个概念，即你添加新的文件或者提交和查找存在的文件。
  * 返回/回滚-如果你需要返回到早前的文件版本，你将会返回或者回滚在存储中任何版本的工作集。
  * 检出-如果你正在检出存储中的一个文件，通常你会将主干带入你当地的工作集中。在一些案例中，检出一个文件的活动或锁住这个文件，以防其他的开发者使用。
  * 标签和标记-此概念用来说明一个具体存储的状态。你或许标签或者标记了一个你的Drupal模块版本，你认为可以稳定发布的。
  * 分支和分叉-这是一个常见的概念，即创建一个完整的存储拷贝。通常，你会听到一个沙盒代码的术语，它的意思是一个开发者已经分支或者分叉了一个项目存储。
  * 合并-如果你分支或者分叉了一个存储，那么你将不可避免地想要把你的源代码推送到存储的主干或者主要分支中。推送分支或者分叉代码返回主干的过程，就是指调用合并。

## 菜鸟Giter  
* [Install Git](http://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

* Config and help  
_这些是一些通用配置项,请根据个人情况自行修改._  
``` $ git config --global user.name "yotoobo" 
    $ git config --global user.email yotoobo@gmail.com  
    $ git config --global core.editor vim  
    $ git Config --global push.default simple  ```  

获取某一命令的帮助信息  
```$ git help add ```

* Getting and Create Projects  
创建一个本地空仓库  
``` $ cd /path/to/targetDir  
    $ git init ```  
克隆一个已存在的仓库  
``` $ git clone ssh://[user@]host.xz[:port]/path/to/repo.git/
    $ git clone git://host.xz[:port]/path/to/repo.git/
    $ git clone http[s]://host.xz[:port]/path/to/repo.git/
    $ git clone -l -s -n . ../copy ```

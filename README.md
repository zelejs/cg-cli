# 自动生成 CRUD 代码工具

## Install

```shell
$ git clone https://github.com/kequandian/cg-cli
$ npm i -g
```

## Usage
```shell
Usage:
    cg-cli <OPTIONS> [-h|--help] [--gen] [--module] <module>
eg. cg-cli crud one t_device --gen --module device

PARAMETERS:
    --gen      parameter for generating the code effectively
    --module   parameter for setting the module name at runtime

 OPTIONS:
    cg-cli module get
    cg-cli module set <module-name>
    cg-cli db get url
    cg-cli db set url <database> [localhost] [3306] [root] [root]
    cg-cli db sanity [url]
    cg-cli db run sql [/path/to/schema.sql] [param] ...
    cg-cli db show tables
    cg-cli db show create table <table-name>
    cg-cli db gen token <data-url> <user>
    cg-cli db gen perms <data-url> <user>
    cg-cli crud reset
    cg-cli crud one      <master> [...]
    cg-cli crud onemany  <master> <slave:mid> [slave:mid1,mid2] [slave:relation::mid:id] [...]
    cg-cli crud group    <group> [...]
    cg-cli crud groupby  <group> <groupBy> <groupId>
    cg-cli test crud one
    cg-cli test crud onemany
    cg-cli test crud onemany x2
    cg-cli test crud group
    cg-cli test crud groupby
    cg-cli test crud groupby field
    cg-cli build init table <table-name> [...]
    cg-cli build crud xml [/path/to/cruds.xml]
```

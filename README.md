# 自动生成 CRUD 代码工具

## Install

```shell
$ git clone https://github.com/kequandian/cg-cli
$ npm i -g
```

## Usage
```shell
Usage:
    cg-cli <OPTIONS> [-h|--help] [--gen] [--module <module>]
eg. cg-cli crud one t_device --gen --module device

PARAMETERS:
    --gen      parameter for generating the code effectively
    --module   mandatory parameter with --gen for setting the module name at runtime

 OPTIONS:
    cg-cli crud reset
    cg-cli crud one      <master> [...]
    cg-cli crud onemany  <master> <slave:mid> [slave:mid1,mid2] [slave:relation::mid:id] [...]
    cg-cli crud group    <group> [...]
    cg-cli crud groupby  <group> <groupBy> <groupId>
    cg-cli crud xml [/path/to/cruds.xml]
    cg-cli crud fix table <table-name> [...]
    cg-cli test crud one
    cg-cli test crud onemany
    cg-cli test crud onemany x2
    cg-cli test crud group
    cg-cli test crud groupby
    cg-cli test crud groupby field
```

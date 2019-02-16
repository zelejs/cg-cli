# 自动生成 CRUD 代码工具

## Install
$ npm i -g 

## Usage

    cg-cli [OPTIONS] --help --gen
    cg-cli module get
    cg-cli module set <module-name> [parent-module]
    cg-cli db get config
    cg-cli db set config <database> [localhost] [3306] [root] [root]
    cg-cli db sanity
    cg-cli db run sql [/path/to/schema.sql]
    cg-cli db show tables
    cg-cli db show create table <table-name>
    cg-cli crud reset
    cg-cli crud one      <master> [...]
    cg-cli crud onemany  <master> <slave:mid:id> [slave:mid1,mid2] [slave:relation::mid:id] [...]
    cg-cli crud manymany <master> <peer> <relation>
    cg-cli crud group    <group> [...]
    cg-cli crud groupby  <group> <groupBy> <groupId>
    cg-cli crud init table <table-name> [...]
    cg-cli crud -f       </path/to/cruds.xml>
    cg-cli test crud one
    cg-cli test crud onemany
    cg-cli test crud onemany x2
    cg-cli test crud manymany
    cg-cli test crud group
    cg-cli test crud groupby
    cg-cli test crud groupby field

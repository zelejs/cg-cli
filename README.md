# 自动生成 CRUD 代码工具

## Install
$ npm i -g 

## Usage

    cg-cli [-h] [--help] [--gen]
    cg-cli config <database> [localhost] [3306] [root] [root]
    cg-cli config module <module-name> [parent-module]
    cg-cli sanity
    cg-cli show tables
    cg-cli show create table <table-name>
    cg-cli initialize tables <table-name> [...]
    cg-cli crud one      <master> [...]
    cg-cli crud onemany  <master> <slave:mid> [...]
    cg-cli crud manymany <master> <peer> <relation>
    cg-cli crud group    <group> [...]
    cg-cli crud groupby  <group> <groupBy> <groupId>
    cg-cli test run sql [/path/to/schema.sql]
    cg-cli test crud one
    cg-cli test crud onemany
    cg-cli test crud onemany x2
    cg-cli test crud manymany
    cg-cli test crud group
    cg-cli test crud groupby

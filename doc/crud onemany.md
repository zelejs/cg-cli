## crud onemany

生成带有 一对多 关系的表。

### 单字段一对多

主表与从表分别通过一个字段来形成一对多关系。

```shell
cg-cli crud onemany master_table slave_table:mid:id
```

预期结果：

```
<cruds>
    <crud>
        <mask>master</mask>
        <master>master_table</master>
        <masterId>mid:id</masterId>
        <slaves>
            <slave>slave_table</slave>
        </slaves>
    </crud>
</cruds>

<tables>
    <table>slave_table</table>
</tables>
```

其中

*  `mid` 是从表中与主表关联的字段

* `id` 是主表中与从表关联的字段



### 复合字段一对多

常用于 主表与从表之间通过复合主键来形成一对多关系 的情况。

```shell
cg-cli crud onemany master_table slave_table:mid_1,mid_2
```

预期结果：

```
<cruds>
    <crud>
        <mask>master</mask>
        <master>master_table</master>
        <masterId>mid_1,mid_2</masterId>
        <slaves>
            <slave>slave_table</slave>
        </slaves>
    </crud>
</cruds>

<tables>
    <table>slave_table</table>
</tables>
```

其中：

* 约定：主表与从表必须要有相同字段名的符合键
* `mid_1` 与 `mid_2` 即为符合键的字段名



### 关联表一对多

主表与从表之间，通过第三张表(关系表)来构成一对多关系。

```shell
cg-cli crud onemany master_table slave_table:relation_table::mid:id
```

预期结果：

```
<cruds>
    <crud>
        <mask>master</mask>
        <master>master_table</master>
        <masterId>relation_table::mid:id</masterId>
        <slaves>
            <slave>slave_table</slave>
        </slaves>
    </crud>
</cruds>

<tables>
    <table>slave_table</table>
    <table>relation_table</table>
</tables>
```

其中：

* `relation_table` 为关系表的表名
* `mid` 为主表的主键
* `id` 为从表的主键



### 生成代码

确定无误的话，追加 `--gen` 参数来生成代码：

```
cg-cli crud onemany master_table slave_table:mid:id --gen
```


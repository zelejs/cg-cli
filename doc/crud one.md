## crud one

生成普通单表



```shell
cg-cli crud one test_table_name
```

预期结果：

```
<cruds>
    <crud>
        <mask>master</mask>
        <master>test_table_name</master>
    </crud>
</cruds>
```

### 生成代码

确定无误的话，追加 `--gen` 参数来生成代码：

```
cg-cli crud one test_table_name --gen
```


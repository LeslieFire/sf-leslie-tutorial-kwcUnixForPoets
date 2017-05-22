#!/bin/bash

# 取出最后一列
awk -F "|" '{print $5}' ../data/products/products.txt > ../data/products/products.dat

# 不包含任何分隔符的品牌名
cat ../data/products/products.dat | grep  -v '[ \(（\/]' > ../data/products/products.sig

# 包含各种分隔符的数据，each field one line
cat ../data/products/products.dat | grep  '[ \(（\/]' |sed -e 's/\s\+/\n/g;s/（/\n/g; s/）//g; s/\//\n/g; s/(/\n/g; s/)//g' > ../data/products/products.sigs

# 合并
cat ../data/products/products.sigs ../data/products/products.sig > ../data/products/products.d

# 去重
cat ../data/products/products.d | sort | uniq > tmp

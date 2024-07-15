#!/bin/bash

# 提示用户输入命令
read -p "请输入要执行的命令: " command

# 提示用户输入数字 n
read -p "请输入执行命令的次数 n: " n

# 检查 n 是否为一个正整数
if ! [[ "$n" =~ ^[0-9]+$ ]]; then
  echo "请输入一个有效的正整数 n"
  exit 1
fi

# 执行命令 n 次
for ((i=1; i<=n; i++))
do
  output=$($command 2>&1)
  echo "$output"
  
  # 检查输出中是否包含 "Fatal"
  if echo "$output" | grep -q "Fatal"; then
    echo "检测到 'Fatal'，停止执行"
    exit 1
  fi
done

echo "完成了 $n 次"


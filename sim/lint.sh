#!/bin/bash
###
 # @FilePath       : /OPU_Tile2.0/sim/lint.sh
 # @Author         : ZhouZiheng ziheng.zhou.1999@qq.com
 # @CreateDate     : 24-01-22
 # @LastEditors    : ZhouZiheng ziheng.zhou.1999@qq.com
 # @LastEditTime   : 24-01-23
 # Version        :
 # @Description    : 
 #                  
 # 
 # Parameter       :
 #                  
 # 
 # IO Port         :
 #                  
 # 
 # Modification History
 #    Date   |   Author   |   Version   |   Change Description
 # ==============================================================================
 #  23-08-24 |     NJU    |     0.1     | Original Version
 #                  
 # 
### 

#!/bin/bash

# 使用通配符匹配任何以"_compile.log"结尾的文件
file_path=$(find . -type f -name "*_compile.log")

# 检查是否找到文件
if [ -z "$file_path" ]; then
    echo "Error: No compile log found!"
    exit 1
fi

echo "================== Lint Report =================="
# 使用awk命令提取Lint报错类型，并统计每个类型的数量
lint_types=$(awk -F'[][]' '/Lint-\[/{print $2}' "$file_path" | sort | uniq)
for lint_type in $lint_types
do
    count=$(grep -c "Lint-\[$lint_type\]" "$file_path")
    echo "Lint-[$lint_type]: $count occurrences"
done

echo "================== End of Lint Report =================="

# 使用通配符匹配任何以"_compile.log"结尾的文件
#file_path_2=$(find ./run -type f -name "race.out.static")
file_path_2=./run/race.out.static
echo "================== Race Check Report =================="
# 检查是否找到文件
if [ -z "$file_path_2" ]; then
    echo "Warning: No Race Check log found! SV_ENABLE Option might be enabled during compilation."
    exit 1
fi

race_types=$(awk -F'[][]' '/Race-\[/{print $2}' "$file_path_2" | sort | uniq)
for race_types in $race_types
do
    count2=$(grep -c "Lint-\[$race_types\]" "$file_path_2")
    echo "Lint-[$race_types]: $count2 occurrences"
done

echo "================== End of Race Check Report =================="
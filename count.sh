#!/bin/bash
###################
read  -p  '请输入项目名称：'   name
read  -p  '请输入要统计的代码路径：'   path
read  -p  '数据库版本(mysql/oracle)：' sqlstate

if [ -z "$path" ] || [ -z "$sqlstate" ];then
  echo "你倒是输入参数啊！"
  exit 1
elif [ "$sqlstate" != "mysql" ] && [ "$sqlstate" != "oracle" ];then
  echo "数据库版本请输入mysql或oracle"
  exit 2
fi

if [[ -f $path/$name-count.txt ]];then
  rm -f $path/$name-count.txt
fi

for i in {"*.gradle","*.xml","*.sql","*.java","*.properties","*.js","*.html","Abstract*.java","*VO.java","*BaseSQL.xml","*BaseSQL_"$sqlstate".xml",}
  do
    find "$path" -name "$i" | xargs ls -l |gawk '{print $5}' |gawk 'BEGIN {SUM=0} {SUM+=$1} END {print SUM}' >> $path/"$i"-4.txt
    for l in `find "$path" -name "$i"`
      do
        sed -n '/^\s*$/p' $l |wc -l >> $path/"$i"-1.txt
        sed -n "/^\s*\//p" $l | wc -l >> $path/"$i"-2.txt
        sed -n "/^\s*#/p" $l | wc -l >> $path/"$i"-2.txt
        sed -n "/^\s*\*/p" $l | wc -l >> $path/"$i"-2.txt
        grep -Pzo '<!(.|[\r\n])*?>' $l | wc -l >> $path/"$i"-2.txt
        cat $l | wc -l >> $path/"$i"-3.txt

        if [[ -f $path/"$i"-1.txt ]];then
          a=`cat $path/"$i"-1.txt | awk '{sum+=$1} END {print sum}'`
        else
          a=0
        fi

        if [[ -f $path/"$i"-2.txt ]];then
          b=`cat $path/"$i"-2.txt | awk '{sum+=$1} END {print sum}'`
        else
          b=0 
        fi

        if [[ -f $path/"$i"-3.txt ]];then
          c1=`cat $path/"$i"-3.txt | awk '{sum+=$1} END {print sum}'`
          num=`find "$path" -name "$i" |wc -l`
          c=$[ $c1 + $num ]
            if [[ "${i}" =~ gradle$ ]];then
              c=$[ $c - 1 ]
            fi
        else
          c1=0
          num=0
          c=0
        fi

        d=$[$c - $b - $a]
        e=`cat $path/"$i"-4.txt`
      done

cat << EOF >> $name-count.txt
"$i"
文件数：     $num
文件大小:    $e
总代码行数:  $c
代码行数:    $d
注释行数:    $b
空行数:      $a

EOF

    rm -f $path/"$i"-1.txt $path/"$i"-2.txt $path/"$i"-3.txt $path/"$i"-4.txt

  done

cat $PWD/$name-count.txt
###################

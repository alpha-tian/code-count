#!/bin/bash
###################
read  -p  '请输入要统计的代码路径：'   path
read  -p  '数据库版本(mysql/oracle)：' sqlstate

if [ -z "$path" ] || [ -z "$sqlstate" ];then
  echo "你倒是输入参数啊！"
  exit 1
fi

if [[ -f $path/count.txt ]];then
  rm -f $path/count.txt
fi

for i in {"*.gradle","*.xml","*.sql","*.java","*.properties","*.js","*.html","Abstract*.java","*VO.java","*BaseSQL.xml","*BaseSQL_"$sqlstate".xml",}
  do

    for l in `find "$path" -name "$i"`
      do
        sed -n '/^\s*$/p' $l |wc -l >> $path/"$i"-1.txt
        sed -n "/^\s*\//p" $l | wc -l >> $path/"$i"-2.txt
        sed -n "/^\s*#/p" $l | wc -l >> $path/"$i"-2.txt
        sed -n "/^\s*\*/p" $l | wc -l >> $path/"$i"-2.txt
        grep -Pzo '<!(.|[\r\n])*?>' $l | wc -l >> $path/"$i"-2.txt
        cat $l | wc -l >> $path/"$i"-3.txt

        a=`cat $path/"$i"-1.txt | awk '{sum+=$1} END {print sum}'`
        b=`cat $path/"$i"-2.txt | awk '{sum+=$1} END {print sum}'`
        c=`cat $path/"$i"-3.txt | awk '{sum+=$1} END {print sum}'`

        if [[ "${i}" =~ java$ ]];then
          c=$[ $c + 1 ]
        fi

        d=$[$c - $b - $a]

      done

cat << EOF >> count.txt
"$i"
总代码行数:  $c
空行数:      $a
注释行数:    $b
代码行数:    $d

EOF

    rm -f $path/"$i"-1.txt $path/"$i"-2.txt $path/"$i"-3.txt

  done

cat $path/count.txt
###################

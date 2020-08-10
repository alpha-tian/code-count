#!/bin/bash
###################
#read  -p  '请输入项目名称：'   name
#read  -p  '请输入要统计的代码路径：'   path
#read  -p  '数据库版本(mysql/oracle)：' sqlstate
date=`date +%Y%m%d`

if [[ ! $3 ]];then
  echo "错误，已退出"
  exit 168
else
  echo "开始执行..."

  if [ -z "$2" ] || [ -z "$3" ];then
    echo "你倒是输入参数啊！"
    exit 1
  elif [ "$3" != "mysql" ] && [ "$3" != "oracle" ];then
    echo "数据库版本请输入mysql或oracle"
    exit 2
  fi
  
  if [[ -f $PWD/$1-count.txt ]];then
    rm -f $PWD/$1-count.txt
  fi
 
  if [[ -f $PWD/$1-$date-count2.txt ]];then
    rm -f $PWD/$1-$date-count2.txt
  fi
 
  for i in {"*.xml","*.sql","*.java","*.properties","*.js","*.gradle","*.html","Abstract*.java","*VO.java","*BaseSQL.xml","*BaseSQL_"$3".xml"}
    do
      find "$2" -name "$i" | xargs ls -l | gawk '{print $5}' | gawk 'BEGIN {SUM=0} {SUM+=$1} END {print SUM}' >> $2/"$i"-4.txt
      for l in `find "$2" -name "$i"`
        do
          sed -n '/^\s*$/p' $l |wc -l >> $2/"$i"-1.txt
          sed -n "/^\s*\//p" $l | wc -l >> $2/"$i"-2.txt
          sed -n "/^\s*#/p" $l | wc -l >> $2/"$i"-2.txt
          sed -n "/^\s*\*/p" $l | wc -l >> $2/"$i"-2.txt
          grep -Pzo '<!(.|[\r\n])*?>' $l | wc -l >> $2/"$i"-2.txt
          cat $l | wc -l >> $2/"$i"-3.txt
  
          if [[ -f $2/"$i"-1.txt ]];then
            a=`cat $2/"$i"-1.txt | awk '{sum+=$1} END {print sum}'`
          else
            a=0
          fi
  
          if [[ -f $2/"$i"-2.txt ]];then
            b=`cat $2/"$i"-2.txt | awk '{sum+=$1} END {print sum}'`
          else
            b=0 
          fi
  
          if [[ -f $2/"$i"-3.txt ]];then
            c1=`cat $2/"$i"-3.txt | awk '{sum+=$1} END {print sum}'`
            num=`find "$2" -name "$i" |wc -l`
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
          e=`cat $2/"$i"-4.txt`

        done
            
            echo $d >> $2/$1-$date-code.txt
 
cat << EOF >> $1-$date-count.txt
"$i"
文件数：     $num
文件大小:    $e
总代码行数:  $c
代码行数:    $d
注释行数:    $b
空行数:      $a

EOF

    num=0
    a=0
    b=0
    c=0
    d=0
    e=0

      rm -f $2/"$i"-1.txt $2/"$i"-2.txt $2/"$i"-3.txt $2/"$i"-4.txt
  
    done

  sed -i '5d' $2/$1-$date-code.txt
  f=`cat $2/$1-$date-code.txt | awk 'NR==1,NR==6{sum+=$1} END {print sum}'`
  g=`cat $2/$1-$date-code.txt | awk 'NR==4,NR==10{sum+=$1} END {print sum}'`

  echo -e "代码行数1:\t$f" > $PWD/$1-$date-count2.txt 
  echo -e "代码行数2:\t$g" >> $PWD/$1-$date-count2.txt

  cat $PWD/$1-$date-count.txt
  cat $PWD/$1-$date-count2.txt
  rm -f $2/$1-$date-code.txt

  fi

###################

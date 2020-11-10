#!/bin/bash
date=`date +%Y%m%d`
sql_type_num=`find $2 -name "*oracle*" | wc -l`
if [[ sql_type_num -gt 0 ]];then
  sqltype="oracle"
else
  sqltype="mysql"
fi

for i in `find $2 -type f`
  do
    end=`ls $i | awk -F "/" '{print $(NF)}' | awk -F"." '{print $(NF)}'`
    echo $end | egrep "xml|sql|java|properties|js|gradle|html" > /dev/null
      if [[ $? -eq 0 ]];then
        sed -n '/^\s*$/p' $i | wc -l >> $2/"$end"-1.txt			#空行数
        sed -n "/^\s*\//p" $i | wc -l >> $2/"$end"-2.txt		#以/开头的注释
        sed -n "/^\s*#/p" $i | wc -l >> $2/"$end"-2.txt			#以#开头的注释
        sed -n "/^\s*\*/p" $i | wc -l >> $2/"$end"-2.txt		#以*开头的注释
        grep -Pzo '<!(.|[\r\n])*?>' $i | wc -l >> $2/"$end"-2.txt	#以<!开头的注释
        cat $i | wc -l >> $2/"$end"-3.txt				#文件行数
        echo $i | xargs ls -l | gawk '{print $5}' >> $2/"$end"-4.txt	#文件大小
        echo 1 >> $2/"$end"-5.txt					#文件数
      fi
  done

  for j in {"Abstract*.java","*VO.java","*BaseSQL.xml","*BaseSQL*$sqltype\.xml"}
    do
      for k in `find "$2" -name "$j"`
        do
          sed -n '/^\s*$/p' $k | wc -l >> $2/"$j"-1.txt                 #空行数
          sed -n "/^\s*\//p" $k | wc -l >> $2/"$j"-2.txt                #以/开头的注释
          sed -n "/^\s*#/p" $k | wc -l >> $2/"$j"-2.txt                 #以#开头的注释
          sed -n "/^\s*\*/p" $k | wc -l >> $2/"$j"-2.txt                #以*开头的注释
          grep -Pzo '<!(.|[\r\n])*?>' $k | wc -l >> $2/"$j"-2.txt       #以<!开头的注释
          cat $k | wc -l >> $2/"$j"-3.txt                               #文件行数
          echo $k | xargs ls -l | gawk '{print $5}' >> $2/"$j"-4.txt    #文件大小
          echo 1 >> $2/"$j"-5.txt                                       #文件数
        done
    done

for l in {"xml","sql","java","properties","js","gradle","html","Abstract*.java","*VO.java","*BaseSQL.xml","*BaseSQL*$sqltype\.xml"}
  do
          if [[ -f $2/"$l"-1.txt ]];then
            cat $2/"$l"-1.txt | awk '{sum+=$1} END {print sum}' >> $2/"$l"-sum1.txt	#空行数汇总
          else
            echo 0 >> $2/"$l"-sum1.txt
          fi

          if [[ -f $2/"$l"-2.txt ]];then
            cat $2/"$l"-2.txt | awk '{sum+=$1} END {print sum}' >> $2/"$l"-sum2.txt 	#注释行数汇总
          else
            echo 0 >> $2/"$l"-sum2.txt
          fi

          if [[ -f $2/"$l"-3.txt ]];then
            cat $2/"$l"-3.txt | awk '{sum+=$1} END {print sum}' >> $2/"$l"-sum3.txt	#文件行数汇总
          else
            echo 0 >> $2/"$l"-sum3.txt
          fi

          if [[ -f $2/"$l"-4.txt ]];then
            cat $2/"$l"-4.txt | awk '{sum+=$1} END {print sum}' >> $2/"$l"-sum4.txt     #文件大小汇总
          else
            echo 0 >> $2/"$l"-sum4.txt
          fi

          if [[ -f $2/"$l"-5.txt ]];then
            cat $2/"$l"-5.txt | awk '{sum+=$1} END {print sum}' >> $2/"$l"-sum5.txt     #文件数汇总
          else
            echo 0 >> $2/"$l"-sum5.txt
          fi
  done

for m in {"xml","sql","java","properties","js","gradle","html","Abstract*.java","*VO.java","*BaseSQL.xml","*BaseSQL*$sqltype\.xml"}
  do
num=`cat $2/"$m"-sum5.txt`
e=`cat $2/"$m"-sum4.txt`
c=`cat $2/"$m"-sum3.txt`
b=`cat $2/"$m"-sum2.txt`
a=`cat $2/"$m"-sum1.txt`
d=$[$c - $b - $a]

echo $d >> $2/$1-$date-code.txt

cat << EOF >> $1-$date-count.txt
"$m"
文件数：     $num
文件大小:    $e
总代码行数:  $c
代码行数:    $d
注释行数:    $b
空行数:      $a

EOF
      rm -f $2/"$m"-1.txt $2/"$m"-2.txt $2/"$m"-3.txt $2/"$m"-4.txt $2/"$m"-5.txt $2/"$m"-sum1.txt $2/"$m"-sum2.txt $2/"$m"-sum3.txt $2/"$m"-sum4.txt $2/"$m"-sum5.txt

num=0
e=0
c=0
b=0
a=0
d=0

  done

  sed -i '5d' $2/$1-$date-code.txt
  f=`cat $2/$1-$date-code.txt | awk 'NR==1,NR==6{sum+=$1} END {print sum}'`
  g=`cat $2/$1-$date-code.txt | awk 'NR==4,NR==10{sum+=$1} END {print sum}'`

  echo -e "总代码行数:\t\t$f" > $PWD/$1-$date-count2.txt
  echo -e "平台生成代码行数:\t$g" >> $PWD/$1-$date-count2.txt

  cat $PWD/$1-$date-count.txt
  cat $PWD/$1-$date-count2.txt

  rm -f $2/$1-$date-code.txt

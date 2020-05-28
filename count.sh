#!/bin/bash
read  -p  '请输入要统计的代码路径：'  path
#GRADLE
for i in `find $path -name '*.gradle'`
do
	sed -n '/^\s*$/p' $i |wc -l >> $path/g3.txt
	sed -n "/^\s*\//p" $i | wc -l >> $path/g4.txt
	sed -n "/^\s*#/p" $i | wc -l >> $path/g4.txt
	sed -n "/^\s*\*/p" $i | wc -l >> $path/g4.txt
	grep -Pzo '<!(.|[\r\n])*?>' $i | wc -l >> $path/g4.txt
	cat $i | wc -l >> $path/g5.txt
done
ga=`cat $path/g3.txt | awk '{sum+=$1} END {print sum}'`
gb=`cat $path/g4.txt | awk '{sum+=$1} END {print sum}'`
gc=`cat $path/g5.txt | awk '{sum+=$1} END {print sum}'`
gd=$[$gc - $gb - $ga]
echo '' > $path/g3.txt
echo '' > $path/g4.txt
echo '' > $path/g5.txt
rm -f $path/g3.txt
rm -f $path/g4.txt
rm -f $path/g5.txt

#XML
for i in `find $path -name '*.xml'`
do
        sed -n '/^\s*$/p' $i |wc -l >> $path/x3.txt
        sed -n "/^\s*\//p" $i | wc -l >> $path/x4.txt
        sed -n "/^\s*#/p" $i | wc -l >> $path/x4.txt
        sed -n "/^\s*\*/p" $i | wc -l >> $path/g4.txt
        grep -Pzo '<!(.|[\r\n])*?>' $i | wc -l >> $path/x4.txt
        cat $i | wc -l >> $path/x5.txt
done
xa=`cat $path/x3.txt | awk '{sum+=$1} END {print sum}'`
xb=`cat $path/x4.txt | awk '{sum+=$1} END {print sum}'`
xc=`cat $path/x5.txt | awk '{sum+=$1} END {print sum}'`
xd=$[$xc - $xb - $xa]
echo '' > $path/x3.txt
echo '' > $path/x4.txt
echo '' > $path/x5.txt
rm -f $path/x3.txt
rm -f $path/x4.txt
rm -f $path/x5.txt

#SQL
for i in `find $path -name '*.sql'`
do
        sed -n '/^\s*$/p' $i |wc -l >> $path/s3.txt
        sed -n "/^\s*\//p" $i | wc -l >> $path/s4.txt
        sed -n "/^\s*#/p" $i | wc -l >> $path/s4.txt
        sed -n "/^\s*\*/p" $i | wc -l >> $path/g4.txt
        grep -Pzo '<!(.|[\r\n])*?>' $i | wc -l >> $path/s4.txt
	cat $i | wc -l >> $path/s5.txt
done
sa=`cat $path/s3.txt | awk '{sum+=$1} END {print sum}'`
sb=`cat $path/s4.txt | awk '{sum+=$1} END {print sum}'`
sc1=`cat $path/s5.txt | awk '{sum+=$1} END {print sum}'`
sc=$[ $sc1 + 1 ]
sd=$[$sc - $sb - $sa]
echo '' > $path/s3.txt
echo '' > $path/s4.txt
echo '' > $path/s5.txt
rm -f $path/s3.txt
rm -f $path/s4.txt
rm -f $path/s5.txt

#JAVA
for i in `find $path -name '*.java'`
do
        sed -n '/^\s*$/p' $i |wc -l >> $path/j3.txt
        sed -n "/^\s*\//p" $i | wc -l >> $path/j4.txt
        sed -n "/^\s*#/p" $i | wc -l >> $path/j4.txt
        sed -n "/^\s*\*/p" $i | wc -l >> $path/g4.txt
        grep -Pzo '<!(.|[\r\n])*?>' $i | wc -l >> $path/j4.txt
        cat $i | wc -l >> $path/j5.txt
done
ja=`cat $path/j3.txt | awk '{sum+=$1} END {print sum}'`
jb=`cat $path/j4.txt | awk '{sum+=$1} END {print sum}'`
jc1=`cat $path/j5.txt | awk '{sum+=$1} END {print sum}'`
jc=$[ $jc1 + 1 ]
jd=$[$jc - $jb - $ja]
echo '' > $path/j3.txt
echo '' > $path/j4.txt
echo '' > $path/j5.txt
rm -f $path/j3.txt
rm -f $path/j4.txt
rm -f $path/j5.txt

#PROPERTIES
for i in `find $path -name '*.properties'`
do
        sed -n '/^\s*$/p' $i |wc -l >> $path/p3.txt
        sed -n "/^\s*\//p" $i | wc -l >> $path/p4.txt
        sed -n "/^\s*#/p" $i | wc -l >> $path/p4.txt
        sed -n "/^\s*\*/p" $i | wc -l >> $path/g4.txt
        grep -Pzo '<!(.|[\r\n])*?>' $i | wc -l >> $path/p4.txt
        cat $i | wc -l >> $path/p5.txt
done
pa=`cat $path/p3.txt | awk '{sum+=$1} END {print sum}'`
pb=`cat $path/p4.txt | awk '{sum+=$1} END {print sum}'`
pc=`cat $path/p5.txt | awk '{sum+=$1} END {print sum}'`
pd=$[$pc - $pb - $pa]
echo '' > $path/p3.txt
echo '' > $path/p4.txt
echo '' > $path/p5.txt
rm -f $path/p3.txt
rm -f $path/p4.txt
rm -f $path/p5.txt

#JS
for i in `find $path -name '*.js'`
do
        sed -n '/^\s*$/p' $i |wc -l >> $path/js3.txt
        sed -n "/^\s*\//p" $i | wc -l >> $path/js4.txt
        sed -n "/^\s*#/p" $i | wc -l >> $path/js4.txt
        sed -n "/^\s*\*/p" $i | wc -l >> $path/g4.txt
        grep -Pzo '<!(.|[\r\n])*?>' $i | wc -l >> $path/js4.txt
        cat $i | wc -l >> $path/js5.txt
done
jsa=`cat $path/js3.txt | awk '{sum+=$1} END {print sum}'`
jsb=`cat $path/js4.txt | awk '{sum+=$1} END {print sum}'`
jsc=`cat $path/js5.txt | awk '{sum+=$1} END {print sum}'`
jsd=$[$jsc - $jsb - $jsa]
echo '' > $path/js3.txt
echo '' > $path/js4.txt
echo '' > $path/js5.txt
rm -f $path/js3.txt
rm -f $path/js4.txt
rm -f $path/js5.txt

#HTML
for i in `find $path -name '*.html'`
do
        sed -n '/^\s*$/p' $i |wc -l >> $path/h3.txt
        sed -n "/^\s*\//p" $i | wc -l >> $path/h4.txt
        sed -n "/^\s*#/p" $i | wc -l >> $path/h4.txt
        sed -n "/^\s*\*/p" $i | wc -l >> $path/g4.txt
        grep -Pzo '<!(.|[\r\n])*?>' $i | wc -l >> $path/h4.txt
        cat $i | wc -l >> $path/h5.txt
done
ha=`cat $path/h3.txt | awk '{sum+=$1} END {print sum}'`
hb=`cat $path/h4.txt | awk '{sum+=$1} END {print sum}'`
hc=`cat $path/h5.txt | awk '{sum+=$1} END {print sum}'`
hd=$[$hc - $hb - $ha]
echo '' > $path/h3.txt
echo '' > $path/h4.txt
echo '' > $path/h5.txt
rm -f $path/h3.txt
rm -f $path/h4.txt
rm -f $path/h5.txt

echo "
gradle
总代码行数:  $gc
空行数:      $ga
注释行数:    $gb
代码行数:    $gd


xml
总代码行数:  $xc
空行数:      $xa
注释行数:    $xb
代码行数:    $xd


sql
总代码行数:  $sc
空行数:      $sa
注释行数:    $sb
代码行数:    $sd


java
总代码行数:  $jc
空行数:      $ja
注释行数:    $jb
代码行数:    $jd


properties
总代码行数:  $pc
空行数:      $pa
注释行数:    $pb
代码行数:    $pd


js
总代码行数:  $jsc
空行数:      $jsa
注释行数:    $jsb
代码行数:    $jsd


html
总代码行数:  $hc
空行数:      $ha
注释行数:    $hb
代码行数:    $hd
"

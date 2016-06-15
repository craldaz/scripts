let var=0
for i in $(seq $1 -1 1); 
do 
  let "var++"  
  let num=$var+$1
  ID=`printf "%0*d\n" 3 $i`
  ID2=`printf "%0*d\n" 3 $num`
  echo "copying" mol$ID.gif "to" mol${ID2}.gif 
  cp -f mol$ID.gif mol${ID2}.gif 
done


for i in $(seq 1 1 $num);
do
  ID=`printf "%0*d\n" 3 $i`
  echo "cropping mol$ID, new file is called cropped$ID"
  convert mol$ID.gif -coalesce -repage 0x0 -crop 800x725+0+75 +repage cropped$ID.gif 
  convert cropped$ID.gif -fuzz XX% -transparent black result$ID.gif 
done
convert -delay 25 -loop 0 -alpha set -dispose previous result*.gif movie.gif 

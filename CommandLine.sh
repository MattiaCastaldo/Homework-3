#!/bin/bash
#declare -A countries
declare -a countries=()
cstr=''
declare -A cnt2
declare -A pepl
declare -A want
#i=0
while IFS=$'\t' read -r a b c d e f g h i j k l m n o
do
   #echo "first = $a second = $b third = $c"
   #echo "third = $c"
   #echo "address = $h"
   IFS=','
   text="Welcome to LinuxHint"
   IFS=','
	#Read the split words into an array based on space delimiter
	#read -a strarr <<< "$text"
	read -a strarr <<< "$h"
	#echo "country = ${strarr[-1]}"
	country=${strarr[-1]//[[:digit:]]/}
	#cstr="${cstr} $Var ; "
	if [[ ! $cstr == *"$Var"* ]]; then
	  #echo "It's there!"
	  #echo "-->>>>>>>   $Var"
	  cstr="${cstr} $Var ; "
	  #echo " -- cstr   :${cstr}"
	  cnt2["$Var"]="1"
	  pepl["$Var"]="$c"
	  want["$Var"]="$d"
	else
		#echo "--))))   $Var"
		#cnt2[$Var]="${cnt2["$Var"]} ......}"
		#cnt2[$Var]="999"
		(( cnt2["$Var"]++ ))
		(( pepl["$Var"]+=$c ))
		(( want["$Var"]+=$d ))
	fi
	#echo "cntr=  -$country"
	Var=`echo $country | sed -e 's/^[[:space:]]*//'`
	#echo "trim=  -$Var"
	#countries[1]=$Var
	#countries[${#countries[@]}]=0
	#countries[${#countries[@]}]=$Var
	countries+=($Var)
	#if [[ ! " ${countries[*]} " =~ "  " ]]; then
	#	countries[${#countries[@]}]=$Var
	#fi
	#echo "---------------------"
	#for val in "${strarr[@]}";
	#do
	#  printf "$val\n"
	#done
done < "Dataset.tsv"
#echo "countries--:  ${countries[@]}"
echo "--------------------------------"
#echo $cstr
echo "-----------------------------------------------------------------------------------------"
echo "------------------------------------------------------------------"
echo "--------------------------------  Number of places in each country "
echo "------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------"
#echo "${cnt2[@]}"
for key in "${!cnt2[@]}"; do 
	echo "$key => ${cnt2[$key]}"; 
done
echo "-----------------------------------------------------------------------------------------"
echo "------------------------------------------------------------------"
echo " --  average number of people visited the places in each country"
echo "------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------"
for key in "${!pepl[@]}"; do 
	#echo "$key => ${pepl[$key]}"; 
	#avg= (( pepl["$key"] / cnt2["$key"] ));
	#echo "$key => ${pepl[$key]} , ${cnt2[$key]} ";
	echo "$key => $(( ${pepl[$key]} / ${cnt2[$key]} ))";
	#echo "================"
	#x=10
	#y=20
	#echo $(( ${pepl[$key]} / ${cnt2[$key]} ))  
done
echo "-----------------------------------------------------------------------------------------"
echo "------------------------------------------------------------------"
echo " --- Number of people in total want to visit the places in each country."
echo "------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------"
for key in "${!want[@]}"; do 
	echo "$key => ${want[$key]}"; 
done

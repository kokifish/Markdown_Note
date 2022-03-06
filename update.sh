if [ ! -n "$1" ];then
    echo "please give commit massge after bash. e.g. 
    > bash update.sh \"code: java\"
    > bash update.sh \"DES crypt\""
    exit 1
fi
var=$1

echo "[Step-1] git pull origin main:"
git pull origin master -v;
echo 
echo "==== [WARNING] If conflict occured, related files will show below: ========="
git status -v
echo "==== [WARNING] Fix by hands if conflict exits. Then [RE-RUN] this script ===="
echo 

echo "[Step-2] Local changes add and commit:"
git checkout master;
git add . -v;
# echo $var
git commit -v -am "$var";

echo "[Step-3] git push origin main:"
git push origin master -v
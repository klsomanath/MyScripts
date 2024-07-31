Branch=$( git branch | grep "*" | cut -d " " -f 2)

filesPushed=$(git diff --stat --cached origin/develop | cut -d "|" -f 1 | head -n-1)
if [ -z $filesPushed ];
then
    echo "No Files Found"
else
    sf scanner run -t $filesPushed --outfile results.csv
fi
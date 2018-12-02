if [ "$#" -lt 1 ]; then
	echo "Did not give product id";
	exit 1;
fi
QUERY="SET NOCOUNT ON;Select count(*) as count from reviews where productid="
RES="$QUERY\"$1\" FOR JSON AUTO"
SQL="/dva-DB/scripts/"$1".sql"
echo "$RES" > "$SQL"
DEST="/dva-DB/scripts/"$1".json"

Q2="SET NOCOUNT ON;SELECT a.noun as Noun, a.cluster as Cluster, count(a.noun) as CountOfNouns, min(r.reviewBody) as Review
FROM Aspects2 AS a
INNER JOIN ReviewAspects2 AS ra ON a.Id=ra.aspectId
INNER JOIN Reviews AS r ON ra.reviewId=r.Id
INNER JOIN Products AS p ON r.productId=p.productId
WHERE p.productId= "
R2="$Q2\"$1\" GROUP BY a.noun, a.cluster FOR JSON AUTO"
SQL="/dva-DB/scripts/"$1"_1.sql"
echo "$R2" > "$SQL"
DEST="/dva-DB/scripts/"$1"_1.json"

/opt/mssql-tools/bin/sqlcmd -d dva -S localhost -U SA -P "Test123!"  -i $SQL -o $DEST -h -1
rm $SQL

Q3="SET NOCOUNT ON;SELECT cluster, avg(polarity) as polarity
from aspects2
where id in
(select aspectid from reviewaspects2 where reviewid in
(select id from reviews where productid ="
R3="$Q3\"$1\" )) group by cluster FOR JSON AUTO"
SQL3="/dva-DB/scripts/"$1"_2.sql"
echo "$R3" > "$SQL3"
DEST3="/dva-DB/scripts/"$1"_2.json"

/opt/mssql-tools/bin/sqlcmd -d dva -S localhost -U SA -P "Test123!"  -i $SQL3 -o $DEST3 -h -1
rm $SQL3
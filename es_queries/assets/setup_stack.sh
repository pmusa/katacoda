sudo -H -u packer bash -c '
cd ~
unset JAVA_HOME

echo -e "Downloading Elasticsearch..."
curl -Of --progress-bar https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.4.0-linux-x86_64.tar.gz

echo -e "Extracting Elasticsearch..."
tar -zxf elasticsearch-7.4.0-linux-x86_64.tar.gz

echo -e "Starting Elasticsearch..."
./elasticsearch-7.4.0/bin/elasticsearch -d

echo -e "Waiting for Elasticsearch to startup..."
sleep 20;
while true; do
  #Check to see if its running yet by grepping the cluster_name line
  RESPONSE=`curl -s -XGET http://localhost:9200 | grep elasticsearch`
  #Get a substring of the response line for simplicity
  R2=`echo $RESPONSE | cut -c2-13`
  if [ "$R2" = "cluster_name" ]; then
    echo -e "Elasticsearch is running!"
    break
  else
    sleep 3
    echo -e "Waiting for Elasticsearch to startup..."
  fi
done

echo -e "Downloading dataset..."
curl -Of --progress-bar https://gist.githubusercontent.com/pmusa/0413597eba8bed20bd085c579315bbe0/raw/cd944309d2d5974479713deab4ae928cbca317b1/recipes.bulk

echo -e "Loading dataset..."
curl -XPUT "http://localhost:9200/recipes/_bulk" -H "Content-Type: application/x-ndjson" --data-binary @recipes.bulk > /dev/null

NUMBER_OF_DOCS=39774
RESPONSE=`curl -qs "localhost:9200/_cat/count/recipes?h=count"`
if [ "$RESPONSE" != "$NUMBER_OF_DOCS" ]; then
  echo -e "There was a Problem ingesting the data. Please, contact support. Exiting..."
  exit 1 
fi

echo -e "A total of $NUMBER_OF_DOCS documents were loaded!"

echo -e "Downloading Kibana..."
curl -Of --progress-bar https://artifacts.elastic.co/downloads/kibana/kibana-7.4.0-linux-x86_64.tar.gz
echo -e "Extracting Kibana..."
tar -zxf kibana-7.4.0-linux-x86_64.tar.gz
echo -e "Starting Kibana..."
./kibana-7.4.0-linux-x86_64/bin/kibana --host=0.0.0.0 > kibana.log 2>&1 &

echo -e "Waiting for Kibana to startup..."
sleep 20;
while true; do
  #Check to see if its running yet by grepping the cluster_name line
  HTTP_CODE=$(curl --write-out %{http_code} --silent --output \
             /dev/null localhost:5601/api/status)
  if [ "$HTTP_CODE" = "200" ]; then
    echo -e "Kibana is running!"
    break
  else
    sleep 3
    echo -e "Waiting for Kibana to startup..."
  fi
done

echo -e "Environment successfully loaded"
'

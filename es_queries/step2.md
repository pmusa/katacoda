Console already has a query in it. The first query is the `match_all` query.

The `match_all` query matches all the documents 

```
# default
GET _search
{
  "query": {
    "match_all": {}
  }
}
```{{copy}}

```
#same as above, everything not the total hits
GET _search
```{{copy}}

```
# number of documents
GET _count
```{{copy}}

```
# track all hits, more expensive-39784
GET _search
{
  "track_total_hits": true,
  "query": {
    "match_all": {}
  }
}
```{{copy}}

```
# number of returned documents
GET _search
{
  "size": 1, 
  "track_total_hits": true,
  "query": {
    "match_all": {}
  }
}
```{{copy}}

```
# indices contain data, you can specify them-39784
GET recipes/_search
{
  "size": 3, 
  "track_total_hits": true,
  "query": {
    "match_all": {}
  }
}
```{{copy}}

```
# indices contain data, you can specify them-39784
GET recipes/_search
{
  "from": 3,
  "size": 3, 
  "track_total_hits": true,
  "query": {
    "match_all": {}
  }
}
```{{copy}}

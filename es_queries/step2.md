Start by running the `match_all` query by either clicking the green play button
or pressing `ctrl+enter` (`cmd+enter` in Macs).
You should get back 10 documents from multiple indices from more than 10,000
documents that were a hit.

Next, update the search request to query only the `recipes` index.

```
GET recipes/_search
{
  "query": {
    "match_all": {}
  }
}
```{{copy}}


Update the search request so that the response returns the exact number of hits.

```
GET recipes/_search
{
  "track_total_hits": true,
  "query": {
    "match_all": {}
  }
}
```{{copy}}

When you set `track_total_hits` to `true`, you force Elasticsearch to count
every hit and therefore avoid optimizations.
This is great for exploring datasets, learning about Elasticsearch and some
search use cases.


Next, imagine that instead of 10 you only want to show 5 recipes per page.
Update the search request accordingly.

```
GET recipes/_search
{
  "size": 5, 
  "track_total_hits": true,
  "query": {
    "match_all": {}
  }
}
```{{copy}}

Finally, imagine a user is already on the fourth page and clicks the button to
go to the next page (fifth page).
Update the search requeest accordingly.

```
GET recipes/_search
{
  "from": 5,
  "size": 20, 
  "track_total_hits": true,
  "query": {
    "match_all": {}
  }
}
```{{copy}}

You need to add the `from` parameter and set it to 20 because the first four
pages have already returned 20 documents. 

Feel free to explore Elasticsearch a bit more on your own.
Then, go back to the class page and start the "Match and Boolean Queries"
lesson.


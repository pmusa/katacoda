Start by writing a search request that finds all recipes that contain `garlic`.
Use the `track_total_hits` parameter to check the total number of hits.
The request should match 18232 recipes.

```
GET recipes/_search
{  "track_total_hits": true,  "query": {    "match": {      "ingredients": "garlic"    }  }}
```{{copy}}

Update the query above to match `Garlic` instead of `garlic`.
The request should match the same 18232 recipes, as this query is case
insensitive.
```
GET recipes/_search
{
  "track_total_hits": true,
  "query": {
    "match": {
      "ingredients": "Garlic"
    }
  }
}
```{{copy}}

Update the match clause to find recipes that contain `garlic` or `tomatoes`.
The request should match 21007 recipes.
```
GET recipes/_search
{
  "track_total_hits": true,
  "query": {
    "match": {
      "ingredients": "garlic tomatoes"
    }
  }
}
```{{copy}}

Now, change the logic to an "and".
Do you expect more or less documents?
```
GET recipes/_search
{
  "query": {
    "match": {
      "ingredients": {
        "query": "garlic tomatoes",
        "operator": "and"
      }
    }
  }
}
```{{copy}}
The request should match less documents, more precisely 5529 recipes.


Next, update the query to only return the recipes from the greek cuisine.
The request should match 245 recipes.
```
GET recipes/_search
{
  "query": {
    "bool": {
      "must": [
        {
          "match": {
            "ingredients": {
              "query": "garlic tomatoes",
              "operator": "and"
            }
          }
        },
        {
          "match": {
            "cuisine": "greek"
          }
        }
      ]
    }
  }
}
```{{copy}}

Now, update the query to not return the recipes that contain `feta` cheese.
The request should match 103 recipes.
```
GET recipes/_search
{
  "query": {
    "bool": {
      "must": [
        {
          "match": {
            "ingredients": {
              "query": "garlic tomatoes",
              "operator": "and"
            }
          }
        },
        {
          "match": {
            "cuisine": "greek"
          }
        }
      ],
      "must_not": [
        {
          "match": {
            "ingredients": "feta"
          }
        }
      ]
    }
  }
}
```{{copy}}

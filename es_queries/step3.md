```
# i love garlic - 18232
GET recipes/_search
{
  "track_total_hits": true,
  "query": {
    "match": {
      "ingredients": "garlic"
    }
  }
}
```{{copy}}

```
# what about Garlic - 18232
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

```
# i also love tomatoes - 21007
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

```
# but I actually want both, not one or the other - 5529
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

```
# now, if you want garlic tomatoes but greek cuisine - 245
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

```
# now, if you want garlic tomatoes but greek cuisine. But I dont like feta - 103
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

```
# now, if you want garlic tomatoes but greek cuisine. But I dont like feta -103
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
      ],
      "should": [
        {
          "match": {
            "ingredients": "cucumber"
          }
        }
      ]
    }
  }
}
```{{copy}}

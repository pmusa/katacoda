In this lesson you will setup Elasticsearch and Kibana and load some
documents.

To get stack started you only need to run the following script.
`./setup_stack.sh`{{execute}}

The script will:
1. download Elasticsearch
2. extract Elasticsearch
3. start Elasticsearch
4. wait until Elasticsearch is running
5. download the dataset
6. index 39774 documents
7. download Kibana
8. extract Kibana
9. start Kibana
10. wait until Kibana is running

While the script is running, you can familiarize yourself with the dataset.
The dataset consists of 39774 recipes.
Each recipe has an `id` (number), a `cuisine` (string), and the `ingredients`
(an array of strings). Take a look at the example below:
```
{
  "id": 10259,
  "cuisine": "greek",
  "ingredients": [
    "romaine lettuce",
    "black olives",
    "grape tomatoes",
    "garlic",
    "pepper",
    "purple onion",
    "seasoning",
    "garbanzo beans",
    "feta cheese crumbles"
  ]
}
```

After 2 minutes the script should be over and you should see the following
message: "Environment successfully loaded".
Now that Elasticsearch and Kibana are running, you can click on the Dashboard
tab to open Kibana.
Kibana will ask you two questions. You should click "No" to the first one and
"Explore on my own" to the second one.
Finally, on the left-side menu, click on "Dev Tools" (the wrench icon).

Congratulations, you are ready to start exploring queries.

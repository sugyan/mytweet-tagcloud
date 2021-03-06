# MyTweet TagCloud #

![](https://cloud.githubusercontent.com/assets/80381/21346447/c281c44c-c6e7-11e6-9140-678f80196f3c.png)


## Prerequisite ##

- Elasticsearch `>= 5.1.1`
  - `analysis kuromoji` plugin ([URL](https://www.elastic.co/guide/en/elasticsearch/plugins/current/analysis-kuromoji.html))
- Kibana `>= 5.1.1`


## Setup ##

- [Download your Twitter archive](https://support.twitter.com/articles/20170160)
- Copy `tweets.csv` to `data` directory
- Start `elasticsearch` and `kibana`
- Run commands
```
bundle install
bundle exec ruby load.rb
```
- Configure an index pattern in "Management"
  - Open http://localhost:5601/app/kibana#/management/kibana/index
  - Input `tweets` to "Index name or pattern" and submit "Create" button
- Open http://localhost:5601/app/kibana#/visualize/create?type=tagcloud&indexPattern=tweets
  - Set "Time Range" to `Last 1 year` (or more long terms)
  - Fill form
    - "Field": `text`
    - "Size": `100` - `200`
    - "Exclude Pattern" in "Advanced": `.|[a-zぁ-ん]{2}|[0-9]+`


## References ##

- http://acro-engineer.hatenablog.com/entry/2016/12/18/234340
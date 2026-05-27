# Swift Search

A mini search engine (like Elastisearch). 

```
# Run server with
swift run Server
```

Supported client operations:
* `/query/[search term(s)]`: returns a map of `docId` to token positions.
```
curl 127.0.0.1:8080/query/[search term(s)]

# example response: 
# {"B92D7BD8-F67E-47C4-AA17-7A6E46662598":[0,4,8],"1098BE07-057D-4A3D-A379-38128C7E4645":[2]}
```
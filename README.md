# ft_onion

### Build docker image
```docker build . -t ft_onion```

### Run docker image
```docker run -d -p 80:80 ft_onion```

### Remove all opened images
```docker rmi -f $(docker images -q)```

### Test result
```curl localhost:80```

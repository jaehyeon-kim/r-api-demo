## R API DEMO

Investigate API Development with R - [plumber](https://github.com/trestletech/plumber), [Rserve](https://www.rforge.net/Rserve/) and [rApache](http://rapache.net/).

### Docker

```
## build
docker build -t=api ./api/.

## run
# rApache - 7000, Rserve - 8000, plumber - 9000
# all APIs managed by supervisor
docker run -d -p 7000:80 -p 8000:8000 -p 9000:9000 --name api api:latest
```

### CURL

```
# change port accordingly
curl -H "Content-Type: application/json" -X POST -d '{"n": 10, "wait": 0.5}' http://localhost:7000/test
```

### Performance Test

```
## locust - only available for Python 2
# pip install locustio

locust -f ./locustfile.py --host http://localhost:7000 --no-web -c 1 -r 1
```
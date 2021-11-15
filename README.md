Docker + Ubuntu-18.04 + Mysql-5.7 + php + lts nodejs


#### Build and push with 
```
docker build  -t nixes/k-ubuntu-test:master . 
docker push nixes/k-ubuntu-test:master
```

#### parameter

* `MYSQL_ROOT_PWD` : root Password   default "mysql"
* `MYSQL_USER`     : new User
* `MYSQL_USER_PWD` : new User Password
* `MYSQL_USER_DB`  : new Database for new User

#### run a default contaier

```
$ docker run --name mysql -v /var/docker_data/mysql/data/:/var/lib/mysql -d -p 3306:3306 nixes/k-ubuntu-test
```

#### run a container with new User and Password

```
$ docker run --name mysql -v /var/docker_data/mysql/data/:/var/lib/mysql -d -p 3306:3306 -e MYSQL_ROOT_PWD=123 -e MYSQL_USER=dev -e MYSQL_USER_PWD=dev nixes/k-ubuntu-test
```

#### run a container with new Database for new User and Password

```
$ docker run --name mysql -v /var/docker_data/mysql/data/:/var/lib/mysql -d -p 3306:3306 -e MYSQL_ROOT_PWD=123 -e MYSQL_USER=dev -e MYSQL_USER_PWD=dev -e MYSQL_USER_DB=userdb nixes/k-ubuntu-test
```

## Troubleshooting

If you get an issue mentioning permissions when downloading, try doing a docker pull manually on the ci server first and retrying.

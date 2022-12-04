## How to run

### Database

```bash
docker-compose up
rails db:migrate
```

### Start app

```bash
rails s
```

### Routes

```
- /api/players [GET, POST]
- /api/players/:id [PUT, DELETE]
- /api/teams [GET, POST]
- /api/teams/:id [PUT, DELETE]
- /api/teams/:id/players [GET, PUT]
```
## How to test

```bash
bundle exec rspec
```

## Troubleshooting

### Kill stopped server

```bash
lsof -wni tcp:3000
kill -9 <PID>
```

### Fix pg gem installation

```bash
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get -y update
sudo apt-get remove libpq5
sudo apt-get install libpq-dev
```

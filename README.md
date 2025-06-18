  383  git clone https://github.com/cryptpad/cryptpad.git cryptpad
  384  ls
  385  cd cryptpad/
  386  ls
  387  docker build -t cryptpad/cryptpad:local-latest
  388  vim docker-compose.yml
  389  mkdir -p data customize onlyoffice-dist onlyoffice-conf
  390  sudo chown -R 4001:4001 data customize onlyoffice-dist onlyoffice-conf
  391  cp config/config.example.js config/config.js
  392  vim config/config.js
  393  vim docker-compose.yml
  394  docker compose up -d
  395  docker compose logs
  396  ls -la
  397  history
  398  docker compose logs
  399  ls -la
  400  ls -la data/
  401  chown -R 4001:4001 data/
  402  ls -la data/
  403  docker compose down
  404  docker compose up -d
  405  docker compose logs
# cryptad

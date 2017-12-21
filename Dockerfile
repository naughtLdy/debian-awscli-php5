FROM debian:latest

RUN apt-get update && \
  apt-get install -y apt-transport-https lsb-release ca-certificates wget curl git zip groff-base && \
  wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg && \
  echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list && \
  apt-get update && \
  apt-get install -y php5.6 php5.6-dev php5.6-xml php5.6-curl && \
  curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
  apt-get install -y python python-pip && \

  # phpredis
  apt-get install -y re2c && \
  cd /tmp && \
  wget https://github.com/phpredis/phpredis/archive/3.1.2.zip -O phpredis.zip && \
  unzip -o /tmp/phpredis.zip && \
  mv /tmp/phpredis-* /tmp/phpredis && \
  cd /tmp/phpredis && \
  phpize && \
  ./configure && \
  make && \
  make install && \
  touch /etc/php/5.6/mods-available/redis.ini && \
  echo extension=redis.so > /etc/php/5.6/mods-available/redis.ini && \
  ln -s /etc/php/5.6/mods-available/redis.ini /etc/php/5.6/apache2/conf.d/ && \
  ln -s /etc/php/5.6/mods-available/redis.ini /etc/php/5.6/cli/conf.d/ && \

  pip install awscli && \
  apt-get clean

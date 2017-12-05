FROM debian:9.2

RUN apt-get update && \
  apt-get install -y apt-transport-https lsb-release ca-certificates wget curl && \
  wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg && \
  echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list && \
  apt-get update && \
  apt-get install -y php5.6 && \
  curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
  apt-get install -y python python-pip && \
  pip install aws

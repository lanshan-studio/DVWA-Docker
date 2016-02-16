FROM tutum/lamp

MAINTAINER Grant Hunter <stu.guyu@gmail.com>

RUN rm -rf /app && \
    apt-get update && \
    apt-get install -y wget php5-gd && \
    rm -rf /var/lib/apt/lists/*

COPY conf/* /tmp/

RUN wget https://github.com/RandomStorm/DVWA/archive/v1.9.tar.gz && \
    tar xvf /v1.9.tar.gz && \
    mv -f /DVWA-1.9 /app && \
    rm /app/.htaccess

RUN mv /tmp/.htaccess /app && \
    chmod +x /tmp/setup_db.sh && \
    /tmp/setup_db.sh

RUN sed -i "s/FileInfo/All/g" /etc/apache2/sites-available/000-default.conf

RUN chmod 777 -R /app/hackable/uploads/ && \
    chmod 777 /app/external/phpids/0.6/lib/IDS/tmp/phpids_log.txt


EXPOSE 80 3306

CMD ["/run.sh"]

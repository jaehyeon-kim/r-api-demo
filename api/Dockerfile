FROM rocker/r-ver:3.4
MAINTAINER Jaehyeon Kim <dottami@gmail.com>

RUN apt-get update && apt-get install -y wget supervisor

## Plumber
RUN R -e 'install.packages(c("plumber", "jsonlite"))'

## Rserve
RUN apt-get install -y libssl-dev
RUN wget http://www.rforge.net/Rserve/snapshot/Rserve_1.8-5.tar.gz \
    && R CMD INSTALL Rserve_1.8-5.tar.gz

## rApache
RUN apt-get install -y \
    libpcre3-dev liblzma-dev libbz2-dev libzip-dev libicu-dev
RUN apt-get install -y apache2 apache2-dev
RUN wget https://github.com/jeffreyhorner/rapache/archive/v1.2.8.tar.gz \
    && tar xvf v1.2.8.tar.gz \
    && cd rapache-1.2.8 && ./configure && make && make install

RUN R -e 'install.packages(c("Rook", "rjson"))'

RUN echo '/usr/local/lib/R/lib/' >> /etc/ld.so.conf.d/libR.conf \
    && ldconfig

## copy sources to /home/docker
RUN useradd docker && mkdir /home/docker \
	&& chown docker:docker /home/docker

RUN mkdir /home/docker/plumber /home/docker/rserve /home/docker/rapache
COPY ./src/plumber /home/docker/plumber/
COPY ./src/rserve /home/docker/rserve/
COPY ./src/rapache /home/docker/rapache/
COPY ./src/api-supervisor.conf /home/docker/api-supervisor.conf
RUN chmod -R 755 /home/docker

RUN ln -s /home/docker/rapache/rapache-site.conf \
    /etc/apache2/sites-available/rapache-site.conf \
    && ln -s /home/docker/rapache/rapache-app.R /var/www/rapache-app.R

## config rApache
RUN echo 'ServerName localhost' >> /etc/apache2/apache2.conf \
    && /bin/bash -c "source /etc/apache2/envvars" && mkdir -p /var/run/apache2 \
    && a2ensite rapache-site

CMD ["/usr/bin/supervisord", "-c", "/home/docker/api-supervisor.conf"]

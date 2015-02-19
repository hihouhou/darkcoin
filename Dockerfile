###############################################
# Debian with added Darkcoin server.
###############################################

# Using latest debian image as base
FROM debian:latest

MAINTAINER hihouhou < hihouhou@hihouhou.com >

RUN /usr/sbin/useradd -m -u 1234 -d /darkcoin -s /bin/bash darkcoin

RUN apt-get update \
  && apt-get install -y wget

WORKDIR /darkcoin
ENV DARK_VERSION darkcoin-0.11.1.19-linux.tar.gz
ENV DARKCOIN_DOWNLOAD_URL https://raw.githubusercontent.com/darkcoinproject/darkcoin-binaries/master/${DARK_VERSION}
RUN wget --no-check-certificate ${DARKCOIN_DOWNLOAD_URL} \
  && tar xf ${DARK_VERSION} --strip-components=1 \
  && rm -rf ${DARK_VERSION}.tar.gz \
  && chmod a+x bin/64/darkcoind \
  && mkdir .darkcoin/ \
  && chown darkcoin:darkcoin -R /darkcoin

ADD darkcoin.conf /darkcoin/.darkcoin/
USER darkcoin
ENV HOME /darkcoin
VOLUME ["/darkcoin"]
EXPOSE 9999

# Default arguments, can be overriden
CMD ["/darkcoin/bin/64/darkcoind"]

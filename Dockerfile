FROM debian:stable-slim

ENV ALGO="verushash"
ENV POOL_ADDRESS="stratum+tcp://us.vipor.net:5040"
ENV WALLET_USER="RVuAG4SKdeZQ2Po8o33LPrjNbm1HLKn87H"
ENV PASSWORD="x"
ENV EXTRAS="--api-enable --api-port 80 --disable-auto-affinity --disable-gpu"

RUN apt-get -y update \
    && apt-get -y upgrade \
    && apt-get -y install curl wget \
    && cd /opt \
    && curl -L https://github.com/doktor83/SRBMiner-Multi/releases/download/2.7.2/SRBMiner-Multi-2-7-2-Linux.tar.gz -o SRBMiner-Multi.tar.gz \
    && tar xf SRBMiner-Multi.tar.gz \
    && rm -rf SRBMiner-Multi.tar.gz \
    && mv /opt/SRBMiner-Multi-2-7-2/ /opt/SRBMiner-Multi/ \
    && apt-get -y autoremove --purge \
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

WORKDIR /opt/SRBMiner-Multi/
COPY start_verus.sh .

RUN chmod +x start_zergpool.sh

EXPOSE 80

ENTRYPOINT ["./start_verus.sh"]
CMD ["--api-enable", "--api-port", "80", "--disable-auto-affinity", "--disable-gpu"]

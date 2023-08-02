FROM alpine

RUN apk add zsh git \
 && adduser -D testuser -h /home/testuser -s /bin/zsh \
 && mkdir -p /home/testuser/.config/zsh

USER testuser
WORKDIR /home/testuser
ENV ZDOTDIR /home/testuser/.config/zsh
COPY . $ZDOTDIR/
VOLUME $ZDOTDIR

CMD /bin/zsh -l

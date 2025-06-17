FROM swipl:latest

WORKDIR /app

COPY server.pl /app/
COPY equacao.pl /app/
COPY test_equacao.pl /app/

CMD [ "swipl", "-q", "-f", "server.pl" ]
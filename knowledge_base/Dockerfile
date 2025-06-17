FROM swipl:latest

WORKDIR /app

COPY server.pl /app/
COPY equacao.pl /app/
COPY test_equacao.pl /app/
COPY regras_algebra.pl /app/
COPY test_regras_algebra.pl /app/

CMD [ "swipl", "-q", "-f", "server.pl" ]
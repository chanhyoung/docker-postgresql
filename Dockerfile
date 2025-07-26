# 베이스 이미지
FROM postgres:16-alpine

# 보안 업데이트 설치
RUN apk update && apk upgrade && apk add --no-cache \
    && rm -rf /var/cache/apk/*


#init.sql 파일을 /docker-entrypoint-initdb.d/ 로 복사, /docker-entrypoint-initdb.d/ 에 있는 sql문은 컨테이너가 처음 실행시 자동 실행됨
#COPY ./init/init.sql /docker-entrypoint-initdb.d/

#postgresql.conf 파일을 /etc/postgresql/custom.conf 로 복사, 기본 설정 파일을 덮어쓰기하여 새로운 설정 적용
COPY ./config/postgresql.conf /etc/postgresql/custom.conf

# 사용자 권한 설정
USER postgres

ENV POSTGRES_DB=mydb
ENV POSTGRES_USER=myuser
ENV POSTGRES_PASSWORD=mypassword

EXPOSE 5432

CMD [ "postgres", "-c", "config_file=/etc/postgresql/custom.conf" ]
# CMD [ "postgres", "-c", "config_file=/etc/postgresql/postgresql.conf" ]
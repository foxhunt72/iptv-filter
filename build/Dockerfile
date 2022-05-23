FROM python:3
ENV LAST_UPDATED 2022-05-23A
ENV PYTHONUNBUFFERED=1
WORKDIR /code
COPY requirements.txt /code/
RUN pip install -r requirements.txt
COPY . /code/
RUN chmod a+x /code/run.sh
RUN IPTV_SAFE_START=1 python3 manage.py migrate
#RUN chown 1000:1000 db.sqlite3

CMD /code/run.sh

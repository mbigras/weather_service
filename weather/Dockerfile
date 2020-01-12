FROM python:3.8-alpine3.11
WORKDIR /app/
COPY app/requirements.txt .
RUN pip install -r requirements.txt
COPY app/app.py .
COPY app/templates/ templates/
COPY app/version.txt .
COPY app/run.py .

ENV PORT=80
ENV HOST=0.0.0.0
CMD gunicorn --bind $HOST:$PORT run

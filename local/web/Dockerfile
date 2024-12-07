FROM python:3.10

WORKDIR /app

ADD src/ .

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 5000

CMD ["python", "run.py"]
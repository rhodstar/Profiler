FROM python:3.9-alpine

ENV PYTHONUNBUFFERED 1

WORKDIR /profiler

COPY requirements.txt /profiler

RUN pip install -r requirements.txt

COPY ./profiler /profiler


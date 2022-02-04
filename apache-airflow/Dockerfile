FROM apache/airflow:2.2.3-python3.8
USER root
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
         vim \
  && apt-get autoremove -yqq --purge \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*
RUN pip install --no-cache-dir pip omegaconf pandas psycopg2-binary pendulum \
	apache-airflow-providers-slack SQLAlchemy cx_oracle
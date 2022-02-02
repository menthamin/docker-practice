#!/bin/bash

# 주피터 설정 파일
JUPYTER_CONFIG=/root/.jupyter/jupyter_notebook_config.py

# Password 설정
PASSWORD=`python -c 'from notebook.auth import password;print(passwd())'`
mkdir -p /root/.jupyter
echo "c.NotebookApp.password = '$PASSWORD'" > $JUPYTER_CONFIG

# 주피터 노트북 기동
jupyter notebook --no-browser --allow-root --ip 0.0.0.0 \
--notebook-dir $NOTEBOOK_DIR

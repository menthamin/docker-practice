# docker run -it --rm \
# --publish 8888:8888 \
# --volume /home/mentha/docker-files/jupyter-env/project1:/project1 \
# --env NOTEBOOK_DIR=/project1 \
# jupyter-notebook

# docker run --name jupyter-lab -d \
# --publish 8899:8888 \
# --volume /home/mentha/docker-files/jupyter-lab/project:/project \
# --env NOTEBOOK_DIR=/project \
# jupyter-lab

docker run --name jupyter-lab -d \
--publish 8899:8888 \
--volume /home/mentha/crawler:/project \
--env NOTEBOOK_DIR=/project \
jupyter-lab

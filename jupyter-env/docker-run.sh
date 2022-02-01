# docker run -it --rm \
# --publish 8888:8888 \
# --volume /home/mentha/docker-files/jupyter-env/project1:/project1 \
# --env NOTEBOOK_DIR=/project1 \
# jupyter-notebook

docker run --name jupyter-env -d \
--publish 8888:8888 \
--volume /home/mentha/docker-files/jupyter-env/project1:/project1 \
--env NOTEBOOK_DIR=/project1 \
jupyter-notebook
# docker run -it --rm \
# --publish 8888:8888 \
# --volume /home/mentha/docker-files/jupyter-env/project1:/project1 \
# --env NOTEBOOK_DIR=/project1 \
# jupyter-notebook

docker run --name jupyter-notebook -d \
--publish 8889:8888 \
--volume /home/mentha/docker-files/jupyter-notebook/project:/project \
--env NOTEBOOK_DIR=/project \
jupyter-notebook
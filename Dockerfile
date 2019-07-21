FROM opensciencegrid/osgvo-xenon:development

COPY _setup_dockerfile.sh .
COPY xnt_conda_env.yml .

RUN chmod +x /_setup_dockerfile.sh
RUN /_setup_dockerfile.sh

RUN echo "Timestamp:" `date --utc` | tee /image-build-info.txt
FROM python:3.8

ARG HOME=/home

WORKDIR ${HOME}

RUN git clone https://github.com/MAAP-Project/job-etc.git
RUN pip install -r ${HOME}/job-etc/requirements.txt

COPY entrypoint.sh ${HOME}
RUN chmod +x ${HOME}/entrypoint.sh

ENTRYPOINT ["/home/entrypoint.sh"]

FROM python:3.10

ENV PYTHONUNBUFFERED=1

ARG WORKDIR=/wd
ARG USER=user

WORKDIR ${WORKDIR}

RUN useradd --system ${USER} && \
    chown --recursive ${USER} ${WORKDIR}

RUN apt update && apt upgrade -y

COPY --chown=${USER} requirements.txt requirements.txt

RUN pip install --upgrade pip && \
    pip install --requirement requirements.txt

COPY --chown=${USER} ./organize_output/organize_output__groups_and_humans.py organize_output__groups_and_humans.py
COPY --chown=${USER} ./generate_users/generate_users.py generate_users.py
COPY --chown=${USER} ./Makefile Makefile

USER ${USER}

ENTRYPOINT ["python", "organize_output__groups_and_humans.py", "generate_users"]
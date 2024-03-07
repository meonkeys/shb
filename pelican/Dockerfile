FROM python:3.10

ARG WORK_DIR
ARG USER
ARG UID
ARG GROUP
ARG GID

RUN apt-get update \
  && apt-get --assume-yes --no-install-recommends install \
  default-jre \
  && rm -rf /var/lib/apt/lists/*

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

RUN addgroup --gid $GID $USER \
  && useradd --uid $UID --gid $GID --shell /bin/bash --no-create-home $USER

USER "$USER:$GROUP"

ENV HOME=$WORK_DIR

WORKDIR $WORK_DIR/website

CMD [ "/bin/bash" ]

FROM nicolalandro/multilanguage-jupyter:1.0

ADD notebooks /server/notebook

RUN pip3 install --no-cache notebook jupyterlab
# create user with a home directory

ARG NB_USER
ARG NB_UID
ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}
WORKDIR ${HOME}
USER ${USER}

RUN cd /server && ./almond --install
RUN iruby register --force
RUN ijsinstall

COPY ./notebooks ${HOME}

FROM python:3.9-slim

RUN groupadd --gid 1000 appuser \
    && useradd --uid 1000 --gid 1000 -ms /bin/bash appuser

RUN pip3 install --no-cache-dir --upgrade \
    pip \
    virtualenv

RUN apt-get update && apt-get install -y \
    build-essential \
    wget 

USER appuser
WORKDIR /home/appuser

#RUN git clone https://github.com/streamlit/streamlit-example.git app
COPY . . 

RUN mkdir -p app/.streamlit
COPY .streamlit/config.toml .streamlit/config.toml


ENV VIRTUAL_ENV=/home/appuser/venv
RUN virtualenv ${VIRTUAL_ENV}

RUN . ${VIRTUAL_ENV}/bin/activate && pip install --no-cache-dir \
    streamlit \
    matplotlib \
    pandas \
    numpy \
    py3Dmol \
    plotly 


COPY .streamlit/config.toml /app/.streamlit/config.toml

# Download de benodigde databestanden als ze nog niet aanwezig zijn
RUN if [ ! -f "vkgl_apr2024_VUS_pred.csv" ]; then \
    wget -O vkgl_apr2024_VUS_pred.csv.gz https://github.com/molgenis/dave/raw/main/data/vkgl_apr2024_VUS_pred.csv.gz && \
    gunzip vkgl_apr2024_VUS_pred.csv.gz; \
    fi

RUN if [ ! -f "mut_wt_structures_vkgl_vus.tar.gz" ]; then \
    wget https://zenodo.org/records/17435480/files/mut_wt_structures_vkgl_vus.tar.gz && \
    tar -xzf mut_wt_structures_vkgl_vus.tar.gz; \
    fi



EXPOSE 8501

COPY run.sh /home/appuser
ENTRYPOINT ["./run.sh"]

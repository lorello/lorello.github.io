FROM andrglo/mkdocs

COPY . /workspace

EXPOSE 8000

RUN [ 'serve' ]

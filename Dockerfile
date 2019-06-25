FROM python:3.7 AS build

WORKDIR /app

RUN pip --no-cache-dir install nuitka

RUN pip --no-cache-dir install poetry==0.12.16

RUN poetry config settings.virtualenvs.in-project true

COPY pyproject.toml poetry.lock ./

RUN poetry install --no-dev

COPY main.py ./

FROM python:3.7-slim AS runtime

WORKDIR /app
ENV PATH="/app/.venv/bin:$PATH"

COPY --from=build /app/ ./

CMD [ "python", "main.py" ]

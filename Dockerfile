FROM python:3.8

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
RUN apt-get update && \
    apt-get install -yq \
        firefox-esr \
        google-chrome-stable \
        xvfb && \
    rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install -r requirements.txt
RUN webdrivermanager firefox chrome --linkpath /usr/local/bin
RUN sed -i "s/self._arguments\ =\ \[\]/self._arguments\ =\ \['--no-sandbox',\ '--disable-dev-shm-usage'\]/" /usr/local/lib/python3.8/site-packages/selenium/webdriver/chrome/options.py

VOLUME /usr/src/zebra-tests
WORKDIR /usr/src/zebra-tests

ENTRYPOINT ["/bin/sh", "-c", "xvfb-run -a robot --outputdir ./reports -x xunit.xml -P ./lib -V ./lib/test-env.py $@", ""]
CMD ["tests/"]

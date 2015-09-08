FROM heroku/ruby

# Install phantomjs for cucumber tests
RUN mkdir -p /app/phantomjs
RUN curl -s -retry 3 -L https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.8-linux-x86_64.tar.bz2 | tar xj -C /app/phantomjs
ENV PATH /app/phantomjs/phantomjs-1.9.8-linux-x86_64/bin:$PATH
RUN echo "export PATH=\"$PATH\"" > /app/.profile.d/zphantomjs.sh

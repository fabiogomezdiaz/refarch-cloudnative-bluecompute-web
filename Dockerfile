FROM registry.access.redhat.com/ubi8/nodejs-12:1-45

# Install Extra Packages
USER 0
RUN yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm; \
    yum install -y jq
USER 1001

# Environment Variables
ENV NODE_ENV production

# Create app directory
ENV APP_HOME=/opt/app-root/src
RUN mkdir -p $APP_HOME/node_modules $APP_HOME/public/resources/bower_components
WORKDIR $APP_HOME

# Copy package.json, bower.json, and .bowerrc files
COPY StoreWebApp/package*.json StoreWebApp/bower.json StoreWebApp/.bowerrc ./

# Install Dependencies
RUN npm install

# Copy source code and scripts
COPY startup.sh startup.sh
COPY StoreWebApp ./

EXPOSE 8000 9000
ENTRYPOINT ["./startup.sh"]
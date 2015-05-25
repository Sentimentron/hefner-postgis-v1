FROM ubuntu:utopic
MAINTAINER Richard Townsend <richard@sentimentron.co.uk>

# Main installation script
ADD install-postgis.sh /install-postgis.sh
RUN chmod 0755 /install-postgis.sh
RUN bash /install-postgis.sh

# Configuration script
ADD configure-postgis.sh /configure-postgis.sh
RUN chmod 0755 /configure-postgis.sh
RUN bash /configure-postgis.sh

# Start postgis automatically on container start
#ADD start-postgis.sh /start-postgis.sh
#RUN chmod 0755 /start-postgis.sh

# Expose the postgres port
EXPOSE 5432

CMD /etc/init.d/postgresql start && tail -F /var/log/postgresql/postgresql-9.4-main.log

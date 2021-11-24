FROM gitpod/workspace-mysql

USER root
ARG DEBIAN_FRONTEND=noninteractive

# Install Mailhog
RUN wget https://github.com/mailhog/MailHog/releases/download/v1.0.1/MailHog_linux_amd64 -q -O /tmp/mailhog && \
    chmod +x /tmp/mailhog && \
    mv /tmp/mailhog /usr/local/bin/mailhog

# Install phpmyadmin
RUN apt-get update && \
    debconf-set-selections <<< "phpmyadmin phpmyadmin/internal/skip-preseed boolean true" && \
    debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2" && \
    debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean false" && \
    apt-get install -y phpmyadmin
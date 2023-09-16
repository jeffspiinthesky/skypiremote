FROM docker-jksmith.ddns.net:5000/raspbian:buster

# Set up basic environment
RUN apt update && apt upgrade -y
RUN apt install -y python3 python3-pip python3-venv libapache2-mod-wsgi-py3 apache2
RUN mkdir -p /var/www/flask/skypiremote/app
WORKDIR /var/www/flask/skypiremote

# Set up Python runtime and requirements
RUN python3 -m venv venv
ADD requirements.txt /var/www/flask/skypiremote/
RUN . ./venv/bin/activate && pip3 install -r requirements.txt && deactivate
ADD skypiremote.conf /etc/apache2/sites-available/
RUN a2ensite skypiremote.conf
RUN a2dissite 000-default.conf

# Add the content
ADD __init__.py /var/www/flask/skypiremote/app/
ADD config.py /var/www/flask/skypiremote/
ADD templates /var/www/flask/skypiremote/app/templates
ADD static /var/www/flask/skypiremote/app/static
ADD skypiremote.py /var/www/flask/skypiremote/
ADD skypiremote.wsgi /var/www/flask/skypiremote/

# Run up Apache2
ENTRYPOINT apachectl -D FOREGROUND

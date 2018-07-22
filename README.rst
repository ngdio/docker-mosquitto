Docker-Mosquitto |Stars| |Pulls| |Size|
=======================================

This Docker image containerizes Apache's Mosquitto MQTT broker. It can be used as an alternative to the `official image <https://hub.docker.com/r/_/eclipse-mosquitto/>`_ (see *Differences* section below).

Differences to the official image
---------------------------------
* Does not depend on Alpine Linux's repositories - While the official image merely installs the package from Alpine's official repositories, this one builds Mosquitto individually and can be updated immediately when a new version of Mosquitto is released
* Includes builds for arm architectures (only `arm32v7` at this point)
* More individual - the official image suggests three volumes for persistent data, logs and configuration, but not everybody wants to use log files or persistent data, so this one will leave it up to you

Usage
-----
The configuration is located at :code:`/etc/mosquitto`. To modify the basic configuration, mount a configuration file at :code:`/etc/mosquitto/mosquitto.conf` or mount an entire folder at :code:`/etc/mosquitto`.

To adapt the default configuration, create a temporary container and copy the configuration file:
.. code:: bash
   docker run --name tmp-container -d ngdio/mosquitto:<image variant>
   docker cp tmp-container:/etc/mosquitto/mosquitto.conf /host/path/mosquitto.conf
   docker rm -f tmp-container


**Command Line:**
.. code:: bash
   docker run -d -p 1883:1883 -v /mosquitto:/etc/mosquitto/mosquitto ngdio/mosquitto:<image variant>

Please take a look at [the different images](https://hub.docker.com/r/marthoc/deconz/tags/) to find the variant you need.

**Docker-Compose:**
::
   version: "2"
   services:
     mosquitto:
       image: ngdio/mosquitto:<image variant>
     restart: always
     volumes:
       - /mosquitto:/etc/mosquitto


Quick reference
---------------

-	**Where to file issues**:
`https://github.com/ngdio/docker-mosquitto/issues <https://github.com/ngdio/docker-mosquitto/issues>`_

-	**Maintained by**:
`Niklas (ngdio) <https://github.com/ngdio>`_

-	**Supported architectures**:
amd64, arm32v7 (builds for more arm architectures to follow)


.. |Stars| image:: https://img.shields.io/docker/stars/ngdio/mosquitto.svg?style=flat-square
   :target: https://hub.docker.com/r/ngdio/mosquitto/
   :alt: Docker Stars
.. |Pulls| image:: https://img.shields.io/docker/pulls/ngdio/mosquitto.svg?style=flat-square
   :target: https://hub.docker.com/r/ngdio/mosquitto/
   :alt: Docker Pulls
.. |Size| image:: https://img.shields.io/microbadger/image-size/ngdio/mosquitto.svg?style=flat-square
   :target: https://hub.docker.com/r/ngdio/mosquitto/
   :alt: Image Size

FROM ypasmk/robot-framework

MAINTAINER "Jakub Slajer" <j.slajer88@gmail.com>

LABEL name="Docker build for acceptance testing using the robot framework"

# create pythonpath dir and add it to PYTHONPATH env var
RUN mkdir /usr/local/bin/pythonpath
ENV PYTHONPATH="/usr/local/bin/pythonpath:${PYTHONPATH}"

# run tests
CMD ["/scripts/run_suite.sh"]
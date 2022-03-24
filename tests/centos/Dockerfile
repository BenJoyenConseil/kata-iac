FROM centos/systemd
ARG apache_conf
ARG script_path

COPY ${script_path} /setup_vm.sh

MAINTAINER "Benjo" bjc@octo.com

RUN yum -y install sudo httpd apr apr-util-sqlite; yum clean all; systemctl enable httpd.service
RUN /setup_vm.sh

EXPOSE 80

CMD ["/usr/sbin/init"]
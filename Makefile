# Package name goes here
PACKAGE=my-project
# Project name goes here
PROJECT=project
# Package version goes here
VERSION=0.1

DESTDIR=/
BUILDIR=$(CURDIR)/build

all:
	@echo "make source - Create source package"
	@echo "make install - Install on local system"
	@echo "make builddeb - Generate a deb package"
	@echo "make clean - Get rid of scratch and byte files"

source:
	# preparing package scripts
	sed -i -e 's/<your package>/$(PACKAGE)/' setup.py debian/postinst debian/install debian/control debian/conffiles debian/changelog docs/project-uwsgi.ini docs/wsgi.conf; \
	sed -i -e 's/<your project>/$(PROJECT)/' setup.py debian/postinst debian/install debian/control debian/conffiles debian/changelog docs/project-uwsgi.ini docs/wsgi.conf; \
	tar -czf $(CURDIR)/../$(PACKAGE)_$(VERSION).orig.tar.gz project debian docs
	rm -rf $(BUILDIR)

install:
	make source

builddeb:
	make clean
	make source
	# build the package
	dpkg-buildpackage -i -I -uc -us -rfakeroot

clean:
	rm -rf build/ MANIFEST
	rm -rf $(CURDIR)/../$(PACKAGE)*.orig.tar.gz
	find . -name '*.pyc' -delete

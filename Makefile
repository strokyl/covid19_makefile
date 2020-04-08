all: open_form

marianne-regular-webfont.daa94941.woff2:
	curl https://media.interieur.gouv.fr/deplacement-covid-19/marianne-regular-webfont.daa94941.woff2 -o $(CURDIR)/marianne-regular-webfont.daa94941.woff2

MIN_Interieur_RVB.57f44120.svg:
	curl https://media.interieur.gouv.fr/deplacement-covid-19/MIN_Interieur_RVB.57f44120.svg -o $(CURDIR)/MIN_Interieur_RVB.57f44120.svg

certificate.55cc4385.css: MIN_Interieur_RVB.57f44120.svg marianne-regular-webfont.daa94941.woff2
	curl https://media.interieur.gouv.fr/deplacement-covid-19/certificate.55cc4385.css | sed 's/\/deplacement-covid-19/./g' > $(CURDIR)/certificate.55cc4385.css

certificate.c3e09903.js:
	curl https://media.interieur.gouv.fr/deplacement-covid-19/certificate.c3e09903.js -o $(CURDIR)/certificate.c3e09903.js

incapsula_resource.js:
	curl 'https://media.interieur.gouv.fr/_Incapsula_Resource?SWJIYLWA=719d34d31c8e3a6e6fffd425f7e032f3&ns=1&cb=656833804' -o $(CURDIR)/incapsula_resource.js

default.js:
	@ echo "Prénom : "; \
	read default_firstname; \
	echo "Nom : "; \
	read default_lastname; \
	echo "Date de naissance (DD/MM/YYYY) : "; \
	read default_birthday; \
	echo "Lieu de naissance : "; \
	read default_birthplace; \
	echo "Adresse (rue et numéro) : "; \
	read default_address; \
	echo "Code postal : "; \
	read default_zipcode; \
	echo "Ville : "; \
	read default_town; \
  export default_firstname default_lastname default_birthday default_birthplace default_address default_town default_zipcode; \
	cat $(CURDIR)/default.js.tmp | envsubst > $(CURDIR)/default.js

pdf_in_base64.js:
	echo '(function() {window.pdf_in_base64 ="'$$(curl https://media.interieur.gouv.fr/deplacement-covid-19/certificate.84dda806.pdf | base64 -w 0)'"})();' > $(CURDIR)/pdf_in_base64.js

covid19.html: certificate.55cc4385.css certificate.c3e09903.js incapsula_resource.js pdf_in_base64.js default.js
	curl https://media.interieur.gouv.fr/deplacement-covid-19/ | \
	sed 's/\/deplacement-covid-19/./g' | \
  sed 's/\/_Incapsula_Resource?SWJIYLWA=719d34d31c8e3a6e6fffd425f7e032f3&ns=1&cb=656833804/.\/incapsula_resource.js/g' | \
  sed 's/<\/body>/<script src="default.js"><\/script><script src="pdf_in_base64.js"><\/script><script src="patch_fetch.js"><\/script><\/body>/'> $(CURDIR)/covid19.html

clean:
	rm $(CURDIR)/*.css $(CURDIR)/*.html $(CURDIR)/*.svg $(CURDIR)/default.js $(CURDIR)/pdf_in_base64.js $(CURDIR)/incapsula_resource.js $(CURDIR)/certificate.c3e09903.js $(CURDIR)/*.woff2

open_form: covid19.html
	browse $(CURDIR)/covid19.html

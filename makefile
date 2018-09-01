install: download generate_help
	# sudo pip3 install wikitionaryparser
	cd /tmp/ && \
		git clone --depth 1 https://github.com/Suyash458/WiktionaryParser && \
		cd WiktionaryParser && \
		sudo pip install -r "requirements.txt"
	sudo pip3 install -e ".[all]"

download: download/websters_unabridged_dictionary_by_various.txt.utf-8
	:

download/websters_unabridged_dictionary_by_various.txt.utf-8:
	python3 ./vim_dictionary/download_dictionary.py
	touch download/websters_unabridged_dictionary_by_various.txt.utf-8

generate_help: doc/tags
	:

doc/tags:
	vim -i NONE -u NONE --cmd "helptags ./doc/" --cmd "q!"

clean: backup
	find . -iname "__pycache__" -print0 | xargs -0 rm -rf
	find . -iname "*.pyc" -print0 | xargs -0 rm -rf
	rm -rf ./vim_dictionary.egg-info ./doc/tags ./download/* ./dist ./build || true

backup:
	cp -rf ./download/ /tmp

test: download
	bash -x ./tests/test.sh

VENDOR := optiz0r
AGENT := r10k
VERSION := $(shell jq -r '.metadata.version' < agent/${AGENT}.json)
DIST_DIR := dist
MODULE_FILE := ${VENDOR}-mcollective_agent_${AGENT}-${VERSION}.tar.gz
FORGE_URL := https://forgeapi.puppet.com/v3/releases
FORGE_TOKEN_FILE := ~/.puppet_forge.token
FORGE_TOKEN := $(shell test -f ${FORGE_TOKEN_FILE} && cat ${FORGE_TOKEN_FILE})

default: puppet-module

puppet-module: ${DIST_DIR}/${MODULE_FILE}

agent/${AGENT}.json:
	choria plugin generate ddl agent/${AGENT}.json

agent/${AGENT}.ddl: agent/${AGENT}.json
	choria plugin generate ddl agent/${AGENT}.json agent/${AGENT}.ddl

.PHONY: ddl
ddl:
	choria plugin generate ddl agent/${AGENT}.json agent/${AGENT}.ddl

puppet/CHANGELOG.md: CHANGELOG.md
	mkdir -p puppet
	cp CHANGELOG.md puppet/

puppet/LICENSE: LICENSE
	mkdir -p puppet
	cp LICENSE puppet/

${DIST_DIR}/${MODULE_FILE}: puppet/CHANGELOG.md puppet/LICENSE agent/${AGENT}.ddl agent/${AGENT}
	/opt/puppetlabs/puppet/bin/mco plugin package --vendor ${VENDOR} --pluginversion ${VERSION} -v .
	mkdir -p ${DIST_DIR}
	mv ${MODULE_FILE} ${DIST_DIR}/

publish: ${DIST_DIR}/${MODULE_FILE}
	curl -X POST --header "Authorization: Bearer ${FORGE_TOKEN}" -F file=@${DIST_DIR}/${MODULE_FILE} ${FORGE_URL}

clean:
	rm -f ${VENDOR}-mcollective_agent_${AGENT}-*.tar.gz
	find puppet -mindepth 1 -delete

clobber: clean
	find ${DIST_DIR} -name ${MODULE_FILE} -delete


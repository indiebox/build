#
# Makefile for the red channel
#

VERBOSE=-v
# VERBOSE=-v -v -i
CHANNEL=red
FROMCHANNEL=dev

include common.mk

FROMDEPOTAPPCONFIGID!=sudo ubos-admin showappconfig --brief --host depot.ubos.net --context /$(FROMCHANNEL) 2>/dev/null

ifdef FROMDEPOTAPPCONFIGID
	FROMREPODIR=/var/lib/ubos-repo/$(FROMDEPOTAPPCONFIGID)
else
	FROMREPODIR=$(WORKAREA)/repository/$(FROMCHANNEL)
endif



## Public targets

TARGETS=\
    promote-from-dev \
	build-images \
	burn-to-usb \
	code-is-current \
	compress-images \
	delete-all-vms-on-account \
	upload \
	pacsane \
	purge \
	run-webapptests \
	run-webapptests-hl \
	run-webapptests-workout
	
promote-from-dev :
	macrobuild UBOS::Macrobuild::BuildTasks::PromoteChannel \
		--configdir "$(CONFIGDIR)" \
		--archUpstreamDir "$(ARCHUPSTREAMDIR)" \
		--arch "$(ARCH)" \
		--fromRepodir "$(FROMREPODIR)" \
		--fromChannel "$(FROMCHANNEL)" \
		--toRepodir "$(REPODIR)" \
		--toChannel "$(CHANNEL)" \
		$(SIGNDBSARG) \
		$(VERBOSE)

upload :
	macrobuild UBOS::Macrobuild::BuildTasks::UploadChannel \
		--arch "$(ARCH)" \
		--repodir "$(REPODIR)" \
		--channel "$(CHANNEL)" \
		--imagesdir "$(IMAGESDIR)" \
		--uploadDest "$(UPLOADDEST)" \
		--uploadSshKey "$(UPLOADSSHKEY)" \
		$(VERBOSE)

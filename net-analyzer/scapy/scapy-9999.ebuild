# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit eutils distutils-r1 git-r3

DESCRIPTION="A Python interactive packet manipulation program for mastering the network"
HOMEPAGE="http://www.secdev.org/projects/scapy/"
EGIT_REPO_URI="https://github.com/secdev/${PN}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="gnuplot pyx crypt graphviz imagemagick visual tcpreplay"

RDEPEND="
	net-analyzer/tcpdump
	gnuplot? ( dev-python/gnuplot-py[${PYTHON_USEDEP}] )
	pyx? ( dev-python/pyx[${PYTHON_USEDEP}] )
	crypt? ( dev-python/pycrypto[${PYTHON_USEDEP}] )
	graphviz? ( media-gfx/graphviz )
	imagemagick? ( virtual/imagemagick-tools )
	visual? ( dev-python/visual )
	tcpreplay? ( net-analyzer/tcpreplay )
"

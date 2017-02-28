# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit multiprocessing toolchain-funcs

BV=0.20.4-1
BV_AMD64=${BV}-linux-x86_64
BV_X86=${BV}-linux-i686

DESCRIPTION="The Crystal Programming Language"
HOMEPAGE="http://crystal-lang.org"
SRC_URI="https://github.com/crystal-lang/crystal/archive/${PV}.tar.gz -> ${P}.tar.gz
	amd64? ( https://github.com/crystal-lang/crystal/releases/download/${PV}/crystal-${BV_AMD64}.tar.gz )
	x86? ( https://github.com/crystal-lang/crystal/releases/download/${PV}/crystal-${BV_X86}.tar.gz )"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc examples +xml +yaml"

# dev-libs/boehm-gc[static-libs] dependency problem,  check the issue: https://github.com/manastech/crystal/issues/1382
DEPEND="
	>=sys-devel/llvm-3.9.0
	dev-libs/boehm-gc[static-libs,threads]
	dev-libs/libatomic_ops
	dev-libs/libevent
	dev-libs/libpcre
	sys-libs/libunwind
	dev-libs/pcl
	dev-libs/gmp:0
"
RDEPEND="${DEPEND}
	xml? ( dev-libs/libxml2 )
	yaml? ( dev-libs/libyaml )
"

PATCHES=(
	"${FILESDIR}"/${P}-AR.patch
	"${FILESDIR}"/${P}-verbose.patch
)

src_compile() {
	emake \
		release=1 \
		stats=1 \
		threads=$(makeopts_jobs) \
		verbose=1 \
		\
		CC=$(tc-getCC) \
		CXX=$(tc-getCXX) \
		AR=$(tc-getAR) \
		\
		PATH="${WORKDIR}"/${PN}-${BV}/bin:"${PATH}" \
		CRYSTAL_PATH=src \
		CRYSTAL_CONFIG_VERSION=${PV} \
		CRYSTAL_CONFIG_PATH="lib:${EPREFIX}/usr/$(get_libdir)/crystal"
	use doc && emake doc
}

src_test() {
	emake spec \
		verbose=1 \
		\
		CRYSTAL_PATH=src \
		CRYSTAL_CONFIG_VERSION=${PV}
}

src_install() {
	insinto /usr/$(get_libdir)/crystal
	doins -r src/.
	dobin .build/crystal

	insinto /usr/share/zsh/site-functions
	newins etc/completion.zsh _crystal

	use examples && dodoc -r samples

	if use doc ; then
		docinto api
		dodoc -r doc/.
	fi
}

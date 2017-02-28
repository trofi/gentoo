# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

# ebuild generated by hackport 0.2.17.9999

EAPI=4

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Analysis and generation of C code"
HOMEPAGE="http://www.sivity.net/projects/language.c/"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND="dev-haskell/syb[profile?]
		>=dev-lang/ghc-6.10.1"
DEPEND="${RDEPEND}
		dev-haskell/alex
		>=dev-haskell/cabal-1.6
		dev-haskell/happy"

src_prepare() {
	rm -vf "${S}"/dist/build/Language/C/Parser/{Lexer,Parser}.hs
}

#!/bin/sh
#
# rnpctl
#
# A helper script I wrote for managing development on macOS.

[ -z "$GITHUB_USER" ] && GITHUB_USER='shaunwheelhouse'

[ -z "$GITHUB_USER_UPSTREAM" ] && GITHUB_USER_UPSTREAM='riboseinc'

[ -z "$REPO" ] && REPO='rnp'

[ -z "$REPO_FORMULA" ] && REPO_FORMULA='formulae'

[ -z "$REPO_UPSTREAM" ] && REPO_UPSTREAM='rnp'

TAP="$GITHUB_USER/$REPO_FORMULA"

ORIGIN="$GITHUB_USER/$REPO"

ORIGIN_NAME='origin'

UPSTREAM="$GITHUB_USER_UPSTREAM/$REPO_UPSTREAM"

UPSTREAM_NAME='ribose'

rnp_clone() {
	repo="$1"

	if [ -z "$repo" ]; then
		repo="$REPO"
	fi

	if [ -f "$repo" ]; then
		echo "fatal: '$repo' is a file" >&2
		return 1
	fi

	if git clone git@github.com:$ORIGIN.git $repo; then
		cd $repo
		git remote add $UPSTREAM_NAME git@github.com:$UPSTREAM.git
		git fetch $UPSTREAM_NAME
		cd "$OLDPWD"
	fi
}

rnp_install_action() {
	brew update
	brew $1 $TAP/rnp --HEAD
}

rnp_install() {
	rnp_install_action install
}

rnp_reinstall() {
	rnp_install_action reinstall
}

rnp_uninstall() {
	brew uninstall $TAP/rnp
}

rnp_print_usage() {
	echo "Usage: $(basename $0) <clone|install|reinstall|uninstall>" >&2
	return 1
}

rnpctl() {
	case "$1" in
	clone)
		rnp_clone "$2"
		;;
	install)
		rnp_install
		;;
	reinstall)
		rnp_reinstall
		;;
	uninstall)
		rnp_uninstall
		;;
	-h|--help|*)
		rnp_print_usage
		;;
	esac
}

if ! echo $- | grep i >/dev/null; then
	rnpctl $@
fi

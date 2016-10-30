# Generically support epatch_user in every ebuild if available:
post_src_prepare() {
	if type epatch_user &> /dev/null ; then
		cd ${S}
		epatch_user
	fi
}

# for gdm, enable old ssh agent for now:
if [ "${EBUILD_PHASE}" = "postinst" -a "${PN}" = "gdm" ]; then
	echo ":: Enabling old ssh-agent via xinit..."
	chmod +x /etc/X11/xinit/xinitrc.d/50-ssh-agent
fi

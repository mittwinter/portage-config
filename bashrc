# Generically support epatch_user in every ebuild if available:
pre_src_prepare() {
	[[ ${EAPI:-0} == [012345] ]] || return
	if ! type estack_push > /dev/null 2>&1; then
		local estack_names="eshopts_push eshopts_pop evar_push evar_push_set evar_pop estack_push estack_pop"
		source <(awk "/^# @(FUNCTION|VARIABLE): / { p = 0 } /^# @(FUNCTION|VARIABLE): (${estack_names// /|})\$/ { p = 1 } p { print }" ${PORTDIR}/eclass/estack.eclass)
	fi
	if ! type epatch_user > /dev/null 2>&1; then
		local epatch_names="EPATCH_SOURCE EPATCH_USER_SOURCE epatch_user_death_notice epatch_user epatch"
		source <(awk "/^# @(FUNCTION|VARIABLE): / { p = 0 } /^# @(FUNCTION|VARIABLE): (${epatch_names// /|})\$/ { p = 1 } p { print }" ${PORTDIR}/eclass/epatch.eclass)
	fi

	epatch_user

	for name in $epatch_names; do
		unset $name
	done
	for name in $estack_names; do
		unset $name
	done
}

if [ "${EBUILD_PHASE}" = "postinst" -a "${PN}" = "mailman" ]; then
	echo ":: Adjusting mailman's cgi-bin permissions..."
	chmod o+r /usr/lib/mailman/cgi-bin/*
	echo ":: Adjusting mailman's archives permissions..."
	chmod o+x /var/lib/mailman/archives/private
fi

# for gdm, enable old ssh agent for now:
if [ "${EBUILD_PHASE}" = "postinst" -a "${PN}" = "gdm" ]; then
	echo ":: Enabling old ssh-agent via xinit..."
	chmod +x /etc/X11/xinit/xinitrc.d/50-ssh-agent
fi

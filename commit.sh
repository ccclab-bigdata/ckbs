#! /bin/bash -e
#
# replacement text for this commit
cat << EOF > commit.$$

Removed srcIP, and added covariance estimation routine and test. 
EOF
# -----------------------------------------------------------------------
if [ "$1" == 'files' ]
then
	echo "rm commit.[0-9]*"
	rm commit.[0-9]*
	#
	echo "cp commit.sh commit.old"
	cp commit.sh commit.old
	#
	echo "svn revert commit.sh"
	svn revert commit.sh
	#
	sed -n -e '1,/^$/p' < commit.sh > commit.$$ 
	svn status | sed -n -e '/^[ADMRC] /p' | \
		sed -e 's/^[ADMR] [+ ]*//' -e 's/$/@/' | \
		sort -u >> commit.$$
	sed -n -e '/^EOF/,$p' < commit.sh >> commit.$$ 
	#
	echo "diff commit.sh commit.$$"
	if diff commit.sh commit.$$
	then
		echo "commit.sh: exiting because commit.sh has not changed"
		exit 1
	fi
	#
	echo "mv commit.$$ commit.sh"
	mv commit.$$ commit.sh
	#
	chmod +x commit.sh
	exit 0
fi
# -----------------------------------------------------------------------
if [ "$1" != 'run' ]
then
cat << EOF
usage: ./commit.sh files
       ./commit.sh run

example/tridiag_solve_ok.m@
src/ckbs_tridiag_solve.m@
src/ckbs_tridiag_solve_b.m@
src/ckbs_tridiag_solve_mf.m@
EOF
# -----------------------------------------------------------------------
if [ "$1" == 'files' ]
then
	echo "rm commit.[0-9]*"
	rm commit.[0-9]*
	#
	echo "cp commit.sh commit.old"
	cp commit.sh commit.old
	#
	echo "svn revert commit.sh"
	svn revert commit.sh
	#
	sed -n -e '1,/^$/p' < commit.sh > commit.$$ 
	svn status | sed -n -e '/^[ADMRC] /p' | \
		sed -e 's/^[ADMR] [+ ]*//' -e 's/$/@/' | \
		sort -u >> commit.$$
	sed -n -e '/^EOF/,$p' < commit.sh >> commit.$$ 
	#
	echo "diff commit.sh commit.$$"
	if diff commit.sh commit.$$
	then
		echo "commit.sh: exiting because commit.sh has not changed"
		exit 1
	fi
	#
	echo "mv commit.$$ commit.sh"
	mv commit.$$ commit.sh
	#
	chmod +x commit.sh
	exit 0
fi
# -----------------------------------------------------------------------
if [ "$1" != 'run' ]
then
cat << EOF
usage: ./commit.sh files
       ./commit.sh run

example/tridiag_inv_ok.m@
src/ckbs_tridiag_inv.m@
EOF
# -----------------------------------------------------------------------
if [ "$1" == 'files' ]
then
	echo "rm commit.[0-9]*"
	rm commit.[0-9]*
	#
	echo "cp commit.sh commit.old"
	cp commit.sh commit.old
	#
	echo "svn revert commit.sh"
	svn revert commit.sh
	#
	sed -n -e '1,/^$/p' < commit.sh > commit.$$ 
	svn status | sed -n -e '/^[ADMRC] /p' | \
		sed -e 's/^[ADMR] [+ ]*//' -e 's/$/@/' | \
		sort -u >> commit.$$
	sed -n -e '/^EOF/,$p' < commit.sh >> commit.$$ 
	#
	echo "diff commit.sh commit.$$"
	if diff commit.sh commit.$$
	then
		echo "commit.sh: exiting because commit.sh has not changed"
		exit 1
	fi
	#
	echo "mv commit.$$ commit.sh"
	mv commit.$$ commit.sh
	#
	chmod +x commit.sh
	exit 0
fi
# -----------------------------------------------------------------------
if [ "$1" != 'run' ]
then
cat << EOF
usage: ./commit.sh files
       ./commit.sh run

The first from changes the list of files at the beginning of commit.sh 
so that it all the files that have changed status.
You should then edit commit.sh by hand (as per the instrucgtion at the 
beginning of commit.sh) before running the second form.

The second form actually commits the list of files (provided that you reply
y to the [y/n] prompt that commit.sh generates).
EOF
	rm commit.$$
	exit 0
fi
# -----------------------------------------------------------------------
list=`sed -e '/@/! d' -e 's/@.*//' commit.$$`
msg=`sed -e '/@ *$/d' -e 's|.*/\([^/]*@\)|\1|' -e 's|@|:|' commit.$$`
rm commit.$$
echo "svn commit -m \""
echo "$msg"
echo "\" \\"
echo "$list"
read -p "is this ok [y/n] ?" response
if [ "$response" != "y" ]
then
	exit 1
fi
#
if ! svn commit -m "$msg" $list
then
	echo "commit.sh: commit failed"
	exit 1
fi
#
echo "mv commit.sh commit.old"
mv commit.sh commit.old
#
svn revert commit.sh

dnl #
dnl # 3.3 API change
dnl # The VFS .create, .mkdir and .mknod callbacks were updated to take a
dnl # umode_t type rather than an int.  The expectation is that any backport
dnl # would also change all three prototypes.  However, if it turns out that
dnl # some distribution doesn't backport the whole thing this could be
dnl # broken apart in to three seperate checks.
dnl #
AC_DEFUN([ZFS_AC_KERNEL_CREATE_UMODE_T], [
	AC_MSG_CHECKING([whether iops->create()/mkdir()/mknod() take umode_t])
	ZFS_LINUX_TRY_COMPILE([
		#include <linux/fs.h>
	],[
		int (*create) (struct inode *, struct dentry *, umode_t,
		    struct nameidata *) = NULL;
		struct inode_operations iops __attribute__ ((unused)) = {
			.create = create,
		};
	],[
		AC_MSG_RESULT(yes)
		AC_DEFINE(HAVE_CREATE_UMODE_T, 1,
		    [iops->create()/mkdir()/mknod() take umode_t])
	],[
		AC_MSG_RESULT(no)
	])
])

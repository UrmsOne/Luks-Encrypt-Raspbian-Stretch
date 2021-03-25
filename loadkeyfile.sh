#!/bin/busybox ash

# if [ -f /dev/sdb1 ]; then
#     echo "mount the divece containing keyfile ..."
#     mount /dev/sdb1 /root/key 2> /dev/null
# fi

# KEY="${1}"
# if [ -f "${KEY}" ]; then
#     cat "${KEY}"
# else
#     echo "FAILED to find suitable USB keychain ..." >&2
#     echo -n "Try to enter your password: " >&2
#     read -s -r PASSWD < /dev/console echo -n "$PASSWD"
# fi

# if [ -f /dev/sdb1 ]; then umount /dev/sdb1 2> /dev/null
# fi
# echo -n "your-encryption-password"
echo -n "123456"
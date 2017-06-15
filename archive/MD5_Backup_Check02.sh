#!/bin/bash
# Shell script to check MD5 sum of files in test directory against those in main directory
#
cd /homes/mlucas/backup
find *.md5 -type f -print0 | xargs -0 md5sum > /homes/mlucas/backup_checksums.txt
md5sum -c --status /homes/mlucas/backup_checksums.txt
cd /homes/mlucas/incoming
find *.md5 -type f -print0 | xargs -0 md5sum > /homes/mlucas/incoming_checksums.txt
md5sum -c --status /homes/mlucas/incoming_checksums.txt
cd /homes/mlucas
diff -y --suppress-common-lines backup_checksums.txt incoming_checksums.txt > checksum_diffs.txt

#!/bin/bash
# Shell script to check MD5 sum of files in test directory against those in main directory
#
find /homes/mlucas/backup/*.md5 -type f -print0 | xargs -0 md5sum > /homes/mlucas/backup_checksums.txt
md5sum -c /homes/mlucas/backup_checksums.txt
find /homes/mlucas/incoming/*.md5 -type f -print0 | xargs -0 md5sum > /homes/mlucas/incoming_checksums.txt
md5sum -c /homes/mlucas/incoming_checksums.txt
diff -w backup_checksums.txt incoming_checksums.txt > checksum_diffs.txt

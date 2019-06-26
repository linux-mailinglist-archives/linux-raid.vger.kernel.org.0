Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87844563CC
	for <lists+linux-raid@lfdr.de>; Wed, 26 Jun 2019 09:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfFZHzJ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 26 Jun 2019 03:55:09 -0400
Received: from mga09.intel.com ([134.134.136.24]:4096 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbfFZHzJ (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Wed, 26 Jun 2019 03:55:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2019 00:55:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,419,1557212400"; 
   d="scan'208";a="360225215"
Received: from unknown (HELO linux-spw6.igk.intel.com) ([10.102.102.170])
  by fmsmga005.fm.intel.com with ESMTP; 26 Jun 2019 00:55:06 -0700
From:   Mariusz Dabrowski <mariusz.dabrowski@intel.com>
To:     jes.sorensen@gmail.com
Cc:     linux-raid@vger.kernel.org,
        Mariusz Dabrowski <mariusz.dabrowski@intel.com>,
        Krzysztof Smolinski <krzysztof.smolinski@intel.com>
Subject: [PATCH] mdadm: load default sysfs attributes after assemblation
Date:   Wed, 26 Jun 2019 09:50:06 +0200
Message-Id: <20190626075006.4815-1-mariusz.dabrowski@intel.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Added new type of line to mdadm.conf which allows to specify values of
sysfs attributes for MD devices that should be loaded after assemblation.
Each line is interpreted as list of structures containing sysname of MD
device (md126 etc.) and list of sysfs attributes and their values.

Signed-off-by: Mariusz Dabrowski <mariusz.dabrowski@intel.com>
Signed-off-by: Krzysztof Smolinski <krzysztof.smolinski@intel.com>
---
 Assemble.c    |  12 +++--
 Incremental.c |   1 +
 config.c      |   7 ++-
 mdadm.conf.5  |  25 ++++++++++
 mdadm.h       |   3 ++
 sysfs.c       | 158 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 202 insertions(+), 4 deletions(-)

diff --git a/Assemble.c b/Assemble.c
index 420c7b39..b2e69144 100644
--- a/Assemble.c
+++ b/Assemble.c
@@ -1063,9 +1063,12 @@ static int start_array(int mdfd,
 			       mddev, okcnt + sparecnt + journalcnt,
 			       okcnt + sparecnt + journalcnt == 1 ? "" : "s");
 			if (okcnt < (unsigned)content->array.raid_disks)
-				fprintf(stderr, " (out of %d)",
+				fprintf(stderr, " (out of %d)\n",
 					content->array.raid_disks);
-			fprintf(stderr, "\n");
+			else {
+				fprintf(stderr, "\n");
+				sysfs_rules_apply(mddev, content);
+			}
 		}
 
 		if (st->ss->validate_container) {
@@ -1139,6 +1142,7 @@ static int start_array(int mdfd,
 			rv = ioctl(mdfd, RUN_ARRAY, NULL);
 		reopen_mddev(mdfd); /* drop O_EXCL */
 		if (rv == 0) {
+			sysfs_rules_apply(mddev, content);
 			if (c->verbose >= 0) {
 				pr_err("%s has been started with %d drive%s",
 				       mddev, okcnt, okcnt==1?"":"s");
@@ -2130,10 +2134,12 @@ int assemble_container_content(struct supertype *st, int mdfd,
 			pr_err("array %s now has %d device%s",
 			       chosen_name, working + preexist,
 			       working + preexist == 1 ? "":"s");
-		else
+		else {
+			sysfs_rules_apply(chosen_name, content);
 			pr_err("Started %s with %d device%s",
 			       chosen_name, working + preexist,
 			       working + preexist == 1 ? "":"s");
+		}
 		if (preexist)
 			fprintf(stderr, " (%d new)", working);
 		if (expansion)
diff --git a/Incremental.c b/Incremental.c
index d4d3c353..98dbcd92 100644
--- a/Incremental.c
+++ b/Incremental.c
@@ -480,6 +480,7 @@ int Incremental(struct mddev_dev *devlist, struct context *c,
 			pr_err("container %s now has %d device%s\n",
 			       chosen_name, info.array.working_disks,
 			       info.array.working_disks == 1?"":"s");
+		sysfs_rules_apply(chosen_name, &info);
 		wait_for(chosen_name, mdfd);
 		if (st->ss->external)
 			strcpy(devnm, fd2devnm(mdfd));
diff --git a/config.c b/config.c
index e14eae0c..7592b2d7 100644
--- a/config.c
+++ b/config.c
@@ -80,7 +80,8 @@ char DefaultAltConfFile[] = CONFFILE2;
 char DefaultAltConfDir[] = CONFFILE2 ".d";
 
 enum linetype { Devices, Array, Mailaddr, Mailfrom, Program, CreateDev,
-		Homehost, HomeCluster, AutoMode, Policy, PartPolicy, LTEnd };
+		Homehost, HomeCluster, AutoMode, Policy, PartPolicy, Sysfs,
+		LTEnd };
 char *keywords[] = {
 	[Devices]  = "devices",
 	[Array]    = "array",
@@ -93,6 +94,7 @@ char *keywords[] = {
 	[AutoMode] = "auto",
 	[Policy]   = "policy",
 	[PartPolicy]="part-policy",
+	[Sysfs]    = "sysfs",
 	[LTEnd]    = NULL
 };
 
@@ -764,6 +766,9 @@ void conf_file(FILE *f)
 		case PartPolicy:
 			policyline(line, rule_part);
 			break;
+		case Sysfs:
+			sysfsline(line);
+			break;
 		default:
 			pr_err("Unknown keyword %s\n", line);
 		}
diff --git a/mdadm.conf.5 b/mdadm.conf.5
index 47c962ab..ae02a770 100644
--- a/mdadm.conf.5
+++ b/mdadm.conf.5
@@ -587,6 +587,26 @@ be based on the domain, but with
 appended, when N is the partition number for the partition that was
 found.
 
+.TP
+.B SYSFS
+The SYSFS line lists custom values of MD device's sysfs attributes which will be
+stored in sysfs after assemblation. Multiple lines are allowed and each line has
+to contain uuid or name of the device to which it relates.
+.RS 4
+.TP
+.B uuid=
+hexadecimal identifier of MD device. This must match the uuid stored in the
+superblock.
+.TP
+.B name=
+name of the MD device as was given to
+.I mdadm
+when the array was created. It will be ignored if
+.B uuid
+is not empty.
+.TP
+.RS 7
+
 .SH EXAMPLE
 DEVICE /dev/sd[bcdjkl]1
 .br
@@ -657,6 +677,11 @@ CREATE group=system mode=0640 auto=part\-8
 HOMEHOST <system>
 .br
 AUTO +1.x homehost \-all
+.br
+SYSFS name=/dev/md/raid5 group_thread_cnt=4 sync_speed_max=1000000
+.br
+SYSFS uuid=bead5eb6:31c17a27:da120ba2:7dfda40d group_thread_cnt=4
+sync_speed_max=1000000
 
 .SH SEE ALSO
 .BR mdadm (8),
diff --git a/mdadm.h b/mdadm.h
index 705bd9b5..da0058b8 100644
--- a/mdadm.h
+++ b/mdadm.h
@@ -1291,6 +1291,9 @@ void domain_add(struct domainlist **domp, char *domain);
 extern void policy_save_path(char *id_path, struct map_ent *array);
 extern int policy_check_path(struct mdinfo *disk, struct map_ent *array);
 
+extern void sysfs_rules_apply(char *devnm, struct mdinfo *dev);
+extern void sysfsline(char *line);
+
 #if __GNUC__ < 3
 struct stat64;
 #endif
diff --git a/sysfs.c b/sysfs.c
index df6fdda3..e47524ff 100644
--- a/sysfs.c
+++ b/sysfs.c
@@ -26,9 +26,22 @@
 #include	"mdadm.h"
 #include	<dirent.h>
 #include	<ctype.h>
+#include	"dlink.h"
 
 #define MAX_SYSFS_PATH_LEN	120
 
+struct dev_sysfs_rule {
+	struct dev_sysfs_rule *next;
+	char *devname;
+	int uuid[4];
+	int uuid_set;
+	struct sysfs_entry {
+		struct sysfs_entry *next;
+		char *name;
+		char *value;
+	} *entry;
+};
+
 int load_sys(char *path, char *buf, int len)
 {
 	int fd = open(path, O_RDONLY);
@@ -994,3 +1007,148 @@ int sysfs_wait(int fd, int *msec)
 	}
 	return n;
 }
+
+int sysfs_rules_apply_check(const struct mdinfo *sra,
+			    const struct sysfs_entry *ent)
+{
+	/* Check whether parameter is regular file,
+	 * exists and is under specified directory.
+	 */
+	char fname[MAX_SYSFS_PATH_LEN];
+	char dname[MAX_SYSFS_PATH_LEN];
+	char resolved_path[PATH_MAX];
+	char resolved_dir[PATH_MAX];
+
+	if (sra == NULL || ent == NULL)
+		return -1;
+
+	snprintf(dname, MAX_SYSFS_PATH_LEN, "/sys/block/%s/md/", sra->sys_name);
+	snprintf(fname, MAX_SYSFS_PATH_LEN, "%s/%s", dname, ent->name);
+
+	if (realpath(fname, resolved_path) == NULL ||
+	    realpath(dname, resolved_dir) == NULL)
+		return -1;
+
+	if (strncmp(resolved_dir, resolved_path,
+		    strnlen(resolved_dir, PATH_MAX)) != 0)
+		return -1;
+
+	return 0;
+}
+
+static struct dev_sysfs_rule *sysfs_rules;
+
+void sysfs_rules_apply(char *devnm, struct mdinfo *dev)
+{
+	struct dev_sysfs_rule *rules = sysfs_rules;
+
+	while (rules) {
+		struct sysfs_entry *ent = rules->entry;
+		int match  = 0;
+
+		if (!rules->uuid_set) {
+			if (rules->devname)
+				match = strcmp(devnm, rules->devname) == 0;
+		} else {
+			match = memcmp(dev->uuid, rules->uuid,
+				       sizeof(int[4])) == 0;
+		}
+
+		while (match && ent) {
+			if (sysfs_rules_apply_check(dev, ent) < 0)
+				pr_err("SYSFS: failed to write '%s' to '%s'\n",
+					ent->value, ent->name);
+			else
+				sysfs_set_str(dev, NULL, ent->name, ent->value);
+			ent = ent->next;
+		}
+		rules = rules->next;
+	}
+}
+
+static void sysfs_rule_free(struct dev_sysfs_rule *rule)
+{
+	struct sysfs_entry *entry;
+
+	while (rule) {
+		struct dev_sysfs_rule *tmp = rule->next;
+
+		entry = rule->entry;
+		while (entry) {
+			struct sysfs_entry *tmp = entry->next;
+
+			free(entry->name);
+			free(entry->value);
+			free(entry);
+			entry = tmp;
+		}
+
+		if (rule->devname)
+			free(rule->devname);
+		free(rule);
+		rule = tmp;
+	}
+}
+
+void sysfsline(char *line)
+{
+	struct dev_sysfs_rule *sr;
+	char *w;
+
+	sr = xcalloc(1, sizeof(*sr));
+	for (w = dl_next(line); w != line ; w = dl_next(w)) {
+		if (strncasecmp(w, "name=", 5) == 0) {
+			char *devname = w + 5;
+
+			if (strncmp(devname, "/dev/md/", 8) == 0) {
+				if (sr->devname)
+					pr_err("Only give one device per SYSFS line: %s\n",
+						devname);
+				else
+					sr->devname = xstrdup(devname);
+			} else {
+				pr_err("%s is an invalid name for an md device - ignored.\n",
+				       devname);
+			}
+		} else if (strncasecmp(w, "uuid=", 5) == 0) {
+			char *uuid = w + 5;
+
+			if (sr->uuid_set) {
+				pr_err("Only give one uuid per SYSFS line: %s\n",
+					uuid);
+			} else {
+				if (parse_uuid(w + 5, sr->uuid) &&
+				    memcmp(sr->uuid, uuid_zero,
+					   sizeof(int[4])) != 0)
+					sr->uuid_set = 1;
+				else
+					pr_err("Invalid uuid: %s\n", uuid);
+			}
+		} else {
+			struct sysfs_entry *prop;
+
+			char *sep = strchr(w, '=');
+
+			if (sep == NULL || *(sep + 1) == 0) {
+				pr_err("Cannot parse \"%s\" - ignoring.\n", w);
+				continue;
+			}
+
+			prop = xmalloc(sizeof(*prop));
+			prop->value = xstrdup(sep + 1);
+			*sep = 0;
+			prop->name = xstrdup(w);
+			prop->next = sr->entry;
+			sr->entry = prop;
+		}
+	}
+
+	if (!sr->devname && !sr->uuid_set) {
+		pr_err("Device name not found in sysfs config entry - ignoring.\n");
+		sysfs_rule_free(sr);
+		return;
+	}
+
+	sr->next = sysfs_rules;
+	sysfs_rules = sr;
+}
-- 
2.16.4


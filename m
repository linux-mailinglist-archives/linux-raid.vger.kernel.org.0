Return-Path: <linux-raid+bounces-1201-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B500886B88
	for <lists+linux-raid@lfdr.de>; Fri, 22 Mar 2024 12:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D477B22A96
	for <lists+linux-raid@lfdr.de>; Fri, 22 Mar 2024 11:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9B33FBA4;
	Fri, 22 Mar 2024 11:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V6I1d4sB"
X-Original-To: linux-raid@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31FD3FB31
	for <linux-raid@vger.kernel.org>; Fri, 22 Mar 2024 11:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711108315; cv=none; b=KbIM4btrvBgOxNlBBTK696phzrVXAu9M4uoF2xZv/06yWWcRJL94PCzQ5nYz/RBeeNvlb+Yvx9KOB/8XL8HGgPIOQIWjoLbIT/UiDEGIqz2dQBknLOyo5MIL7o8IEAxARVmoHeg+9QB+dzPdXktZireGrt+0aienGwgF6Z0lkPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711108315; c=relaxed/simple;
	bh=g4oVcQuPIudWX+nj9UjMQ1lbzEaXOBradsXGCz1u1mY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gempe/oIbCKMZeiISk3fRdquwtLbiImfxVRFosDP87P5RuzUNCHvyx+DTDfPGsIiO5Znq5oOBNyUDwe199nnbOUEytYjGQbNNmPKk1HNVSYLeVu+QZtSLikdG5Ute1eZw+zBs5Ks8pqGsI7ZhrfRZSskMgSw5YGlgz08tymJkR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V6I1d4sB; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711108314; x=1742644314;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g4oVcQuPIudWX+nj9UjMQ1lbzEaXOBradsXGCz1u1mY=;
  b=V6I1d4sBJo0iShLXyIU8WyRi+06qxfqNo2jUXeBQa5OUvPbrKjwHACOY
   3sfjLa4+dorNvzTUtEUzs33joVLqMV8OFFcs70prftYjIX1J9OWK8NDtQ
   U2B59fC5K0If191Lyv5DU2TX37ajtmdsZTJdBpTerH/oOVjp3lG/40mJ5
   tUvnUPEWuxRfsBcxOjrw+35sip8ETw0kItFKbLvIOVjCG8UfXBaDGDQNu
   dwirEbcDTbr2UGF//zO2FtftY7PPu26RiJxF3dJkCCjIjDI5qCm6iBtW2
   90wgq7xcC4xXF+Uzzqy3RK4hRrxbC4qJ+PEQgNpd5/C5iBCdHTYqB11ly
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="6006802"
X-IronPort-AV: E=Sophos;i="6.07,145,1708416000"; 
   d="scan'208";a="6006802"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 04:51:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,145,1708416000"; 
   d="scan'208";a="46001016"
Received: from linux-myjy.igk.intel.com ([10.102.108.92])
  by fmviesa001.fm.intel.com with ESMTP; 22 Mar 2024 04:51:52 -0700
From: Blazej Kucman <blazej.kucman@intel.com>
To: mariusz.tkaczyk@linux.intel.com,
	jes@trained-monkey.org
Cc: linux-raid@vger.kernel.org
Subject: [PATCH v2 4/6] Add key ENCRYPTION_NO_VERIFY to conf
Date: Fri, 22 Mar 2024 12:51:18 +0100
Message-Id: <20240322115120.12325-5-blazej.kucman@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240322115120.12325-1-blazej.kucman@intel.com>
References: <20240322115120.12325-1-blazej.kucman@intel.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ENCRYPTION_NO_VERIFY config key and allow to disable checking
encryption status for given type of drives.

The key is introduced because of SATA Opal disks for which TPM commands
must be enabled in libata kernel module, (libata.allow_tpm=1), otherwise
it is impossible to verify encryption status. TPM commands are disabled by
default.

Currently the key only supports the "sata_opal" value, if necessary,
the functionality is ready to support more types of disks. This
functionality will be used in the next patches.

Signed-off-by: Blazej Kucman <blazej.kucman@intel.com>
---
 config.c           | 25 ++++++++++++++++++++++++-
 drive_encryption.c | 16 ++++++++++++----
 mdadm.conf.5.in    | 13 +++++++++++++
 mdadm.h            |  1 +
 4 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/config.c b/config.c
index 44f7dd2f..b46d71cb 100644
--- a/config.c
+++ b/config.c
@@ -81,7 +81,7 @@ char DefaultAltConfDir[] = CONFFILE2 ".d";
 
 enum linetype { Devices, Array, Mailaddr, Mailfrom, Program, CreateDev,
 		Homehost, HomeCluster, AutoMode, Policy, PartPolicy, Sysfs,
-		MonitorDelay, LTEnd };
+		MonitorDelay, EncryptionNoVerify, LTEnd };
 char *keywords[] = {
 	[Devices]  = "devices",
 	[Array]    = "array",
@@ -96,6 +96,7 @@ char *keywords[] = {
 	[PartPolicy]="part-policy",
 	[Sysfs]    = "sysfs",
 	[MonitorDelay] = "monitordelay",
+	[EncryptionNoVerify] = "ENCRYPTION_NO_VERIFY",
 	[LTEnd]    = NULL
 };
 
@@ -729,6 +730,19 @@ void monitordelayline(char *line)
 	}
 }
 
+static bool sata_opal_encryption_no_verify;
+void encryption_no_verify_line(char *line)
+{
+	char *word;
+
+	for (word = dl_next(line); word != line; word = dl_next(word)) {
+		if (strcasecmp(word, "sata_opal") == 0)
+			sata_opal_encryption_no_verify = true;
+		else
+			pr_err("unrecognised word on ENCRYPTION_NO_VERIFY line: %s\n", word);
+	}
+}
+
 char auto_yes[] = "yes";
 char auto_no[] = "no";
 char auto_homehost[] = "homehost";
@@ -913,6 +927,9 @@ void conf_file(FILE *f)
 		case MonitorDelay:
 			monitordelayline(line);
 			break;
+		case EncryptionNoVerify:
+			encryption_no_verify_line(line);
+			break;
 		default:
 			pr_err("Unknown keyword %s\n", line);
 		}
@@ -1075,6 +1092,12 @@ int conf_get_monitor_delay(void)
 	return monitor_delay;
 }
 
+bool conf_get_sata_opal_encryption_no_verify(void)
+{
+	load_conffile();
+	return sata_opal_encryption_no_verify;
+}
+
 struct createinfo *conf_get_create_info(void)
 {
 	load_conffile();
diff --git a/drive_encryption.c b/drive_encryption.c
index d520f0c7..6b2bd358 100644
--- a/drive_encryption.c
+++ b/drive_encryption.c
@@ -656,10 +656,18 @@ get_ata_encryption_information(int disk_fd, struct encryption_information *infor
 	if (status == MDADM_STATUS_ERROR)
 		return MDADM_STATUS_ERROR;
 
-	if (is_ata_trusted_computing_supported(buffer_identify) &&
-	    !sysfs_is_libata_allow_tpm_enabled(verbose)) {
-		pr_vrb("For SATA with Trusted Computing support, required libata.tpm_enabled=1.\n");
-		return MDADM_STATUS_ERROR;
+	/* Possible OPAL support, further checks require tpm_enabled.*/
+	if (is_ata_trusted_computing_supported(buffer_identify)) {
+		/* OPAL SATA encryption checking disabled. */
+		if (conf_get_sata_opal_encryption_no_verify())
+			return MDADM_STATUS_SUCCESS;
+
+		if (!sysfs_is_libata_allow_tpm_enabled(verbose)) {
+			pr_vrb("Detected SATA drive /dev/%s with Trusted Computing support.\n",
+			       fd2kname(disk_fd));
+			pr_vrb("Cannot verify encryption state. Requires libata.tpm_enabled=1.\n");
+			return MDADM_STATUS_ERROR;
+		}
 	}
 
 	ata_opal_status = is_ata_opal(disk_fd, buffer_identify, verbose);
diff --git a/mdadm.conf.5.in b/mdadm.conf.5.in
index 787e51e9..afb0a296 100644
--- a/mdadm.conf.5.in
+++ b/mdadm.conf.5.in
@@ -636,6 +636,17 @@ If multiple
 .B MINITORDELAY
 lines are provided, only first non-zero value is considered.
 
+.TP
+.B ENCRYPTION_NO_VERIFY
+The
+.B ENCRYPTION_NO_VERIFY
+disables encryption verification for devices with particular encryption support detected.
+Currently, only verification of SATA OPAL encryption can be disabled.
+It does not disable ATA security encryption verification.
+Available parameter
+.I "sata_opal".
+
+
 .SH FILES
 
 .SS {CONFFILE}
@@ -744,6 +755,8 @@ SYSFS uuid=bead5eb6:31c17a27:da120ba2:7dfda40d group_thread_cnt=4
 sync_speed_max=1000000
 .br
 MONITORDELAY 60
+.br
+ENCRYPTION_NO_VERIFY sata_opal
 
 .SH SEE ALSO
 .BR mdadm (8),
diff --git a/mdadm.h b/mdadm.h
index f64bb783..9d98693b 100644
--- a/mdadm.h
+++ b/mdadm.h
@@ -1673,6 +1673,7 @@ extern char *conf_get_program(void);
 extern char *conf_get_homehost(int *require_homehostp);
 extern char *conf_get_homecluster(void);
 extern int conf_get_monitor_delay(void);
+extern bool conf_get_sata_opal_encryption_no_verify(void);
 extern char *conf_line(FILE *file);
 extern char *conf_word(FILE *file, int allow_key);
 extern void print_quoted(char *str);
-- 
2.35.3



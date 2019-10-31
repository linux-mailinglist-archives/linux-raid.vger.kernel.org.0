Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9E0EA9D5
	for <lists+linux-raid@lfdr.de>; Thu, 31 Oct 2019 05:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfJaEPr (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 31 Oct 2019 00:15:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:35146 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725816AbfJaEPr (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 31 Oct 2019 00:15:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C0788B446;
        Thu, 31 Oct 2019 04:15:44 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Jes Sorensen <jes.sorensen@gmail.com>
Date:   Thu, 31 Oct 2019 15:15:38 +1100
Cc:     linux-raid@vger.kernel.org,
        Mariusz Dabrowski <mariusz.dabrowski@intel.com>
Subject: [PATCH mdadm] super-intel: don't mark structs 'packed' unnecessarily
In-Reply-To: <87h83peh6h.fsf@notabene.neil.brown.name>
References: <87k18leqf2.fsf@notabene.neil.brown.name> <1f57b1a1-70bd-15a4-4693-1b72aa5546f1@gmail.com> <87h83peh6h.fsf@notabene.neil.brown.name>
Message-ID: <87eeyteej9.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


super-intel marks a number of structures 'packed', but this
doesn't change the layout - they are already well organized.

This is a problem a gcc warns when code takes the address
of a field in a packet struct - as super-intel sometimes does.

So remove the marking where isn't needed.
Do ensure this does introduce a regression, add a compile-time
assertion that the size of the structure is exactly the value
it had before the 'packed' notation was removed.

Note that a couple of structure do need to be packed.
As the address of fields is never taken, that is safe.

Signed-off-by: NeilBrown <neilb@suse.de>
=2D--
 super-intel.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/super-intel.c b/super-intel.c
index e02bbd7a7d42..33f6dc0fdcd5 100644
=2D-- a/super-intel.c
+++ b/super-intel.c
@@ -96,6 +96,19 @@
 						   * mutliple PPL area
 						   */
=20
+/*
+ * This macro let's us ensure that no-one accidentally
+ * changes the size of a struct
+ */
+#define ASSERT_SIZE(_struct, size) \
+static inline void __assert_size_##_struct(void)	\
+{							\
+	switch (0) {					\
+	case 0: break;					\
+	case (sizeof(struct _struct) =3D=3D size): break;	\
+	}						\
+}
+
 /* Disk configuration info. */
 #define IMSM_MAX_DEVICES 255
 struct imsm_disk {
@@ -112,6 +125,7 @@ struct imsm_disk {
 #define	IMSM_DISK_FILLERS	3
 	__u32 filler[IMSM_DISK_FILLERS]; /* 0xF5 - 0x107 MPB_DISK_FILLERS for fut=
ure expansion */
 };
+ASSERT_SIZE(imsm_disk, 48)
=20
 /* map selector for map managment
  */
@@ -146,7 +160,8 @@ struct imsm_map {
 	__u32 disk_ord_tbl[1];	/* disk_ord_tbl[num_members],
 				 * top byte contains some flags
 				 */
=2D} __attribute__ ((packed));
+};
+ASSERT_SIZE(imsm_map, 52)
=20
 struct imsm_vol {
 	__u32 curr_migr_unit;
@@ -169,7 +184,8 @@ struct imsm_vol {
 	__u32 filler[4];
 	struct imsm_map map[1];
 	/* here comes another one if migr_state */
=2D} __attribute__ ((packed));
+};
+ASSERT_SIZE(imsm_vol, 84)
=20
 struct imsm_dev {
 	__u8  volume[MAX_RAID_SERIAL_LEN];
@@ -220,7 +236,8 @@ struct imsm_dev {
 #define IMSM_DEV_FILLERS 3
 	__u32 filler[IMSM_DEV_FILLERS];
 	struct imsm_vol vol;
=2D} __attribute__ ((packed));
+};
+ASSERT_SIZE(imsm_dev, 164)
=20
 struct imsm_super {
 	__u8 sig[MAX_SIGNATURE_LENGTH];	/* 0x00 - 0x1F */
@@ -248,7 +265,8 @@ struct imsm_super {
 	struct imsm_disk disk[1];	/* 0xD8 diskTbl[numDisks] */
 	/* here comes imsm_dev[num_raid_devs] */
 	/* here comes BBM logs */
=2D} __attribute__ ((packed));
+};
+ASSERT_SIZE(imsm_super, 264)
=20
 #define BBM_LOG_MAX_ENTRIES 254
 #define BBM_LOG_MAX_LBA_ENTRY_VAL 256		/* Represents 256 LBAs */
@@ -269,7 +287,8 @@ struct bbm_log {
 	__u32 signature; /* 0xABADB10C */
 	__u32 entry_count;
 	struct bbm_log_entry marked_block_entries[BBM_LOG_MAX_ENTRIES];
=2D} __attribute__ ((__packed__));
+};
+ASSERT_SIZE(bbm_log, 2040)
=20
 static char *map_state_str[] =3D { "normal", "uninitialized", "degraded", =
"failed" };
=20
@@ -323,7 +342,8 @@ struct migr_record {
 				       * destination - high order 32 bits */
 	__u32 num_migr_units_hi;      /* Total num migration units-of-op
 				       * high order 32 bits */
=2D} __attribute__ ((__packed__));
+};
+ASSERT_SIZE(migr_record, 64)
=20
 struct md_list {
 	/* usage marker:
=2D-=20
2.23.0


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl26X+oACgkQOeye3VZi
gbmOhxAAmSKZMyhpYEjcYINArmWNa5/xYVho3f7ePIg1uycv1zrsRfCPg3GAg/dZ
jgHvTRgacZenuy02dvtW6BarRDJcm03Bpk73NFSHYkCMzBcXEH4cHZJhtPmJa5m7
Ml0pqODM14SjufPnp3GMhMrJRUza3XUZx94M76HBQunKveUI4wMXfT2/vHcPUxqi
baEUsAPpix99x7Trc5T/Y4HKlz8jF1bRo0GsLrIanerNF+A6oSXbzsACeYaB4KEA
2YXwdU4dqWRoQr3JLBV9W0GsnYKI57ODwTOJF3LrEdxYlqT0RzWnzMfuS7rak6XD
3CxwC9TrP0UxnwuKGp/qpqZMDQEosZ4F2zjDXGMm6cThua/n0WNto+NcypbdQ8HX
1jBLnsN88RAo9Go2bSN7Zqq07Yb92P0j+oXPz6KLEzeEyBPzrQXBJrR+XmdkvejR
l2lZYHHHjIahNR8oRqYq1ZnxR1f0NAbW3J+AZ/fY7qYih3VCBnUasrUq4paisZ4n
+gixRTO+kd4GFmB/0lOv9H7wTpvorj/CoS8ev9SZGDLkFAD8nt+qUd79OyAnGPln
WY2lOJpsldnprlZh+PX3tgk6Y6utQiXsc6QAD8p37nF/6VpqXqN1BNXtj/j/nrpB
9gDyJiKcsP1o1Q0kWaVc7W5WsAsieh8rapXjvDZLdVm8KAMEkRg=
=UDNF
-----END PGP SIGNATURE-----
--=-=-=--

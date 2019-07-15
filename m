Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA92568356
	for <lists+linux-raid@lfdr.de>; Mon, 15 Jul 2019 07:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbfGOFss (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 15 Jul 2019 01:48:48 -0400
Received: from santino-notr.mail.tiscali.it ([213.205.33.215]:41532 "EHLO
        smtp.tiscali.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725787AbfGOFss (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 15 Jul 2019 01:48:48 -0400
Received: from [192.168.2.137] ([217.27.115.45])
        by santino.mail.tiscali.it with 
        id ctoj2001L0yqAhV01tokeA; Mon, 15 Jul 2019 05:48:45 +0000
x-auth-user: farmatito@tiscali.it
Subject: Re: Weird behaviour of md, maybe a bug in 4.19.xx kernel? [SOLVED]
To:     Sarah Newman <srn@prgmr.com>, linux-raid@vger.kernel.org
Cc:     Wols Lists <antlists@youngman.org.uk>
References: <f9138853-587b-3725-b375-d9a4c2530054@tiscali.it>
 <5D2B3FF9.8000806@youngman.org.uk>
 <4f572716-abd7-5a4e-709c-285a330a92c4@tiscali.it>
 <5da074ee-a0e5-18ac-84ad-6311ff95f0ba@prgmr.com>
From:   Tito <farmatito@tiscali.it>
Message-ID: <30d89071-bf51-10f0-eb24-dd4728c708d1@tiscali.it>
Date:   Mon, 15 Jul 2019 07:48:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5da074ee-a0e5-18ac-84ad-6311ff95f0ba@prgmr.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
        t=1563169725; bh=vOou7Po3rt6I7PATpR5XCCqmK2+62YeiYsGTKHW5oTo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=3Mw/J1n7tdS+DrZUCyfvhrpGwoijtks3YguR02/N5D1G7PUwTtzPXCIeTfEKGGjtx
         cswr63CBoRvar39S9APhgHLYAPIf+4tGj18s9/zvfXeGKm3xvrxV873o++wp9ij7HE
         Kck8YT3vwSE3lVADhd2nRRWuuOyR2jsdtJ5nVbjo=
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



On 7/14/19 7:43 PM, Sarah Newman wrote:
> On 7/14/19 10:05 AM, Tito wrote:
>> On 7/14/19 4:45 PM, Wols Lists wrote:
>>> On 14/07/19 15:05, Tito wrote:
>>>> Hi,
>>>> I've got this email address from the MAINTAINERS file in the linux kernel
>>>> source, so I hope it is the right place to contact.
>>>> I'm running a debian/devuan system for a long time with several
>>>> md arrays on the embedded controller and on a ibm M1015 card
>>>> reflashed to LSI  SAS9211-8i with all drives in passthrough mode.
>>>> My typical setup is:
>>>
>>> You've got the right place. I can't see any mention of what disks you
>>> have, because that could well be relevant.
>>>
>>> Can I point you at the raid wiki for a good read ... :-)
>>>
>>> https://raid.wiki.kernel.org/index.php/Linux_Raid
>>>
>>> It contains a bunch of advice on troubleshooting and stuff, and it'll
>>> hopefully help you identify anything weird so making it easier for you
>>> to point us in the right direction and provide us with the stuff we need.
>>>
>>> Cheers,
>>> Wol
>>>
>>
>> Hi,
>> thanks for your advice, read the wiki and gathered all info as requested,
>> hope that attaching them is ok, or do you prefer them in the body.
> 
> 
> On 7/14/19 10:05 AM, Tito wrote:> On 7/14/19 4:45 PM, Wols Lists wrote:
>  >> On 14/07/19 15:05, Tito wrote:
>  >>> Hi,
>  >>> I've got this email address from the MAINTAINERS file in the linux kernel
>  >>> source, so I hope it is the right place to contact.
>  >>> I'm running a debian/devuan system for a long time with several
>  >>> md arrays on the embedded controller and on a ibm M1015 card
>  >>> reflashed to LSI  SAS9211-8i with all drives in passthrough mode.
>  >>> My typical setup is:
>  >>
>  >> You've got the right place. I can't see any mention of what disks you
>  >> have, because that could well be relevant.
>  >>
>  >> Can I point you at the raid wiki for a good read ... :-)
>  >>
>  >> https://raid.wiki.kernel.org/index.php/Linux_Raid
>  >>
>  >> It contains a bunch of advice on troubleshooting and stuff, and it'll
>  >> hopefully help you identify anything weird so making it easier for you
>  >> to point us in the right direction and provide us with the stuff we need.
>  >>
>  >> Cheers,
>  >> Wol
>  >>
>  >
>  > Hi,
>  > thanks for your advice, read the wiki and gathered all info as requested,
>  > hope that attaching them is ok, or do you prefer them in the body.
> 
> To me this looks like your problem:
> 
>  > Jul 14 07:54:12 debian kernel: [38809.927619] sd 2:0:6:0: [sdg] tag#580 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
>  > Jul 14 07:54:12 debian kernel: [38809.927624] sd 2:0:6:0: [sdg] tag#580 Sense Key : Not Ready [current]
>  > Jul 14 07:54:12 debian kernel: [38809.927627] sd 2:0:6:0: [sdg] tag#580 Add. Sense: Logical unit not ready, cause not reportable
>  > Jul 14 07:54:12 debian kernel: [38809.927632] sd 2:0:6:0: [sdg] tag#580 CDB: Synchronize Cache(10) 35 00 00 00 00 00 00 00 00 00
> 
> FYI there's no overlap between the drives in the raid1 (sda, sdk, sdj) and the drives in the raid5 and raid6.
> 
> According to lsdrv sda, sdk, sdj, and sdl are all on the on-board SATA controller. If you've never seen an error on sdl despite it being in the raid6 then I'd pin the blame on the SAS2008 card. You should probably start by checking the firmware version and making sure it's up to date. If it is up to date then try looking for bugs and updates related to the mpt3sas driver.
> 
> --Sarah
> 

Hi,
you were right it's the mpt3sas driver, as soon as I revert the last commit for 4.19.xx
everything starts working fine again. I can't say why it triggers this bad behavior in
my system. Will contact the maintainer to see if it can be fixed or reverted.

Thanks to all for your help.
Ttio

 From 2c8c8ef8d3b433a6cf1207c4be2058c973ba9b05 Mon Sep 17 00:00:00 2001
From: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Date: Mon, 4 Mar 2019 07:26:35 -0500
Subject: scsi: mpt3sas: Fix kernel panic during expander reset

[ Upstream commit c2fe742ff6e77c5b4fe4ad273191ddf28fdea25e ]

During expander reset handling, the driver invokes kernel function
scsi_host_find_tag() to obtain outstanding requests associated with the
scsi host managed by the driver. Driver loops from tag value zero to hba
queue depth to obtain the outstanding scmds. But when blk-mq is enabled,
the block layer may return stale entry for one or more requests. This may
lead to kernel panic if the returned value is inaccessible or the memory
pointed by the returned value is reused.

Reference of upstream discussion:

	https://patchwork.kernel.org/patch/10734933/

Instead of calling scsi_host_find_tag() API for each and every smid (smid
is tag +1) from one to shost->can_queue, now driver will call this API (to
obtain the outstanding scmd) only for those smid's which are outstanding at
the driver level.

Driver will determine whether this smid is outstanding at driver level by
looking into it's corresponding MPI request frame, if its MPI request frame
is empty, then it means that this smid is free and does not need to call
scsi_host_find_tag() for it.  By doing this, driver will invoke
scsi_host_find_tag() for only those tags which are outstanding at the
driver level.

Driver will check whether particular MPI request frame is empty or not by
looking into the "DevHandle" field. If this field is zero then it means
that this MPI request is empty. For active MPI request DevHandle must be
non-zero.

Also driver will memset the MPI request frame once the corresponding scmd
is processed (i.e. just before calling
scmd->done function).

Signed-off-by: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
  drivers/scsi/mpt3sas/mpt3sas_base.c  |  6 ++++++
  drivers/scsi/mpt3sas/mpt3sas_scsih.c | 12 ++++++++++++
  2 files changed, 18 insertions(+)

(limited to 'drivers/scsi/mpt3sas')

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index b59bba3e6516..8776330175e3 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -3280,12 +3280,18 @@ mpt3sas_base_free_smid(struct MPT3SAS_ADAPTER *ioc, u16 smid)
  
  	if (smid < ioc->hi_priority_smid) {
  		struct scsiio_tracker *st;
+		void *request;
  
  		st = _get_st_from_smid(ioc, smid);
  		if (!st) {
  			_base_recovery_check(ioc);
  			return;
  		}
+
+		/* Clear MPI request frame */
+		request = mpt3sas_base_get_msg_frame(ioc, smid);
+		memset(request, 0, ioc->request_sz);
+
  		mpt3sas_base_clear_st(ioc, st);
  		_base_recovery_check(ioc);
  		return;
diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index 622832e55211..73d661a0ecbb 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -1474,11 +1474,23 @@ mpt3sas_scsih_scsi_lookup_get(struct MPT3SAS_ADAPTER *ioc, u16 smid)
  {
  	struct scsi_cmnd *scmd = NULL;
  	struct scsiio_tracker *st;
+	Mpi25SCSIIORequest_t *mpi_request;
  
  	if (smid > 0  &&
  	    smid <= ioc->scsiio_depth - INTERNAL_SCSIIO_CMDS_COUNT) {
  		u32 unique_tag = smid - 1;
  
+		mpi_request = mpt3sas_base_get_msg_frame(ioc, smid);
+
+		/*
+		 * If SCSI IO request is outstanding at driver level then
+		 * DevHandle filed must be non-zero. If DevHandle is zero
+		 * then it means that this smid is free at driver level,
+		 * so return NULL.
+		 */
+		if (!mpi_request->DevHandle)
+			return scmd;
+
  		scmd = scsi_host_find_tag(ioc->shost, unique_tag);
  		if (scmd) {
  			st = scsi_cmd_priv(scmd);
-- 
cgit 1.2-0.3.lf.el7



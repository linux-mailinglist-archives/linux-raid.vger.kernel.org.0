Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 965131A9C6
	for <lists+linux-raid@lfdr.de>; Sun, 12 May 2019 01:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfEKXWp (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 11 May 2019 19:22:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36618 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbfEKXWp (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Sat, 11 May 2019 19:22:45 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3398C308213B;
        Sat, 11 May 2019 23:22:44 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 298F51001E98;
        Sat, 11 May 2019 23:22:44 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 15A6318089C8;
        Sat, 11 May 2019 23:22:44 +0000 (UTC)
Date:   Sat, 11 May 2019 19:22:43 -0400 (EDT)
From:   Xiao Ni <xni@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>, heinzm@redhat.com,
        ncroxon@redhat.com
Message-ID: <1335759276.28125619.1557616963768.JavaMail.zimbra@redhat.com>
In-Reply-To: <8404E824-E38D-4B78-8AF6-FDA1F3E534FF@fb.com>
References: <1557474339-18962-1-git-send-email-xni@redhat.com> <FF9BB066-7ED5-4066-B202-D64CFA065ABC@fb.com> <1021110953.28040133.1557533155006.JavaMail.zimbra@redhat.com> <8404E824-E38D-4B78-8AF6-FDA1F3E534FF@fb.com>
Subject: Re: [PATCH 1/1] raid5-cache: rename r5l_flush_stripe_to_raid to
 r5l_flush_stripe_to_journal
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.68.5.41, 10.4.195.13]
Thread-Topic: [PATCH 1/1] raid5-cache: rename r5l_flush_stripe_to_raid to
 r5l_flush_stripe_to_journal
Thread-Index: AQHVBwRjvd/SXYsqzE21nQqCcjj/RqZkjpeABNkMKcr/2hNcAL0+7R5k
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Sat, 11 May 2019 23:22:44 +0000 (UTC)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



----- Original Message -----
> From: "Song Liu" <songliubraving@fb.com>
> To: "Xiao Ni" <xni@redhat.com>
> Cc: "linux-raid" <linux-raid@vger.kernel.org>, heinzm@redhat.com, ncroxon@redhat.com
> Sent: Saturday, May 11, 2019 1:41:50 PM
> Subject: Re: [PATCH 1/1] raid5-cache: rename r5l_flush_stripe_to_raid to r5l_flush_stripe_to_journal
> 
> 
> 
> > On May 10, 2019, at 5:05 PM, Xiao Ni <xni@redhat.com> wrote:
> > 
> > 
> > 
> > ----- Original Message -----
> >> From: "Song Liu" <songliubraving@fb.com>
> >> To: "Xiao Ni" <xni@redhat.com>
> >> Cc: "linux-raid" <linux-raid@vger.kernel.org>, heinzm@redhat.com,
> >> ncroxon@redhat.com
> >> Sent: Saturday, May 11, 2019 12:35:02 AM
> >> Subject: Re: [PATCH 1/1] raid5-cache: rename r5l_flush_stripe_to_raid to
> >> r5l_flush_stripe_to_journal
> >> 
> >> 
> >> 
> >>> On May 10, 2019, at 12:45 AM, Xiao Ni <xni@redhat.com> wrote:
> >>> 
> >>> When journal device supports volatile write cache, it needs to flush to
> >>> make sure data is settled
> >>> down in journal device. It's the usage of function
> >>> r5l_flush_stripe_to_raid. The data is flushed
> >>> from stripe cache to journal device. Rename the function name to make it
> >>> more proper.
> >> 
> >> I think current name is more accurate. It is actually the beginning of
> >> writing data to raid
> >> disks. While it does flush the journal device, it also calls
> >> r5l_log_flush_endio(), which
> >> kicks off the write to raid disks.
> >> 
> >> Does this make sense?
> > 
> > The write bio writes to journal device first. In the callback r5l_log_endio
> > it
> > checks whether it needs to flush the data to journal device. If it needs to
> > flush,
> > it calls r5l_move_to_end_ios which moves io_units to log->io_end_ios. Then
> > r5l_flush_stripe_to_raid submit the flush bio. If it doesn't need to flush,
> > it
> > calls r5l_log_run_stripes->r5l_io_run_stripes to kick off write to raid
> > disks.
> > In fact r5l_io_run_stripes is the function which kicks off write to raid
> > disks.
> > 
> > So there are two steps here. One is write data to journal device. It needs
> > to flush
> > data to journal device in this step. Two is write data to raid disks by
> > state machine.
> > I still think it's better to change the name to r5l_flush_stripe_to_journal
> > to describe
> > the thing what it does in this function directly. Even though it calls
> > handle_stripe
> > in the callback function.
> > 
> > At first reading of this function, I searched where are the bios that are
> > submitted to
> > the raid disks. Then I found it calls handle_stripe in the callback
> > function. It's a little
> > confusing. It's the reason I want to rename it. But it depends what people
> > understand.
> > So it's ok for me if we use r5l_flush_stripe_to_raid :)
> 
> This function is called to finish processing pending stripes (at the end of
> raid5d,
> and raid5worker). So the goal is to flush all data to raid disks. If we
> change it
> to flush journal, it will be confusing from the caller side: why only flush
> journal?
> shouldn't we flush raid disks as well?

It makes sense. Thanks for the explanation.

Regards
Xiao
> 
> Let's keep it as-is for now.
> 
> Thanks,
> Song
> 
> > 
> > Regards
> > Xiao
> > 
> >> 
> >> Thanks,
> >> Song
> >> 
> >>> 
> >>> Signed-off-by: Xiao Ni <xni@redhat.com>
> >>> ---
> >>> drivers/md/raid5-cache.c | 2 +-
> >>> drivers/md/raid5.c       | 6 +++---
> >>> 2 files changed, 4 insertions(+), 4 deletions(-)
> >>> 
> >>> diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
> >>> index cbbe6b6..689a59e 100644
> >>> --- a/drivers/md/raid5-cache.c
> >>> +++ b/drivers/md/raid5-cache.c
> >>> @@ -1294,7 +1294,7 @@ static void r5l_log_flush_endio(struct bio *bio)
> >>> * only write stripes of an io_unit to raid disks till the io_unit is the
> >>> first
> >>> * one whose data/parity is in log.
> >>> */
> >>> -void r5l_flush_stripe_to_raid(struct r5l_log *log)
> >>> +void r5l_flush_stripe_to_journal(struct r5l_log *log)
> >>> {
> >>> 	bool do_flush;
> >>> 
> >>> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> >>> index 7fde645..56d9e6e 100644
> >>> --- a/drivers/md/raid5.c
> >>> +++ b/drivers/md/raid5.c
> >>> @@ -6206,7 +6206,7 @@ static int handle_active_stripes(struct r5conf
> >>> *conf,
> >>> int group,
> >>> 	release_inactive_stripe_list(conf, temp_inactive_list,
> >>> 				     NR_STRIPE_HASH_LOCKS);
> >>> 
> >>> -	r5l_flush_stripe_to_raid(conf->log);
> >>> +	r5l_flush_stripe_to_journal(conf->log);
> >>> 	if (release_inactive) {
> >>> 		spin_lock_irq(&conf->device_lock);
> >>> 		return 0;
> >>> @@ -6262,7 +6262,7 @@ static void raid5_do_work(struct work_struct *work)
> >>> 
> >>> 	flush_deferred_bios(conf);
> >>> 
> >>> -	r5l_flush_stripe_to_raid(conf->log);
> >>> +	r5l_flush_stripe_to_journal(conf->log);
> >>> 
> >>> 	async_tx_issue_pending_all();
> >>> 	blk_finish_plug(&plug);
> >>> @@ -6349,7 +6349,7 @@ static void raid5d(struct md_thread *thread)
> >>> 
> >>> 	flush_deferred_bios(conf);
> >>> 
> >>> -	r5l_flush_stripe_to_raid(conf->log);
> >>> +	r5l_flush_stripe_to_journal(conf->log);
> >>> 
> >>> 	async_tx_issue_pending_all();
> >>> 	blk_finish_plug(&plug);
> >>> --
> >>> 2.7.5
> >>> 
> >> 
> >> 
> 
> 

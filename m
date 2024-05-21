Return-Path: <linux-raid+bounces-1509-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4EAB8CA72C
	for <lists+linux-raid@lfdr.de>; Tue, 21 May 2024 05:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B64391C21325
	for <lists+linux-raid@lfdr.de>; Tue, 21 May 2024 03:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C164225D4;
	Tue, 21 May 2024 03:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=damenly.org header.i=@damenly.org header.b="wbV+ZaZB"
X-Original-To: linux-raid@vger.kernel.org
Received: from mail-108-mta42.mxroute.com (mail-108-mta42.mxroute.com [136.175.108.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2231B1BF31
	for <linux-raid@vger.kernel.org>; Tue, 21 May 2024 03:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716263990; cv=none; b=fp/MqeYpCGY+Gj4ANHbm3HQtAAzHz6MasnmA0icYyDnS05gAn5i8k4jA0QwXctrgu4vh9XN64ljGFAgnpV6DxV7HeaCsuAqexWc7oVgUkoFBo2dpJX//bM7G2FmguprckcJ6CY6kxLYobBrIZzpLXYgFgARxXjW+4pJui3Ws+XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716263990; c=relaxed/simple;
	bh=kYIKHYmpfxlDrhJ93GDwspPDhBxwB6XwqWN/aBb/pHg=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=DBhetG9Z0WJUPo0Bv1qKmz1ou1GDhbSr3dmDBq7TCuslajXfRpB1bgzOdXnyPFoNh2vdLRIYeVy9m3S2atQ4PnLr4z3A1lNLZWKXhUH1dsWKcFOlDd9ehx1u668qnESTSuNSLs7MJCZk6oB6kEg7xSWx8TJ6jMTGb1eNbXVBuWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=damenly.org; spf=pass smtp.mailfrom=damenly.org; dkim=pass (2048-bit key) header.d=damenly.org header.i=@damenly.org header.b=wbV+ZaZB; arc=none smtp.client-ip=136.175.108.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=damenly.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=damenly.org
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta42.mxroute.com (ZoneMTA) with ESMTPSA id 18f99496bb9000efce.00c
 for <linux-raid@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Tue, 21 May 2024 03:54:36 +0000
X-Zone-Loop: 2d4705f7cfb3a537a8c6ae436f4a4feaab9abee82fe0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=damenly.org
	; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	In-reply-to:Date:Subject:Cc:To:From:References:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=DPtLHpKIAy/sjrt9Mpwp5EnxqKTtyHFZBeLVILI3AVc=; b=wbV+ZaZB6yxToKDmVhy5+7W38E
	Ppd+wkmExCJpOCDd31JxfDvq8IiLoLoXiEpn14JCfSmg8akvKXMtd1tn8sEGFQBlmOoqYjzxFRhrN
	1amjV4tK4u+ZOAkbuFZFhoKjksU9vSzAleg4aNAfRmCwmvD6XxsFK3arqj+OmqRuprzCbGPpxocWP
	efoNcVSGt9NjcWepT2KrDOZ0iIQOQQ12OEmNgESfWzCBszhDK1FFImJ9MVvVh5kaNWS/LTQDgjAxU
	XgEQ8XpT8jTIZE03WAMdy6GWU17k3qfIWTx6GwMjWwKUKqxwD7LD34goMR6eWXPTb+pJWjHKdUDsb
	4/QrCszA==;
References: <20240509011900.2694291-1-yukuai1@huaweicloud.com>
 <20240509011900.2694291-4-yukuai1@huaweicloud.com>
 <v838ekaa.fsf@damenly.org>
 <CALTww28PVgS3D+9JsNv4PvDLAi=hOyT14QMkk5245_a8JXvgNQ@mail.gmail.com>
User-agent: mu4e 1.7.5; emacs 28.2
From: Su Yue <l@damenly.org>
To: Xiao Ni <xni@redhat.com>
Cc: Su Yue <l@damenly.org>, Yu Kuai <yukuai1@huaweicloud.com>,
 agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com, song@kernel.org,
 dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-raid@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com,
 yangerkun@huawei.com
Subject: Re: [PATCH md-6.10 3/9] md: add new helpers for sync_action
Date: Tue, 21 May 2024 11:50:53 +0800
In-reply-to: <CALTww28PVgS3D+9JsNv4PvDLAi=hOyT14QMkk5245_a8JXvgNQ@mail.gmail.com>
Message-ID: <r0dves7n.fsf@damenly.org>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Authenticated-Id: l@damenly.org


On Tue 21 May 2024 at 11:25, Xiao Ni <xni@redhat.com> wrote:

> On Mon, May 20, 2024 at 8:38=E2=80=AFPM Su Yue <l@damenly.org> wrote:
>>
>>
>> On Thu 09 May 2024 at 09:18, Yu Kuai <yukuai1@huaweicloud.com>
>> wrote:
>>
>> > From: Yu Kuai <yukuai3@huawei.com>
>> >
>> > The new helpers will get current sync_action of the array,=20
>> > will
>> > be used
>> > in later patches to make code cleaner.
>> >
>> > Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> > ---
>> >  drivers/md/md.c | 64
>> >  +++++++++++++++++++++++++++++++++++++++++++++++++
>> >  drivers/md/md.h |  3 +++
>> >  2 files changed, 67 insertions(+)
>> >
>> > diff --git a/drivers/md/md.c b/drivers/md/md.c
>> > index 00bbafcd27bb..48ec35342d1b 100644
>> > --- a/drivers/md/md.c
>> > +++ b/drivers/md/md.c
>> > @@ -69,6 +69,16 @@
>> >  #include "md-bitmap.h"
>> >  #include "md-cluster.h"
>> >
>> > +static char *action_name[NR_SYNC_ACTIONS] =3D {
>> >
>>
>> Th array will not be modified, so:
>>
>> static const char * const action_names[NR_SYNC_ACTIONS]
>>
>> > +     [ACTION_RESYNC]         =3D "resync",
>> > +     [ACTION_RECOVER]        =3D "recover",
>> > +     [ACTION_CHECK]          =3D "check",
>> > +     [ACTION_REPAIR]         =3D "repair",
>> > +     [ACTION_RESHAPE]        =3D "reshape",
>> > +     [ACTION_FROZEN]         =3D "frozen",
>> > +     [ACTION_IDLE]           =3D "idle",
>> > +};
>> > +
>> >  /* pers_list is a list of registered personalities protected=20
>> >  by
>> >  pers_lock. */
>> >  static LIST_HEAD(pers_list);
>> >  static DEFINE_SPINLOCK(pers_lock);
>> > @@ -4867,6 +4877,60 @@ metadata_store(struct mddev *mddev,=20
>> > const
>> > char *buf, size_t len)
>> >  static struct md_sysfs_entry md_metadata =3D
>> >  __ATTR_PREALLOC(metadata_version, S_IRUGO|S_IWUSR,
>> >  metadata_show, metadata_store);
>> >
>> > +enum sync_action md_sync_action(struct mddev *mddev)
>> > +{
>> > +     unsigned long recovery =3D mddev->recovery;
>> > +
>> > +     /*
>> > +      * frozen has the highest priority, means running=20
>> > sync_thread
>> > will be
>> > +      * stopped immediately, and no new sync_thread can=20
>> > start.
>> > +      */
>> > +     if (test_bit(MD_RECOVERY_FROZEN, &recovery))
>> > +             return ACTION_FROZEN;
>> > +
>> > +     /*
>> > +      * idle means no sync_thread is running, and no new
>> > sync_thread is
>> > +      * requested.
>> > +      */
>> > +     if (!test_bit(MD_RECOVERY_RUNNING, &recovery) &&
>> > +         (!md_is_rdwr(mddev) ||=20
>> > !test_bit(MD_RECOVERY_NEEDED,
>> > &recovery)))
>> > +             return ACTION_IDLE;
>> My brain was lost sometimes looking into nested conditions of=20
>> md
>> code...
>
> agree+
>
>> I agree with Xiao Ni's suggestion that more comments about the
>> array
>> state should be added.
>
> In fact, I suggest to keep the logic which is in action_show=20
> now. The
> logic in action_show is easier to understand for me.
>

I'm in the middle, either of new/old logic looks good to me ;)
Thanks for clarifying.

--
Su
> Best Regards
> Xiao
>>
>> > +     if (test_bit(MD_RECOVERY_RESHAPE, &recovery) ||
>> > +         mddev->reshape_position !=3D MaxSector)
>> > +             return ACTION_RESHAPE;
>> > +
>> > +     if (test_bit(MD_RECOVERY_RECOVER, &recovery))
>> > +             return ACTION_RECOVER;
>> > +
>> >
>> In action_show, MD_RECOVERY_SYNC is tested first then
>> MD_RECOVERY_RECOVER.
>> After looking through the logic of MD_RECOVERY_RECOVER
>> clear/set_bit, the
>> change is fine to me. However, better to follow old pattern=20
>> unless
>> there
>> have resons.
>>
>>
>> > +     if (test_bit(MD_RECOVERY_SYNC, &recovery)) {
>> > +             if (test_bit(MD_RECOVERY_CHECK, &recovery))
>> > +                     return ACTION_CHECK;
>> > +             if (test_bit(MD_RECOVERY_REQUESTED, &recovery))
>> > +                     return ACTION_REPAIR;
>> > +             return ACTION_RESYNC;
>> > +     }
>> > +
>> > +     return ACTION_IDLE;
>> > +}
>> > +
>> > +enum sync_action md_sync_action_by_name(char *page)
>> > +{
>> > +     enum sync_action action;
>> > +
>> > +     for (action =3D 0; action < NR_SYNC_ACTIONS; ++action) {
>> > +             if (cmd_match(page, action_name[action]))
>> > +                     return action;
>> > +     }
>> > +
>> > +     return NR_SYNC_ACTIONS;
>> > +}
>> > +
>> > +char *md_sync_action_name(enum sync_action action)
>> >
>>
>> And 'const char *'
>>
>> --
>> Su
>>
>> > +{
>> > +     return action_name[action];
>> > +}
>> > +
>> >  static ssize_t
>> >  action_show(struct mddev *mddev, char *page)
>> >  {
>> > diff --git a/drivers/md/md.h b/drivers/md/md.h
>> > index 2edad966f90a..72ca7a796df5 100644
>> > --- a/drivers/md/md.h
>> > +++ b/drivers/md/md.h
>> > @@ -864,6 +864,9 @@ extern void md_unregister_thread(struct
>> > mddev *mddev, struct md_thread __rcu **t
>> >  extern void md_wakeup_thread(struct md_thread __rcu=20
>> >  *thread);
>> >  extern void md_check_recovery(struct mddev *mddev);
>> >  extern void md_reap_sync_thread(struct mddev *mddev);
>> > +extern enum sync_action md_sync_action(struct mddev *mddev);
>> > +extern enum sync_action md_sync_action_by_name(char *page);
>> > +extern char *md_sync_action_name(enum sync_action action);
>> >  extern bool md_write_start(struct mddev *mddev, struct bio
>> >  *bi);
>> >  extern void md_write_inc(struct mddev *mddev, struct bio=20
>> >  *bi);
>> >  extern void md_write_end(struct mddev *mddev);
>>


Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00CC3AA814
	for <lists+linux-raid@lfdr.de>; Thu,  5 Sep 2019 18:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731738AbfIEQP3 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 5 Sep 2019 12:15:29 -0400
Received: from smtp1.servermx.com ([134.19.178.79]:41652 "EHLO
        smtp1.servermx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbfIEQP2 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 5 Sep 2019 12:15:28 -0400
X-Greylist: delayed 609 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Sep 2019 12:15:27 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=servermx.com; s=servermx; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=cNpdtcqAyRRArFU8EUe4xpenEpHrvCVHoDqt88BSZAg=; b=lrRuaYUpxJ68AlWnMzmurYyRxb
        k8/awevDqHqoBKJrNihCe7NjIfEX7rVNHaJhutyiJ/qX0j0ZqBmq3A/9iP3tAR6E1yR0aYimIeO2G
        8/F11QisOA9A2wMmNDYPn+le4oykTSEKncWNaMzkfKV8dwnxViG5WTJyQRLsBxC9PacU=;
Received: by exim4; Thu, 05 Sep 2019 18:05:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=servermx.com; s=servermx; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=cNpdtcqAyRRArFU8EUe4xpenEpHrvCVHoDqt88BSZAg=; b=lrRuaYUpxJ68AlWnMzmurYyRxb
        k8/awevDqHqoBKJrNihCe7NjIfEX7rVNHaJhutyiJ/qX0j0ZqBmq3A/9iP3tAR6E1yR0aYimIeO2G
        8/F11QisOA9A2wMmNDYPn+le4oykTSEKncWNaMzkfKV8dwnxViG5WTJyQRLsBxC9PacU=;
Received: by exim4; Thu, 05 Sep 2019 18:05:16 +0200
Received: by cthulhu.home.robinhill.me.uk (Postfix, from userid 1000)
        id 72BA06A74D7; Thu,  5 Sep 2019 17:05:12 +0100 (BST)
Date:   Thu, 5 Sep 2019 17:05:12 +0100
From:   Robin Hill <robin@robinhill.me.uk>
To:     Nigel Croxon <ncroxon@redhat.com>
Cc:     linux-raid@vger.kernel.org
Subject: Re: raid6 with dm-integrity should not cause device to fail
Message-ID: <20190905160512.GA17672@cthulhu.home.robinhill.me.uk>
Mail-Followup-To: Nigel Croxon <ncroxon@redhat.com>,
        linux-raid@vger.kernel.org
References: <9dd94796-4398-55c5-b4b6-4adfa2b88901@redhat.com>
 <fc3391a1-2337-4f9a-1f09-8a0882000084@redhat.com>
 <7429a69e-0b27-53de-2ad8-01d8ebbc2bb4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <7429a69e-0b27-53de-2ad8-01d8ebbc2bb4@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Feedback-ID: outgoingmessage:robin@robinhill.me.uk:ns02.servermx.com:servermx.com
X-AuthUser: bimu5pypsh
X-Mailgun-Native-Send: true
X-AuthUser: bimu5pypsh
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Thu Sep 05, 2019 at 11:29:07AM -0400, Nigel Croxon wrote:

> On 9/5/19 7:35 AM, Nigel Croxon wrote:
> > On 6/20/19 7:31 AM, Nigel Croxon wrote:
> >> Hello All,
> >>
> >> When RAID6 is set up on dm-integrity target that detects massive=20
> >> corruption, the leg will be ejected from the array.=A0 Even if the=20
> >> issue is correctable with a sector re-write and the array has=20
> >> necessary redundancy to correct it.
> >>
> >> The leg is ejected because it runs up the rdev->read_errors beyond=20
> >> conf->max_nr_stripes (600).
> >>
> >> The return status in dm-crypt when there is a data integrity error is=
=20
> >> BLK_STS_PROTECTION.
> >>
> >> I propose we don't increment the read_errors when the bi->bi_status=20
> >> is BLK_STS_PROTECTION.
> >>
> >>
> >> =A0drivers/md/raid5.c | 3 ++-
> >> =A01 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> >> index b83bce2beb66..ca73e60e33ed 100644
> >> --- a/drivers/md/raid5.c
> >> +++ b/drivers/md/raid5.c
> >> @@ -2526,7 +2526,8 @@ static void raid5_end_read_request(struct bio *=
=20
> >> bi)
> >> =A0=A0=A0=A0 =A0=A0=A0 int set_bad =3D 0;
> >>
> >> =A0=A0=A0=A0 =A0=A0=A0 clear_bit(R5_UPTODATE, &sh->dev[i].flags);
> >> -=A0=A0=A0 =A0=A0=A0 atomic_inc(&rdev->read_errors);
> >> +=A0=A0=A0 =A0=A0=A0 if (!(bi->bi_status =3D=3D BLK_STS_PROTECTION))
> >> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 atomic_inc(&rdev->read_errors);
> >> =A0=A0=A0=A0 =A0=A0=A0 if (test_bit(R5_ReadRepl, &sh->dev[i].flags))
> >> =A0=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 pr_warn_ratelimited(
> >> =A0=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 "md/raid:%s: read error on =
replacement device=20
> >> (sector %llu on %s).\n",
> >
> >
> > I'm up against this wall again.=A0 We should continue to count errors=
=20
> > returned by the lower layer,
> >
> > but if those errors are -EILSEQ, instead of -EIO, MD should not mark=20
> > the device as failed.
> >
> >
> https://securitypitfalls.wordpress.com/2018/05/08/raid-doesnt-work/
>=20

I'm not clear what you (or the author of the article) are expecting
here. You've got a disk (or disks) with thousands of read errors -
whether these are dm-integrity mismatches or disk-level read errors
doesn't matter - the disk is toast and needs replacing ASAP (or it's in
an environment where it - and you - probably shouldn't be).

Admittedly, with dm-integrity we can probably trust that anything read
=66rom the disk which makes it past the integrity check is valid, so there
may be cases where the data on there is needed to complete a stripe.
That seems a rather theoretical and contrived circumstance though - in
most cases you're better just kicking the drive from the array so the
admin knows that it needs replacing.

In the more normal case, dm-integrity will return occasional read errors
due to cosmic rays, bitrot, or whatever else, and md will rewrite the
blocks with the correct data - everything keeps running and everyone's
happy. And when disks do fail, dm-integrity will give you read errors on
the faulty disk instead of possibly returning the wrong data, so you
don't later end up with data mismatches and have to try and figure out
which drive has caused it.

Cheers,
    Robin

--=20
     ___       =20
    ( ' }     |       Robin Hill        <robin@robinhill.me.uk> |
   / / )      | Little Jim says ....                            |
  // !!       |      "He fallen in de water !!"                 |

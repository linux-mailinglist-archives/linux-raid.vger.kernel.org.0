Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72DF5790AAE
	for <lists+linux-raid@lfdr.de>; Sun,  3 Sep 2023 05:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235644AbjICD2U (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 2 Sep 2023 23:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235657AbjICD2T (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sat, 2 Sep 2023 23:28:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F0E18E
        for <linux-raid@vger.kernel.org>; Sat,  2 Sep 2023 20:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693711648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kcD/0z9hB2h73HPVYeZiLrEggogTqOFbi0Cl5AQfZkg=;
        b=UbEyAm9kV+rvjTAubB+ZcsOiX3MpZohcuaOoz+j+Xiu1jHdjV+zJdOosY9UDlOO/VDXclJ
        IfUEqkSpUSziwTD6IAdXFZGUBFHIZz+pUBrAdpu6bGODGuSnFyEelghkgbYXo5nP2nvGJ7
        wuW3cAWJpDeEC+a7jtlFrsbnAGmN6FE=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-NCNtduDTMJSE3ZXGwwspDA-1; Sat, 02 Sep 2023 23:27:27 -0400
X-MC-Unique: NCNtduDTMJSE3ZXGwwspDA-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-58c8b2d6784so3698797b3.3
        for <linux-raid@vger.kernel.org>; Sat, 02 Sep 2023 20:27:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693711646; x=1694316446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kcD/0z9hB2h73HPVYeZiLrEggogTqOFbi0Cl5AQfZkg=;
        b=Ge94+ht5pRKXfmvdJLpairmZv6ItpZhNzAWYkNoakhMOE1lMZImuspJD4AtIFlhuCg
         u6yxm4X+wJy1iAfjBiFVgsfYHAtasarIHb4pBP/f6guiJfl1OYY8qbM7FKy2b/CSP3zx
         BobJbwbBSOaXAJ1pEf55KPFqLzCh7lXls67axO1VOVBNBB8rAk0gI5dlYLG2lsHEBKxP
         Qasu7Lce9LmZsvchVl6n5P82BDiwp9dVRq1hVELHlyvqhvW9Ike0dLsqwI81Bf9AbzxR
         NN4Rm2VDOHvQwxxxxH8GYmFDA24LvcbImqVF+ui+Aq1S+sOuU1UnJE3QtzYh+bYvPLgh
         zZxQ==
X-Gm-Message-State: AOJu0YzD2zrfXvwPmaAHHSZoq75l3Z6ndNHE/zb2Y9Vuw53oVCrkP2H4
        k1OvQ0iMLppwoOBiNFRdqUJcA+ABJ13Aus8waL0QfCMKLjqxI7FH3+6Jh9bnhtJFQu1stCU6BqM
        NgXtdxf0B2q+hyGJMG5/tN+t4BDv0kbpMGjvSQQ==
X-Received: by 2002:a0d:cb02:0:b0:584:6d71:f465 with SMTP id n2-20020a0dcb02000000b005846d71f465mr7304614ywd.12.1693711646593;
        Sat, 02 Sep 2023 20:27:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHArvZ3NeHmGWXJLEalW06EOpdzUevlNgEsp0gN4EEmwJCLD/xbG+SROwyK7VaGMJSwK20dTHIP9vmR9GUlD4Q=
X-Received: by 2002:a0d:cb02:0:b0:584:6d71:f465 with SMTP id
 n2-20020a0dcb02000000b005846d71f465mr7304601ywd.12.1693711646358; Sat, 02 Sep
 2023 20:27:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230811170513.2300-1-colyli@suse.de> <20230811170513.2300-7-colyli@suse.de>
In-Reply-To: <20230811170513.2300-7-colyli@suse.de>
From:   Xiao Ni <xni@redhat.com>
Date:   Sun, 3 Sep 2023 11:27:11 +0800
Message-ID: <CALTww2_OAcVZ8HpYF-g79neg9nEBqLssQ3k2G1fTX63vfZnA-Q@mail.gmail.com>
Subject: Re: [PATCH v7 6/6] badblocks: switch to the improved badblock
 handling code
To:     Coly Li <colyli@suse.de>
Cc:     linux-raid@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-block@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Geliang Tang <geliang.tang@suse.com>,
        Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        NeilBrown <neilb@suse.de>,
        Vishal L Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Sat, Aug 12, 2023 at 1:07=E2=80=AFAM Coly Li <colyli@suse.de> wrote:
>
> This patch removes old code of badblocks_set(), badblocks_clear() and
> badblocks_check(), and make them as wrappers to call _badblocks_set(),
> _badblocks_clear() and _badblocks_check().
>
> By this change now the badblock handing switch to the improved algorithm
> in  _badblocks_set(), _badblocks_clear() and _badblocks_check().
>
> This patch only contains the changes of old code deletion, new added
> code for the improved algorithms are in previous patches.
>
> Signed-off-by: Coly Li <colyli@suse.de>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Geliang Tang <geliang.tang@suse.com>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: NeilBrown <neilb@suse.de>
> Cc: Vishal L Verma <vishal.l.verma@intel.com>
> Cc: Xiao Ni <xni@redhat.com>
> ---
>  block/badblocks.c | 308 +---------------------------------------------
>  1 file changed, 3 insertions(+), 305 deletions(-)
>
> diff --git a/block/badblocks.c b/block/badblocks.c
> index 3438a2517749..fc92d4e18aa3 100644
> --- a/block/badblocks.c
> +++ b/block/badblocks.c
> @@ -1405,74 +1405,7 @@ static int _badblocks_check(struct badblocks *bb, =
sector_t s, int sectors,
>  int badblocks_check(struct badblocks *bb, sector_t s, int sectors,
>                         sector_t *first_bad, int *bad_sectors)
>  {
> -       int hi;
> -       int lo;
> -       u64 *p =3D bb->page;
> -       int rv;
> -       sector_t target =3D s + sectors;
> -       unsigned seq;
> -
> -       if (bb->shift > 0) {
> -               /* round the start down, and the end up */
> -               s >>=3D bb->shift;
> -               target +=3D (1<<bb->shift) - 1;
> -               target >>=3D bb->shift;
> -       }
> -       /* 'target' is now the first block after the bad range */
> -
> -retry:
> -       seq =3D read_seqbegin(&bb->lock);
> -       lo =3D 0;
> -       rv =3D 0;
> -       hi =3D bb->count;
> -
> -       /* Binary search between lo and hi for 'target'
> -        * i.e. for the last range that starts before 'target'
> -        */
> -       /* INVARIANT: ranges before 'lo' and at-or-after 'hi'
> -        * are known not to be the last range before target.
> -        * VARIANT: hi-lo is the number of possible
> -        * ranges, and decreases until it reaches 1
> -        */
> -       while (hi - lo > 1) {
> -               int mid =3D (lo + hi) / 2;
> -               sector_t a =3D BB_OFFSET(p[mid]);
> -
> -               if (a < target)
> -                       /* This could still be the one, earlier ranges
> -                        * could not.
> -                        */
> -                       lo =3D mid;
> -               else
> -                       /* This and later ranges are definitely out. */
> -                       hi =3D mid;
> -       }
> -       /* 'lo' might be the last that started before target, but 'hi' is=
n't */
> -       if (hi > lo) {
> -               /* need to check all range that end after 's' to see if
> -                * any are unacknowledged.
> -                */
> -               while (lo >=3D 0 &&
> -                      BB_OFFSET(p[lo]) + BB_LEN(p[lo]) > s) {
> -                       if (BB_OFFSET(p[lo]) < target) {
> -                               /* starts before the end, and finishes af=
ter
> -                                * the start, so they must overlap
> -                                */
> -                               if (rv !=3D -1 && BB_ACK(p[lo]))
> -                                       rv =3D 1;
> -                               else
> -                                       rv =3D -1;
> -                               *first_bad =3D BB_OFFSET(p[lo]);
> -                               *bad_sectors =3D BB_LEN(p[lo]);
> -                       }
> -                       lo--;
> -               }
> -       }
> -
> -       if (read_seqretry(&bb->lock, seq))
> -               goto retry;
> -
> -       return rv;
> +       return _badblocks_check(bb, s, sectors, first_bad, bad_sectors);
>  }
>  EXPORT_SYMBOL_GPL(badblocks_check);
>
> @@ -1494,154 +1427,7 @@ EXPORT_SYMBOL_GPL(badblocks_check);
>  int badblocks_set(struct badblocks *bb, sector_t s, int sectors,
>                         int acknowledged)
>  {
> -       u64 *p;
> -       int lo, hi;
> -       int rv =3D 0;
> -       unsigned long flags;
> -
> -       if (bb->shift < 0)
> -               /* badblocks are disabled */
> -               return 1;
> -
> -       if (bb->shift) {
> -               /* round the start down, and the end up */
> -               sector_t next =3D s + sectors;
> -
> -               s >>=3D bb->shift;
> -               next +=3D (1<<bb->shift) - 1;
> -               next >>=3D bb->shift;
> -               sectors =3D next - s;
> -       }
> -
> -       write_seqlock_irqsave(&bb->lock, flags);
> -
> -       p =3D bb->page;
> -       lo =3D 0;
> -       hi =3D bb->count;
> -       /* Find the last range that starts at-or-before 's' */
> -       while (hi - lo > 1) {
> -               int mid =3D (lo + hi) / 2;
> -               sector_t a =3D BB_OFFSET(p[mid]);
> -
> -               if (a <=3D s)
> -                       lo =3D mid;
> -               else
> -                       hi =3D mid;
> -       }
> -       if (hi > lo && BB_OFFSET(p[lo]) > s)
> -               hi =3D lo;
> -
> -       if (hi > lo) {
> -               /* we found a range that might merge with the start
> -                * of our new range
> -                */
> -               sector_t a =3D BB_OFFSET(p[lo]);
> -               sector_t e =3D a + BB_LEN(p[lo]);
> -               int ack =3D BB_ACK(p[lo]);
> -
> -               if (e >=3D s) {
> -                       /* Yes, we can merge with a previous range */
> -                       if (s =3D=3D a && s + sectors >=3D e)
> -                               /* new range covers old */
> -                               ack =3D acknowledged;
> -                       else
> -                               ack =3D ack && acknowledged;
> -
> -                       if (e < s + sectors)
> -                               e =3D s + sectors;
> -                       if (e - a <=3D BB_MAX_LEN) {
> -                               p[lo] =3D BB_MAKE(a, e-a, ack);
> -                               s =3D e;
> -                       } else {
> -                               /* does not all fit in one range,
> -                                * make p[lo] maximal
> -                                */
> -                               if (BB_LEN(p[lo]) !=3D BB_MAX_LEN)
> -                                       p[lo] =3D BB_MAKE(a, BB_MAX_LEN, =
ack);
> -                               s =3D a + BB_MAX_LEN;
> -                       }
> -                       sectors =3D e - s;
> -               }
> -       }
> -       if (sectors && hi < bb->count) {
> -               /* 'hi' points to the first range that starts after 's'.
> -                * Maybe we can merge with the start of that range
> -                */
> -               sector_t a =3D BB_OFFSET(p[hi]);
> -               sector_t e =3D a + BB_LEN(p[hi]);
> -               int ack =3D BB_ACK(p[hi]);
> -
> -               if (a <=3D s + sectors) {
> -                       /* merging is possible */
> -                       if (e <=3D s + sectors) {
> -                               /* full overlap */
> -                               e =3D s + sectors;
> -                               ack =3D acknowledged;
> -                       } else
> -                               ack =3D ack && acknowledged;
> -
> -                       a =3D s;
> -                       if (e - a <=3D BB_MAX_LEN) {
> -                               p[hi] =3D BB_MAKE(a, e-a, ack);
> -                               s =3D e;
> -                       } else {
> -                               p[hi] =3D BB_MAKE(a, BB_MAX_LEN, ack);
> -                               s =3D a + BB_MAX_LEN;
> -                       }
> -                       sectors =3D e - s;
> -                       lo =3D hi;
> -                       hi++;
> -               }
> -       }
> -       if (sectors =3D=3D 0 && hi < bb->count) {
> -               /* we might be able to combine lo and hi */
> -               /* Note: 's' is at the end of 'lo' */
> -               sector_t a =3D BB_OFFSET(p[hi]);
> -               int lolen =3D BB_LEN(p[lo]);
> -               int hilen =3D BB_LEN(p[hi]);
> -               int newlen =3D lolen + hilen - (s - a);
> -
> -               if (s >=3D a && newlen < BB_MAX_LEN) {
> -                       /* yes, we can combine them */
> -                       int ack =3D BB_ACK(p[lo]) && BB_ACK(p[hi]);
> -
> -                       p[lo] =3D BB_MAKE(BB_OFFSET(p[lo]), newlen, ack);
> -                       memmove(p + hi, p + hi + 1,
> -                               (bb->count - hi - 1) * 8);
> -                       bb->count--;
> -               }
> -       }
> -       while (sectors) {
> -               /* didn't merge (it all).
> -                * Need to add a range just before 'hi'
> -                */
> -               if (bb->count >=3D MAX_BADBLOCKS) {
> -                       /* No room for more */
> -                       rv =3D 1;
> -                       break;
> -               } else {
> -                       int this_sectors =3D sectors;
> -
> -                       memmove(p + hi + 1, p + hi,
> -                               (bb->count - hi) * 8);
> -                       bb->count++;
> -
> -                       if (this_sectors > BB_MAX_LEN)
> -                               this_sectors =3D BB_MAX_LEN;
> -                       p[hi] =3D BB_MAKE(s, this_sectors, acknowledged);
> -                       sectors -=3D this_sectors;
> -                       s +=3D this_sectors;
> -               }
> -       }
> -
> -       bb->changed =3D 1;
> -       if (!acknowledged)
> -               bb->unacked_exist =3D 1;
> -       else
> -               badblocks_update_acked(bb);
> -       write_sequnlock_irqrestore(&bb->lock, flags);
> -
> -       return rv;
> +       return _badblocks_set(bb, s, sectors, acknowledged);
>  }
>  EXPORT_SYMBOL_GPL(badblocks_set);
>
> @@ -1661,95 +1447,7 @@ EXPORT_SYMBOL_GPL(badblocks_set);
>   */
>  int badblocks_clear(struct badblocks *bb, sector_t s, int sectors)
>  {
> -       u64 *p;
> -       int lo, hi;
> -       sector_t target =3D s + sectors;
> -       int rv =3D 0;
> -
> -       if (bb->shift > 0) {
> -               /* When clearing we round the start up and the end down.
> -                * This should not matter as the shift should align with
> -                * the block size and no rounding should ever be needed.
> -                * However it is better the think a block is bad when it
> -                * isn't than to think a block is not bad when it is.
> -                */
> -               s +=3D (1<<bb->shift) - 1;
> -               s >>=3D bb->shift;
> -               target >>=3D bb->shift;
> -       }
> -
> -       write_seqlock_irq(&bb->lock);
> -
> -       p =3D bb->page;
> -       lo =3D 0;
> -       hi =3D bb->count;
> -       /* Find the last range that starts before 'target' */
> -       while (hi - lo > 1) {
> -               int mid =3D (lo + hi) / 2;
> -               sector_t a =3D BB_OFFSET(p[mid]);
> -
> -               if (a < target)
> -                       lo =3D mid;
> -               else
> -                       hi =3D mid;
> -       }
> -       if (hi > lo) {
> -               /* p[lo] is the last range that could overlap the
> -                * current range.  Earlier ranges could also overlap,
> -                * but only this one can overlap the end of the range.
> -                */
> -               if ((BB_OFFSET(p[lo]) + BB_LEN(p[lo]) > target) &&
> -                   (BB_OFFSET(p[lo]) < target)) {
> -                       /* Partial overlap, leave the tail of this range =
*/
> -                       int ack =3D BB_ACK(p[lo]);
> -                       sector_t a =3D BB_OFFSET(p[lo]);
> -                       sector_t end =3D a + BB_LEN(p[lo]);
> -
> -                       if (a < s) {
> -                               /* we need to split this range */
> -                               if (bb->count >=3D MAX_BADBLOCKS) {
> -                                       rv =3D -ENOSPC;
> -                                       goto out;
> -                               }
> -                               memmove(p+lo+1, p+lo, (bb->count - lo) * =
8);
> -                               bb->count++;
> -                               p[lo] =3D BB_MAKE(a, s-a, ack);
> -                               lo++;
> -                       }
> -                       p[lo] =3D BB_MAKE(target, end - target, ack);
> -                       /* there is no longer an overlap */
> -                       hi =3D lo;
> -                       lo--;
> -               }
> -               while (lo >=3D 0 &&
> -                      (BB_OFFSET(p[lo]) + BB_LEN(p[lo]) > s) &&
> -                      (BB_OFFSET(p[lo]) < target)) {
> -                       /* This range does overlap */
> -                       if (BB_OFFSET(p[lo]) < s) {
> -                               /* Keep the early parts of this range. */
> -                               int ack =3D BB_ACK(p[lo]);
> -                               sector_t start =3D BB_OFFSET(p[lo]);
> -
> -                               p[lo] =3D BB_MAKE(start, s - start, ack);
> -                               /* now low doesn't overlap, so.. */
> -                               break;
> -                       }
> -                       lo--;
> -               }
> -               /* 'lo' is strictly before, 'hi' is strictly after,
> -                * anything between needs to be discarded
> -                */
> -               if (hi - lo > 1) {
> -                       memmove(p+lo+1, p+hi, (bb->count - hi) * 8);
> -                       bb->count -=3D (hi - lo - 1);
> -               }
> -       }
> -
> -       badblocks_update_acked(bb);
> -       bb->changed =3D 1;
> -out:
> -       write_sequnlock_irq(&bb->lock);
> -       return rv;
> +       return _badblocks_clear(bb, s, sectors);
>  }
>  EXPORT_SYMBOL_GPL(badblocks_clear);
>
> --
> 2.35.3
>

Reviewed-by: Xiao Ni <xni@redhat.com>


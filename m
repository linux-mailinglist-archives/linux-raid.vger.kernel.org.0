Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5BAE8008
	for <lists+linux-raid@lfdr.de>; Tue, 29 Oct 2019 07:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732074AbfJ2GEl (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 29 Oct 2019 02:04:41 -0400
Received: from mail-qt1-f169.google.com ([209.85.160.169]:36204 "EHLO
        mail-qt1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfJ2GEe (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 29 Oct 2019 02:04:34 -0400
Received: by mail-qt1-f169.google.com with SMTP id x14so8262475qtq.3
        for <linux-raid@vger.kernel.org>; Mon, 28 Oct 2019 23:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1tztmlAFypJ4rlH+/mC1kARZ9cFAw4qTp9EN2BKBJM4=;
        b=NRPZvDfpLNUd4sFJUCYoctSBZ4ZlbTuQgx8CWgAmQIzoLXFynN8hwftAa6g8DwXv60
         dCkiZv9n1xQwtS1Nj7cn+DUvNX323A6pwPl5P60hFsNCc4VqTkvYrLrTA23N14+H8Qka
         od81tWLfVTyeEw5e7GDS4eZ6OXkk+KzNRjdTRvgjOuke/h82xQRkWWisYKroav9m3peu
         v0V3EM50EixaE6qM5OhEK6pAKZk8M/oZRZ0Bw7Pjjx/MLqN867RbVKHpIG55HOkEu6DV
         ulEhPj/MHkS4CTFTlWVUJV9mX2Q+zu0rlOrqfq4uWwSQ7pdz74c5O8BRkMmwT1CL1O4V
         6/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1tztmlAFypJ4rlH+/mC1kARZ9cFAw4qTp9EN2BKBJM4=;
        b=o7Ky8IPGnOXS0BMlDEIjsdaPxkJBq6UwdTxQjQd/r7FlcqKcCAxgoGpncCTPKBd5Ki
         LeIn0IFd4dvsPm5/CgbCsoCVkNmXF9DiBO7MOYH14T07O6Y9KbO4FYoQVqYjoiMC8zET
         Rvmx8XsS/RWS4C7OrlXzXfxcmOb57bY98ofg5sed2ZMBRGuqAe4XQ+pO+hg3alb+As2Q
         qc2+ehPB0T+o966ryywSSvHU8upqKgDR1JJ1GfLQExBdGDNBecljxFTNxubcX7srnAGk
         +rNtVTM+BTS8qDd3vemEiWIh62RzReGnItQR1tV8u3y7uCVHLGWkpbgeHKO9TNIBkXd3
         vvJw==
X-Gm-Message-State: APjAAAXKUGzuwbLfRtBtg74SgXBbU84h3mWaVYrR0t66FCyWUkWIKqld
        3K737O52SRiCL0GE4YauIHSPR5v6MW2qjJ4Rp2fAx74r
X-Google-Smtp-Source: APXvYqzR5jrzXB1X9Wx/vj40mJDpYeL6AhIRWTwy5GqAJm5F+1CEosIX+s26tFw5XcQwEO9X+uDkqzg1uur80f5PdBQ=
X-Received: by 2002:ac8:395a:: with SMTP id t26mr2591659qtb.22.1572329072969;
 Mon, 28 Oct 2019 23:04:32 -0700 (PDT)
MIME-Version: 1.0
References: <25373b220163b01b8990aa049fec9d18@iki.fi> <CAPhsuW51S=tO+A0SDb1EvtoCG9pVSC91e9euG2nsp+rZiUgF7A@mail.gmail.com>
 <f1de00a04761370d90018f288b9b2996@iki.fi> <CAPhsuW4pddLHge+tkz2pvsPv9xgXi=WvVH3ck5KTF7EkNgE2iA@mail.gmail.com>
 <2054f286c123d9b9bcc66faf0d6f7d10@iki.fi>
In-Reply-To: <2054f286c123d9b9bcc66faf0d6f7d10@iki.fi>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Mon, 28 Oct 2019 23:04:21 -0700
Message-ID: <CAPhsuW68wmVQ6eH3o_eE+BkDXSfWHy7kEcsMj04uEzAGigbwkg@mail.gmail.com>
Subject: Re: RAID6 gets stuck during reshape with 100% CPU
To:     Anssi Hannula <anssi.hannula@iki.fi>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Sat, Oct 26, 2019 at 3:07 AM Anssi Hannula <anssi.hannula@iki.fi> wrote:
>
> Song Liu kirjoitti 2019-10-25 01:56:
> > On Thu, Oct 24, 2019 at 12:42 PM Anssi Hannula <anssi.hannula@iki.fi>
> > wrote:
> >> Song Liu kirjoitti 2019-10-24 21:50:
> >> > On Sat, Oct 19, 2019 at 2:10 AM Anssi Hannula <anssi.hannula@iki.fi>
> >> > wrote:
> >> >>
> >> >> Hi all,
> >> >>
> >> >> I'm seeing a reshape issue where the array gets stuck with requests
> >> >> seemingly getting blocked and md0_raid6 process taking 100% CPU
> >> >> whenever
> >> >> I --continue the reshape.
> >> >>
> >> >>  From what I can tell, the md0_raid6 process is stuck processing a set
> >> >> of
> >> >> stripes over and over via handle_stripe() without progressing.
> >> >>
> >> >> Log excerpt of one handle_stripe() of an affected stripe with some
> >> >> extra
> >> >> logging is below.
> >> >> The 4600-5200 integers are line numbers for
> >> >> http://onse.fi/files/reshape-infloop-issue/raid5.c .
> >> >
> >> > Maybe add sh->sector to DEBUGPRINT()?
> >>
> >> Note that the XX debug printing was guarded by
> >>
> >>   bool debout = (sh->sector == 198248960) && __ratelimit(&_rsafasfas);
> >>
> >> So everything was for sector 198248960 and rate limited every 20sec to
> >> avoid a flood.
> >>
> >> > Also, please add more DEBUGPRINT() in the
> >> >
> >> > if (sh->reconstruct_state == reconstruct_state_result) {
> >> >
> >> > case.
> >>
> >> OK, added prints there.
> >>
> >> Though after logging I noticed that the execution never gets there,
> >> sh->reconstruct_state is always reconstruct_state_idle at that point.
> >> It gets cleared on the "XX too many failed" log message (line 4798).
> >>
> > I guess the failed = 10 is the problem here..
> >
> > What does /proc/mdstat say?
>
> After --assemble --backup-file=xx, before --grow:
>
> md0 : active raid6 sdac[0] sdf[21] sdh[17] sdj[18] sde[26] sdr[20]
> sds[15] sdad[25] sdk[13] sdp[27] sdo[11] sdl[10] sdn[9] sdt[16] md8[28]
> sdi[22] sdae[23] sdaf[24] sdm[3] sdg[2] sdq[1]
>        74232661248 blocks super 1.1 level 6, 64k chunk, algorithm 2
> [20/20] [UUUUUUUUUUUUUUUUUUUU]
>        [===================>.]  reshape = 97.5% (4024886912/4124036736)
> finish=10844512.0min speed=0K/sec
>        bitmap: 5/31 pages [20KB], 65536KB chunk
>
> After --grow --continue --backup-file=xx (i.e. during the
> handle_stripe() loop):
>
> md0 : active raid6 sdac[0] sdf[21] sdh[17] sdj[18] sde[26] sdr[20]
> sds[15] sdad[25] sdk[13] sdp[27] sdo[11] sdl[10] sdn[9] sdt[16] md8[28]
> sdi[22] sdae[23] sdaf[24] sdm[3] sdg[2] sdq[1]
>        74232661248 blocks super 1.1 level 6, 64k chunk, algorithm 2
> [20/20] [UUUUUUUUUUUUUUUUUUUU]
>        [===================>.]  reshape = 97.5% (4024917256/4124036736)
> finish=7674.2min speed=215K/sec
>        bitmap: 5/31 pages [20KB], 65536KB chunk
>
> After a reboot due to the stuck array the reshape progress gets reset
> back to 4024886912.

So, I am looking at this part.

[  274.084437] check 19: state 0x813 read 00000000b79fab11 write
00000000b79fab11 written 00000000b79fab11
[  274.084969] check 18: state 0xa01 read 00000000b79fab11 write
00000000b79fab11 written 00000000b79fab11
[  274.085491] check 17: state 0xa01 read 00000000b79fab11 write
00000000b79fab11 written 00000000b79fab11
[  274.086036] check 16: state 0xa01 read 00000000b79fab11 write
00000000b79fab11 written 00000000b79fab11
[  274.086569] check 15: state 0x811 read 00000000b79fab11 write
00000000b79fab11 written 00000000b79fab11
[  274.087088] check 14: state 0xa01 read 00000000b79fab11 write
00000000b79fab11 written 00000000b79fab11
[  274.087612] check 13: state 0xa01 read 00000000b79fab11 write
00000000b79fab11 written 00000000b79fab11
[  274.088129] check 12: state 0xa01 read 00000000b79fab11 write
00000000b79fab11 written 00000000b79fab11
[  274.088652] check 11: state 0x811 read 00000000b79fab11 write
00000000b79fab11 written 00000000b79fab11
[  274.089167] check 10: state 0x811 read 00000000b79fab11 write
00000000b79fab11 written 00000000b79fab11
[  274.089691] check 9: state 0x811 read 00000000b79fab11 write
00000000b79fab11 written 00000000b79fab11
[  274.090209] check 8: state 0x811 read 00000000b79fab11 write
00000000b79fab11 written 00000000b79fab11
[  274.090727] check 7: state 0xa01 read 00000000b79fab11 write
00000000b79fab11 written 00000000b79fab11
[  274.091243] check 6: state 0xa01 read 00000000b79fab11 write
00000000b79fab11 written 00000000b79fab11
[  274.091763] check 5: state 0xa01 read 00000000b79fab11 write
00000000b79fab11 written 00000000b79fab11
[  274.092279] check 4: state 0xa01 read 00000000b79fab11 write
00000000b79fab11 written 00000000b79fab11
[  274.092800] check 3: state 0x811 read 00000000b79fab11 write
00000000b79fab11 written 00000000b79fab11
[  274.093309] check 2: state 0x811 read 00000000b79fab11 write
00000000b79fab11 written 00000000b79fab11
[  274.093810] check 1: state 0x811 read 00000000b79fab11 write
00000000b79fab11 written 00000000b79fab11
[  274.094317] check 0: state 0x813 read 00000000b79fab11 write
00000000b79fab11 written 00000000b79fab11

So 10 devices don't have R5_Insync here.

Could you please add more prints to the following section:

if (!rdev)
        /* Not in-sync */;
else if (is_bad) {
       /* also not in-sync */

[...]

else if (test_bit(R5_UPTODATE, &dev->flags) &&
         test_bit(R5_Expanded, &dev->flags))
        /* If we've reshaped into here, we assume it is Insync.
        * We will shortly update recovery_offset to make
        * it official.
       */
       set_bit(R5_Insync, &dev->flags);

I guess we get into "is_bad", case, but it should not be the case?

Thanks,
Song

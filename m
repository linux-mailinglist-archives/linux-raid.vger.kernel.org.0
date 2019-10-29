Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D42FE926A
	for <lists+linux-raid@lfdr.de>; Tue, 29 Oct 2019 22:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbfJ2VzS (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 29 Oct 2019 17:55:18 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40879 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbfJ2VzS (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 29 Oct 2019 17:55:18 -0400
Received: by mail-qk1-f194.google.com with SMTP id y81so504895qkb.7
        for <linux-raid@vger.kernel.org>; Tue, 29 Oct 2019 14:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WFbCGzF4Qu2CRkxFUMLTLPyV/JXwcUiJlMLzHGovvmE=;
        b=bppuY+WoQJxeE/WxBIn+u6YHJQ9wy3ZBbHIni8cg7bzaGAajr7UgAhtcnwLrvA53LN
         FoFweXVelB45sogfgcIflQHLfwWSI+TTSx6z+/j+BEQcvVH3m/JVcNRQQe8l31I37ger
         jTOdJ+dbgbAql5qtZKjBWM72fOMO01dvmaI99KbsO8kE+NHPRlzzjZ5bNxLC7b6nkztM
         AhLFayNPv09qBTZWGeojNUeqH01VbtedQV3rPggmbvdKr5n7asi5a23b2zBihMzsPXLS
         emWOdHXeX2+E3j/dEFZxMnLeo7MRCsZXhGLNipps5PHrhDRlDOh7pSDmWSu1iRliCubv
         uatw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WFbCGzF4Qu2CRkxFUMLTLPyV/JXwcUiJlMLzHGovvmE=;
        b=Wy4Uw1PwX2Ssnd55YTbIoQWrlDAiWfs/9vz9/A4mFLW5i4yqfIrw4g40L0igEE3hYb
         GMxFwFWSpPjnH3KCzARcHiScAZPfxx31aqhRNHo86YchL0XkezegT3bDQ1mUPbIWObHU
         4ZmGHfd4wwp6UOeRipkWIyejbDzF4ufZxJkXbFxL4D8hp63OE1gblnMm8ZwA35HTy+Di
         xGbpMi1mZu9dOugWbD78YpFwBHCwRv9vip1dsp/blcBc3FQDMQhdiVXoqTQtD3iTNbM0
         GNT0i3bZ5Zi1GhOcd33WeR6KAH6efy60iDXi1Iw1fqVg35DckGcrrzSsjz3E3ckA+Ofy
         EckA==
X-Gm-Message-State: APjAAAVPOR+7zAXrU6kzYJPcDRzZguJvxRYvo1dv3nd1VFMac+DL2bsv
        lz/vOgtWIlHv8RmlWku9yHzJTaUQ3RY1HIFfmRI=
X-Google-Smtp-Source: APXvYqxJN8wlbPdgUm45HnVNIyQX8H0ybX/ZDy5/BHZHds2FRV+yZ6LERZXeasr9vy+dZVC/y4uqGh8tz79Jhz/RZ5Y=
X-Received: by 2002:a37:b801:: with SMTP id i1mr14107517qkf.497.1572386115221;
 Tue, 29 Oct 2019 14:55:15 -0700 (PDT)
MIME-Version: 1.0
References: <25373b220163b01b8990aa049fec9d18@iki.fi> <CAPhsuW51S=tO+A0SDb1EvtoCG9pVSC91e9euG2nsp+rZiUgF7A@mail.gmail.com>
 <f1de00a04761370d90018f288b9b2996@iki.fi> <CAPhsuW4pddLHge+tkz2pvsPv9xgXi=WvVH3ck5KTF7EkNgE2iA@mail.gmail.com>
 <2054f286c123d9b9bcc66faf0d6f7d10@iki.fi> <CAPhsuW68wmVQ6eH3o_eE+BkDXSfWHy7kEcsMj04uEzAGigbwkg@mail.gmail.com>
 <0d3573affc5c44ff169120f8667f5780@iki.fi> <CAPhsuW5hj6-BOwifzQ5DRBaAWTCazgNF8oS3MtFf=4r-ioBaRw@mail.gmail.com>
 <2952af29aba2680d5c6d17b9351bc15d@iki.fi>
In-Reply-To: <2952af29aba2680d5c6d17b9351bc15d@iki.fi>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Tue, 29 Oct 2019 14:55:04 -0700
Message-ID: <CAPhsuW6HsL2GS+G5cYfjhjiZi4ZGsSj60ov=YgQUngbNkt9bPw@mail.gmail.com>
Subject: Re: RAID6 gets stuck during reshape with 100% CPU
To:     Anssi Hannula <anssi.hannula@iki.fi>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, Oct 29, 2019 at 1:45 PM Anssi Hannula <anssi.hannula@iki.fi> wrote:
>
> Song Liu kirjoitti 2019-10-29 22:28:
> > On Tue, Oct 29, 2019 at 12:05 PM Anssi Hannula <anssi.hannula@iki.fi>
> > wrote:
> >>
> >> Song Liu kirjoitti 2019-10-29 08:04:
> >> > On Sat, Oct 26, 2019 at 3:07 AM Anssi Hannula <anssi.hannula@iki.fi>
> >> > wrote:
> >> >>
> >> >> Song Liu kirjoitti 2019-10-25 01:56:
> >> >> > On Thu, Oct 24, 2019 at 12:42 PM Anssi Hannula <anssi.hannula@iki.fi>
> >> >> > wrote:
> >> >> >> Song Liu kirjoitti 2019-10-24 21:50:
> >> >> >> > On Sat, Oct 19, 2019 at 2:10 AM Anssi Hannula <anssi.hannula@iki.fi>
> >> >> >> > wrote:
> >> >> >> >>
> >> >> >> >> Hi all,
> >> >> >> >>
> >> >> >> >> I'm seeing a reshape issue where the array gets stuck with requests
> >> >> >> >> seemingly getting blocked and md0_raid6 process taking 100% CPU
> >> >> >> >> whenever
> >> >> >> >> I --continue the reshape.
> >> >> >> >>
> >> >> >> >>  From what I can tell, the md0_raid6 process is stuck processing a set
> >> >> >> >> of
> >> >> >> >> stripes over and over via handle_stripe() without progressing.
> >> >> >> >>
> >> >> >> >> Log excerpt of one handle_stripe() of an affected stripe with some
> >> >> >> >> extra
> >> >> >> >> logging is below.
> >> >> >> >> The 4600-5200 integers are line numbers for
> >> >> >> >> http://onse.fi/files/reshape-infloop-issue/raid5.c .
> >> >> >> >
> >> >> >> > Maybe add sh->sector to DEBUGPRINT()?
> >> >> >>
> >> >> >> Note that the XX debug printing was guarded by
> >> >> >>
> >> >> >>   bool debout = (sh->sector == 198248960) && __ratelimit(&_rsafasfas);
> >> >> >>
> >> >> >> So everything was for sector 198248960 and rate limited every 20sec to
> >> >> >> avoid a flood.
> >> >> >>
> >> >> >> > Also, please add more DEBUGPRINT() in the
> >> >> >> >
> >> >> >> > if (sh->reconstruct_state == reconstruct_state_result) {
> >> >> >> >
> >> >> >> > case.
> >> >> >>
> >> >> >> OK, added prints there.
> >> >> >>
> >> >> >> Though after logging I noticed that the execution never gets there,
> >> >> >> sh->reconstruct_state is always reconstruct_state_idle at that point.
> >> >> >> It gets cleared on the "XX too many failed" log message (line 4798).
> >> >> >>
> >> >> > I guess the failed = 10 is the problem here..
> >> >> >
> >> >> > What does /proc/mdstat say?
> >> >>
> >> >> After --assemble --backup-file=xx, before --grow:
> >> >>
> >> >> md0 : active raid6 sdac[0] sdf[21] sdh[17] sdj[18] sde[26] sdr[20]
> >> >> sds[15] sdad[25] sdk[13] sdp[27] sdo[11] sdl[10] sdn[9] sdt[16]
> >> >> md8[28]
> >> >> sdi[22] sdae[23] sdaf[24] sdm[3] sdg[2] sdq[1]
> >> >>        74232661248 blocks super 1.1 level 6, 64k chunk, algorithm 2
> >> >> [20/20] [UUUUUUUUUUUUUUUUUUUU]
> >> >>        [===================>.]  reshape = 97.5%
> >> >> (4024886912/4124036736)
> >> >> finish=10844512.0min speed=0K/sec
> >> >>        bitmap: 5/31 pages [20KB], 65536KB chunk
> >> >>
> >> >> After --grow --continue --backup-file=xx (i.e. during the
> >> >> handle_stripe() loop):
> >> >>
> >> >> md0 : active raid6 sdac[0] sdf[21] sdh[17] sdj[18] sde[26] sdr[20]
> >> >> sds[15] sdad[25] sdk[13] sdp[27] sdo[11] sdl[10] sdn[9] sdt[16]
> >> >> md8[28]
> >> >> sdi[22] sdae[23] sdaf[24] sdm[3] sdg[2] sdq[1]
> >> >>        74232661248 blocks super 1.1 level 6, 64k chunk, algorithm 2
> >> >> [20/20] [UUUUUUUUUUUUUUUUUUUU]
> >> >>        [===================>.]  reshape = 97.5%
> >> >> (4024917256/4124036736)
> >> >> finish=7674.2min speed=215K/sec
> >> >>        bitmap: 5/31 pages [20KB], 65536KB chunk
> >> >>
> >> >> After a reboot due to the stuck array the reshape progress gets reset
> >> >> back to 4024886912.
> >> >
> >> > So, I am looking at this part.
> >> >
> >> > [  274.084437] check 19: state 0x813 read 00000000b79fab11 write
> >> > 00000000b79fab11 written 00000000b79fab11
> >> > [  274.084969] check 18: state 0xa01 read 00000000b79fab11 write
> >> > 00000000b79fab11 written 00000000b79fab11
> >> > [  274.085491] check 17: state 0xa01 read 00000000b79fab11 write
> >> > 00000000b79fab11 written 00000000b79fab11
> >> > [  274.086036] check 16: state 0xa01 read 00000000b79fab11 write
> >> > 00000000b79fab11 written 00000000b79fab11
> >> > [  274.086569] check 15: state 0x811 read 00000000b79fab11 write
> >> > 00000000b79fab11 written 00000000b79fab11
> >> > [  274.087088] check 14: state 0xa01 read 00000000b79fab11 write
> >> > 00000000b79fab11 written 00000000b79fab11
> >> > [  274.087612] check 13: state 0xa01 read 00000000b79fab11 write
> >> > 00000000b79fab11 written 00000000b79fab11
> >> > [  274.088129] check 12: state 0xa01 read 00000000b79fab11 write
> >> > 00000000b79fab11 written 00000000b79fab11
> >> > [  274.088652] check 11: state 0x811 read 00000000b79fab11 write
> >> > 00000000b79fab11 written 00000000b79fab11
> >> > [  274.089167] check 10: state 0x811 read 00000000b79fab11 write
> >> > 00000000b79fab11 written 00000000b79fab11
> >> > [  274.089691] check 9: state 0x811 read 00000000b79fab11 write
> >> > 00000000b79fab11 written 00000000b79fab11
> >> > [  274.090209] check 8: state 0x811 read 00000000b79fab11 write
> >> > 00000000b79fab11 written 00000000b79fab11
> >> > [  274.090727] check 7: state 0xa01 read 00000000b79fab11 write
> >> > 00000000b79fab11 written 00000000b79fab11
> >> > [  274.091243] check 6: state 0xa01 read 00000000b79fab11 write
> >> > 00000000b79fab11 written 00000000b79fab11
> >> > [  274.091763] check 5: state 0xa01 read 00000000b79fab11 write
> >> > 00000000b79fab11 written 00000000b79fab11
> >> > [  274.092279] check 4: state 0xa01 read 00000000b79fab11 write
> >> > 00000000b79fab11 written 00000000b79fab11
> >> > [  274.092800] check 3: state 0x811 read 00000000b79fab11 write
> >> > 00000000b79fab11 written 00000000b79fab11
> >> > [  274.093309] check 2: state 0x811 read 00000000b79fab11 write
> >> > 00000000b79fab11 written 00000000b79fab11
> >> > [  274.093810] check 1: state 0x811 read 00000000b79fab11 write
> >> > 00000000b79fab11 written 00000000b79fab11
> >> > [  274.094317] check 0: state 0x813 read 00000000b79fab11 write
> >> > 00000000b79fab11 written 00000000b79fab11
> >> >
> >> > So 10 devices don't have R5_Insync here.
> >> >
> >> > Could you please add more prints to the following section:
> >> >
> >> > if (!rdev)
> >> >         /* Not in-sync */;
> >> > else if (is_bad) {
> >> >        /* also not in-sync */
> >> >
> >> > [...]
> >> >
> >> > else if (test_bit(R5_UPTODATE, &dev->flags) &&
> >> >          test_bit(R5_Expanded, &dev->flags))
> >> >         /* If we've reshaped into here, we assume it is Insync.
> >> >         * We will shortly update recovery_offset to make
> >> >         * it official.
> >> >        */
> >> >        set_bit(R5_Insync, &dev->flags);
> >>
> >>
> >> Added some more debugging:
> >> http://onse.fi/files/reshape-infloop-issue/dmesg-3.txt
> >> http://onse.fi/files/reshape-infloop-issue/raid5-3.c
> >> with excerpt below.
> >>
> >> > I guess we get into "is_bad", case, but it should not be the case?
> >>
> >> Right, is_bad is set, which causes R5_Insync and R5_ReadError to be
> >> set
> >> on lines 4497-4498, and R5_Insync to be cleared on line 4554 (if
> >> R5_ReadError then clear R5_Insync).
> >>
> >> As mentioned in my first message and seen in
> >> http://onse.fi/files/reshape-infloop-issue/examine-all.txt , the MD
> >> bad
> >> block lists contain blocks (suspiciously identical across devices).
> >> So maybe the code can't properly handle the case where 10 devices have
> >> the same block in their bad block list. Not quite sure what "handle"
> >> should mean in this case but certainly something else than a
> >> handle_stripe() loop :)
> >> There is a "bad" block on 10 devices on sector 198504960, which I
> >> guess
> >> matches sh->sector 198248960 due to data offset of 256000 sectors (per
> >> --examine).
> >
> > OK, it makes sense now. I didn't add the data offset when checking the
> > bad
> > block data.
> >
> >>
> >> I've wondered if "dd if=/dev/md0 of=/dev/md0" for the affected blocks
> >> would clear the bad blocks and avoid this issue, but I haven't tried
> >> that yet so that the infinite loop issue can be investigated/fixed
> >> first. I already checked that /dev/md0 is fully readable (which also
> >> confuses me a bit since md(8) says "Attempting to read from a known
> >> bad
> >> block will cause a read error"... maybe I'm missing something).
> >>
> >
> > Maybe try these steps?
> >
> > https://raid.wiki.kernel.org/index.php/The_Badblocks_controversy#How_do_I_fix_a_Bad_Blocks_problem.3F
>
> Yeah, I guess those steps would probably resolve my situation. BTW,
> "--update=force-no-bbl" is not mentioned on mdadm(8), is it on purpose?
> I was trying to find such an option earlier.
>
> If you don't need anything more from the array, I'll go ahead and try
> clearing the seemingly bogus bad block lists.

Please go ahead. We already got quite a few logs.

Thanks,
Song

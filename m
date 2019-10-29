Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B713E8FAB
	for <lists+linux-raid@lfdr.de>; Tue, 29 Oct 2019 20:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbfJ2TFL (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 29 Oct 2019 15:05:11 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41457 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfJ2TFK (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 29 Oct 2019 15:05:10 -0400
Received: by mail-lj1-f194.google.com with SMTP id m9so6824200ljh.8
        for <linux-raid@vger.kernel.org>; Tue, 29 Oct 2019 12:05:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date:from
         :to:cc:subject:in-reply-to:references:user-agent:message-id;
        bh=8LqihWDpjeW9nZUioh+cs3tA/JzjI5uDKbpj6YH6NFw=;
        b=OdCJ+5iiXa1kN+ChXCMlEkUL9qAJOn5l804gkAqWD9lsmfJ3ClWIqi2CPtKlY+ku2u
         6+gqp0BZDXd/MaF0p6tVWmWAkyr8/fiM2A7eTc11sLcMjhN6DRHEptPBI4AS3Ecruifs
         esIM3OCYg0wL7i974uuIqJyXs4EycVdxNkTAEsu3BrJNxa1+jk1veLwqy85HIqoL4QQd
         PiGrVM9LU+BtmrFh/1DpDBPso4Lb6/Cz3ig2jMy2M9p0Ej+4Kz3AR+D7atOBLcVseFBx
         1uzuGmeJpnTR5x5Sid6V/REbbBmZ/P5bS4rFmUpeuNGw8J1yo1XCGyj/RNXYsfpBKzKV
         guoA==
X-Gm-Message-State: APjAAAV9Equ+0Rb6eV1VhVau47A0B3pg4GlpLjYdX20lE94mXmRcsXAx
        PXDom2uD/xMVJMHevYv8M7w=
X-Google-Smtp-Source: APXvYqwQ0f4m7/rVyteaVcdNAEbsqaHmbTjTRHOKe1owE1FKNoxb3J3khH5RURwKHCdQjJrXlCiwjA==
X-Received: by 2002:a2e:999a:: with SMTP id w26mr3825723lji.200.1572375906189;
        Tue, 29 Oct 2019 12:05:06 -0700 (PDT)
Received: from mail.onse.fi ([109.204.156.230])
        by smtp.gmail.com with ESMTPSA id s27sm7943595lfc.43.2019.10.29.12.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 12:05:04 -0700 (PDT)
Received: from mail.onse.fi (delta.onse.fi [127.0.0.1])
        by mail.onse.fi (Postfix) with ESMTP id B5049402C5;
        Tue, 29 Oct 2019 21:05:03 +0200 (EET)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 29 Oct 2019 21:05:03 +0200
From:   Anssi Hannula <anssi.hannula@iki.fi>
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Subject: Re: RAID6 gets stuck during reshape with 100% CPU
In-Reply-To: <CAPhsuW68wmVQ6eH3o_eE+BkDXSfWHy7kEcsMj04uEzAGigbwkg@mail.gmail.com>
References: <25373b220163b01b8990aa049fec9d18@iki.fi>
 <CAPhsuW51S=tO+A0SDb1EvtoCG9pVSC91e9euG2nsp+rZiUgF7A@mail.gmail.com>
 <f1de00a04761370d90018f288b9b2996@iki.fi>
 <CAPhsuW4pddLHge+tkz2pvsPv9xgXi=WvVH3ck5KTF7EkNgE2iA@mail.gmail.com>
 <2054f286c123d9b9bcc66faf0d6f7d10@iki.fi>
 <CAPhsuW68wmVQ6eH3o_eE+BkDXSfWHy7kEcsMj04uEzAGigbwkg@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4-rc2
Message-ID: <0d3573affc5c44ff169120f8667f5780@iki.fi>
X-Sender: anssi.hannula@iki.fi
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Song Liu kirjoitti 2019-10-29 08:04:
> On Sat, Oct 26, 2019 at 3:07 AM Anssi Hannula <anssi.hannula@iki.fi> 
> wrote:
>> 
>> Song Liu kirjoitti 2019-10-25 01:56:
>> > On Thu, Oct 24, 2019 at 12:42 PM Anssi Hannula <anssi.hannula@iki.fi>
>> > wrote:
>> >> Song Liu kirjoitti 2019-10-24 21:50:
>> >> > On Sat, Oct 19, 2019 at 2:10 AM Anssi Hannula <anssi.hannula@iki.fi>
>> >> > wrote:
>> >> >>
>> >> >> Hi all,
>> >> >>
>> >> >> I'm seeing a reshape issue where the array gets stuck with requests
>> >> >> seemingly getting blocked and md0_raid6 process taking 100% CPU
>> >> >> whenever
>> >> >> I --continue the reshape.
>> >> >>
>> >> >>  From what I can tell, the md0_raid6 process is stuck processing a set
>> >> >> of
>> >> >> stripes over and over via handle_stripe() without progressing.
>> >> >>
>> >> >> Log excerpt of one handle_stripe() of an affected stripe with some
>> >> >> extra
>> >> >> logging is below.
>> >> >> The 4600-5200 integers are line numbers for
>> >> >> http://onse.fi/files/reshape-infloop-issue/raid5.c .
>> >> >
>> >> > Maybe add sh->sector to DEBUGPRINT()?
>> >>
>> >> Note that the XX debug printing was guarded by
>> >>
>> >>   bool debout = (sh->sector == 198248960) && __ratelimit(&_rsafasfas);
>> >>
>> >> So everything was for sector 198248960 and rate limited every 20sec to
>> >> avoid a flood.
>> >>
>> >> > Also, please add more DEBUGPRINT() in the
>> >> >
>> >> > if (sh->reconstruct_state == reconstruct_state_result) {
>> >> >
>> >> > case.
>> >>
>> >> OK, added prints there.
>> >>
>> >> Though after logging I noticed that the execution never gets there,
>> >> sh->reconstruct_state is always reconstruct_state_idle at that point.
>> >> It gets cleared on the "XX too many failed" log message (line 4798).
>> >>
>> > I guess the failed = 10 is the problem here..
>> >
>> > What does /proc/mdstat say?
>> 
>> After --assemble --backup-file=xx, before --grow:
>> 
>> md0 : active raid6 sdac[0] sdf[21] sdh[17] sdj[18] sde[26] sdr[20]
>> sds[15] sdad[25] sdk[13] sdp[27] sdo[11] sdl[10] sdn[9] sdt[16] 
>> md8[28]
>> sdi[22] sdae[23] sdaf[24] sdm[3] sdg[2] sdq[1]
>>        74232661248 blocks super 1.1 level 6, 64k chunk, algorithm 2
>> [20/20] [UUUUUUUUUUUUUUUUUUUU]
>>        [===================>.]  reshape = 97.5% 
>> (4024886912/4124036736)
>> finish=10844512.0min speed=0K/sec
>>        bitmap: 5/31 pages [20KB], 65536KB chunk
>> 
>> After --grow --continue --backup-file=xx (i.e. during the
>> handle_stripe() loop):
>> 
>> md0 : active raid6 sdac[0] sdf[21] sdh[17] sdj[18] sde[26] sdr[20]
>> sds[15] sdad[25] sdk[13] sdp[27] sdo[11] sdl[10] sdn[9] sdt[16] 
>> md8[28]
>> sdi[22] sdae[23] sdaf[24] sdm[3] sdg[2] sdq[1]
>>        74232661248 blocks super 1.1 level 6, 64k chunk, algorithm 2
>> [20/20] [UUUUUUUUUUUUUUUUUUUU]
>>        [===================>.]  reshape = 97.5% 
>> (4024917256/4124036736)
>> finish=7674.2min speed=215K/sec
>>        bitmap: 5/31 pages [20KB], 65536KB chunk
>> 
>> After a reboot due to the stuck array the reshape progress gets reset
>> back to 4024886912.
> 
> So, I am looking at this part.
> 
> [  274.084437] check 19: state 0x813 read 00000000b79fab11 write
> 00000000b79fab11 written 00000000b79fab11
> [  274.084969] check 18: state 0xa01 read 00000000b79fab11 write
> 00000000b79fab11 written 00000000b79fab11
> [  274.085491] check 17: state 0xa01 read 00000000b79fab11 write
> 00000000b79fab11 written 00000000b79fab11
> [  274.086036] check 16: state 0xa01 read 00000000b79fab11 write
> 00000000b79fab11 written 00000000b79fab11
> [  274.086569] check 15: state 0x811 read 00000000b79fab11 write
> 00000000b79fab11 written 00000000b79fab11
> [  274.087088] check 14: state 0xa01 read 00000000b79fab11 write
> 00000000b79fab11 written 00000000b79fab11
> [  274.087612] check 13: state 0xa01 read 00000000b79fab11 write
> 00000000b79fab11 written 00000000b79fab11
> [  274.088129] check 12: state 0xa01 read 00000000b79fab11 write
> 00000000b79fab11 written 00000000b79fab11
> [  274.088652] check 11: state 0x811 read 00000000b79fab11 write
> 00000000b79fab11 written 00000000b79fab11
> [  274.089167] check 10: state 0x811 read 00000000b79fab11 write
> 00000000b79fab11 written 00000000b79fab11
> [  274.089691] check 9: state 0x811 read 00000000b79fab11 write
> 00000000b79fab11 written 00000000b79fab11
> [  274.090209] check 8: state 0x811 read 00000000b79fab11 write
> 00000000b79fab11 written 00000000b79fab11
> [  274.090727] check 7: state 0xa01 read 00000000b79fab11 write
> 00000000b79fab11 written 00000000b79fab11
> [  274.091243] check 6: state 0xa01 read 00000000b79fab11 write
> 00000000b79fab11 written 00000000b79fab11
> [  274.091763] check 5: state 0xa01 read 00000000b79fab11 write
> 00000000b79fab11 written 00000000b79fab11
> [  274.092279] check 4: state 0xa01 read 00000000b79fab11 write
> 00000000b79fab11 written 00000000b79fab11
> [  274.092800] check 3: state 0x811 read 00000000b79fab11 write
> 00000000b79fab11 written 00000000b79fab11
> [  274.093309] check 2: state 0x811 read 00000000b79fab11 write
> 00000000b79fab11 written 00000000b79fab11
> [  274.093810] check 1: state 0x811 read 00000000b79fab11 write
> 00000000b79fab11 written 00000000b79fab11
> [  274.094317] check 0: state 0x813 read 00000000b79fab11 write
> 00000000b79fab11 written 00000000b79fab11
> 
> So 10 devices don't have R5_Insync here.
> 
> Could you please add more prints to the following section:
> 
> if (!rdev)
>         /* Not in-sync */;
> else if (is_bad) {
>        /* also not in-sync */
> 
> [...]
> 
> else if (test_bit(R5_UPTODATE, &dev->flags) &&
>          test_bit(R5_Expanded, &dev->flags))
>         /* If we've reshaped into here, we assume it is Insync.
>         * We will shortly update recovery_offset to make
>         * it official.
>        */
>        set_bit(R5_Insync, &dev->flags);


Added some more debugging:
http://onse.fi/files/reshape-infloop-issue/dmesg-3.txt
http://onse.fi/files/reshape-infloop-issue/raid5-3.c
with excerpt below.

> I guess we get into "is_bad", case, but it should not be the case?

Right, is_bad is set, which causes R5_Insync and R5_ReadError to be set 
on lines 4497-4498, and R5_Insync to be cleared on line 4554 (if 
R5_ReadError then clear R5_Insync).

As mentioned in my first message and seen in 
http://onse.fi/files/reshape-infloop-issue/examine-all.txt , the MD bad 
block lists contain blocks (suspiciously identical across devices).
So maybe the code can't properly handle the case where 10 devices have 
the same block in their bad block list. Not quite sure what "handle" 
should mean in this case but certainly something else than a 
handle_stripe() loop :)
There is a "bad" block on 10 devices on sector 198504960, which I guess 
matches sh->sector 198248960 due to data offset of 256000 sectors (per 
--examine).

I've wondered if "dd if=/dev/md0 of=/dev/md0" for the affected blocks 
would clear the bad blocks and avoid this issue, but I haven't tried 
that yet so that the infinite loop issue can be investigated/fixed 
first. I already checked that /dev/md0 is fully readable (which also 
confuses me a bit since md(8) says "Attempting to read from a known bad 
block will cause a read error"... maybe I'm missing something).



[  328.592577] XX handle_stripe 4720, state 0x1402, reconstr 6, sector 
198248960
[  328.594018] XX handle_stripe 4729, state 0x1401, reconstr 6, sector 
198248960
[  328.595240] XX handle_stripe 4735, state 0x1401, reconstr 6, sector 
198248960
[  328.596454] XX handle_stripe 4739, state 0x1401, reconstr 6, sector 
198248960
[  328.597637] XX handle_stripe 4758, state 0x1401, reconstr 6, sector 
198248960
[  328.598830] handling stripe 198248960, state=0x1401 cnt=1, pd_idx=19, 
qd_idx=0
                , check:0, reconstruct:6
[  328.601156] check 19: state 0x813 read 00000000e14ef0e3 write 
00000000e14ef0e3 written 00000000e14ef0e3
[  328.602339] dev 19 line 4465
[  328.603531] dev 19 line 4483: state 0x803, rdev 00000000e7b60c1c, 
is_bad 0, dev 0000000013f40720, rdev state 0x2
[  328.604734] check 18: state 0xa01 read 00000000e14ef0e3 write 
00000000e14ef0e3 written 00000000e14ef0e3
[  328.605894] dev 18 line 4465
[  328.607092] dev 18 line 4483: state 0xa01, rdev 0000000060824a92, 
is_bad 1, dev 000000008fec1d3d, rdev state 0x2
[  328.608271] dev is bad but up to date (and rdev has no write errors) 
so setting R5_Insync anyway
[  328.609469] check 17: state 0xa01 read 00000000e14ef0e3 write 
00000000e14ef0e3 written 00000000e14ef0e3
[  328.610639] dev 17 line 4465
[  328.611846] dev 17 line 4483: state 0xa01, rdev 00000000901a3454, 
is_bad 1, dev 000000008f5ffeca, rdev state 0x2
[  328.613025] dev is bad but up to date (and rdev has no write errors) 
so setting R5_Insync anyway
[  328.614206] check 16: state 0xa01 read 00000000e14ef0e3 write 
00000000e14ef0e3 written 00000000e14ef0e3
[  328.615413] dev 16 line 4465
[  328.616594] dev 16 line 4483: state 0xa01, rdev 00000000a1f5fe8d, 
is_bad 1, dev 0000000070480dac, rdev state 0x2
[  328.617771] dev is bad but up to date (and rdev has no write errors) 
so setting R5_Insync anyway
[  328.618993] check 15: state 0x811 read 00000000e14ef0e3 write 
00000000e14ef0e3 written 00000000e14ef0e3
[  328.620169] dev 15 line 4465
[  328.621360] dev 15 line 4483: state 0x801, rdev 000000007d71d75d, 
is_bad 0, dev 00000000851a50fb, rdev state 0x2
[  328.622532] check 14: state 0xa01 read 00000000e14ef0e3 write 
00000000e14ef0e3 written 00000000e14ef0e3
[  328.623720] dev 14 line 4465
[  328.624891] dev 14 line 4483: state 0xa01, rdev 00000000318370a5, 
is_bad 1, dev 0000000065d9c447, rdev state 0x2
[  328.626093] dev is bad but up to date (and rdev has no write errors) 
so setting R5_Insync anyway
[  328.627292] check 13: state 0xa01 read 00000000e14ef0e3 write 
00000000e14ef0e3 written 00000000e14ef0e3
[  328.628490] dev 13 line 4465
[  328.629682] dev 13 line 4483: state 0xa01, rdev 00000000001d3ba2, 
is_bad 1, dev 00000000d16ad23d, rdev state 0x2
[  328.630895] dev is bad but up to date (and rdev has no write errors) 
so setting R5_Insync anyway
[  328.632074] check 12: state 0xa01 read 00000000e14ef0e3 write 
00000000e14ef0e3 written 00000000e14ef0e3
[  328.633255] dev 12 line 4465
[  328.634428] dev 12 line 4483: state 0xa01, rdev 000000005fafcdfc, 
is_bad 1, dev 00000000b16ff9e8, rdev state 0x2
[  328.635644] dev is bad but up to date (and rdev has no write errors) 
so setting R5_Insync anyway
[  328.636834] check 11: state 0x811 read 00000000e14ef0e3 write 
00000000e14ef0e3 written 00000000e14ef0e3
[  328.638008] dev 11 line 4465
[  328.639199] dev 11 line 4483: state 0x801, rdev 00000000ff93799f, 
is_bad 0, dev 00000000bfaf62bb, rdev state 0x2
[  328.640388] check 10: state 0x811 read 00000000e14ef0e3 write 
00000000e14ef0e3 written 00000000e14ef0e3
[  328.641555] dev 10 line 4465
[  328.642739] dev 10 line 4483: state 0x801, rdev 00000000aade8988, 
is_bad 0, dev 000000009a5d3403, rdev state 0x2
[  328.643948] check 9: state 0x811 read 00000000e14ef0e3 write 
00000000e14ef0e3 written 00000000e14ef0e3
[  328.645115] dev 9 line 4465
[  328.646300] dev 9 line 4483: state 0x801, rdev 000000008fc060d2, 
is_bad 0, dev 00000000f51ede27, rdev state 0x2
[  328.647489] check 8: state 0x811 read 00000000e14ef0e3 write 
00000000e14ef0e3 written 00000000e14ef0e3
[  328.648664] dev 8 line 4465
[  328.649861] dev 8 line 4483: state 0x801, rdev 000000003828db2d, 
is_bad 0, dev 0000000077a6b836, rdev state 0x2
[  328.651058] check 7: state 0xa01 read 00000000e14ef0e3 write 
00000000e14ef0e3 written 00000000e14ef0e3
[  328.652253] dev 7 line 4465
[  328.653417] dev 7 line 4483: state 0xa01, rdev 00000000ced49b30, 
is_bad 1, dev 000000009d6dfdb3, rdev state 0x2
[  328.654601] dev is bad but up to date (and rdev has no write errors) 
so setting R5_Insync anyway
[  328.655832] check 6: state 0xa01 read 00000000e14ef0e3 write 
00000000e14ef0e3 written 00000000e14ef0e3
[  328.657026] dev 6 line 4465
[  328.658259] dev 6 line 4483: state 0xa01, rdev 00000000464a6e8d, 
is_bad 1, dev 00000000bef2c6f6, rdev state 0x2
[  328.659476] dev is bad but up to date (and rdev has no write errors) 
so setting R5_Insync anyway
[  328.660696] check 5: state 0xa01 read 00000000e14ef0e3 write 
00000000e14ef0e3 written 00000000e14ef0e3
[  328.661897] dev 5 line 4465
[  328.663126] dev 5 line 4483: state 0xa01, rdev 000000000ea00b09, 
is_bad 1, dev 000000003ee9dd3a, rdev state 0x2
[  328.664396] dev is bad but up to date (and rdev has no write errors) 
so setting R5_Insync anyway
[  328.665630] check 4: state 0xa01 read 00000000e14ef0e3 write 
00000000e14ef0e3 written 00000000e14ef0e3
[  328.666877] dev 4 line 4465
[  328.668127] dev 4 line 4483: state 0xa01, rdev 000000006d92be8b, 
is_bad 1, dev 0000000062434e42, rdev state 0x2
[  328.669370] dev is bad but up to date (and rdev has no write errors) 
so setting R5_Insync anyway
[  328.670607] check 3: state 0x811 read 00000000e14ef0e3 write 
00000000e14ef0e3 written 00000000e14ef0e3
[  328.671910] dev 3 line 4465
[  328.673186] dev 3 line 4483: state 0x801, rdev 000000003a1aed81, 
is_bad 0, dev 000000003cfcd58c, rdev state 0x2
[  328.674471] check 2: state 0x811 read 00000000e14ef0e3 write 
00000000e14ef0e3 written 00000000e14ef0e3
[  328.675755] dev 2 line 4465
[  328.677042] dev 2 line 4483: state 0x801, rdev 000000000f7828de, 
is_bad 0, dev 00000000b04590c1, rdev state 0x2
[  328.678322] check 1: state 0x811 read 00000000e14ef0e3 write 
00000000e14ef0e3 written 00000000e14ef0e3
[  328.679649] dev 1 line 4465
[  328.680947] dev 1 line 4483: state 0x801, rdev 00000000f27c1175, 
is_bad 0, dev 000000003b6ec50e, rdev state 0x2
[  328.682278] check 0: state 0x813 read 00000000e14ef0e3 write 
00000000e14ef0e3 written 00000000e14ef0e3
[  328.683605] dev 0 line 4465
[  328.684930] dev 0 line 4483: state 0x803, rdev 00000000bc996dc4, 
is_bad 0, dev 000000001a00ca48, rdev state 0x2
[  328.686254] XX handle_stripe 4768, state 0x1401, reconstr 6, sector 
198248960
[  328.687605] XX handle_stripe 4772, state 0x1401, reconstr 6, sector 
198248960
[  328.688948] XX handle_stripe 4779, state 0x1401, reconstr 6, sector 
198248960
[  328.690276] XX handle_stripe 4791, state 0x1401, reconstr 6, sector 
198248960
[  328.691625] locked=2 uptodate=20 to_read=0 to_write=0 failed=10 
failed_num=18,17
[  328.692966] XX too many failed
[  328.694305] XX handle_stripe 4860, state 0x1401, reconstr 0, sector 
198248960
[  328.695647] XX handle_stripe 4873, state 0x1401, reconstr 0, sector 
198248960
[  328.696967] XX handle_stripe 4900, state 0x1401, reconstr 0, sector 
198248960
[  328.698302] XX handle_stripe 4908, state 0x1401, reconstr 0, sector 
198248960
[  328.699621] XX handle_stripe 4919, state 0x1401, reconstr 0, sector 
198248960
[  328.700937] XX handle_stripe 4949, state 0x1401, reconstr 0, sector 
198248960
[  328.702227] XX handle_stripe 4965, state 0x1401, reconstr 0, sector 
198248960
[  328.703573] XX handle_stripe 4982, state 0x1401, reconstr 0, sector 
198248960
[  328.704864] XX handle_stripe 4991, state 0x1401, reconstr 0, sector 
198248960
[  328.706134] XX handle_stripe 5016, state 0x1401, reconstr 0, sector 
198248960
[  328.707421] XX handle_stripe 5049, state 0x1401, reconstr 0, sector 
198248960
[  328.708730] handle_stripe: 5056
[  328.710000] XX handle_stripe 5065, state 0x1401, reconstr 3, sector 
198248960
[  328.711257] XX handle_stripe 5070, state 0x1401, reconstr 3, sector 
198248960
[  328.712525] XX handle_stripe 5073, state 0x1401, reconstr 3, sector 
198248960
[  328.713760] XX handle_stripe 5087, state 0x1401, reconstr 3, sector 
198248960
[  328.715029] XX handle_stripe 5117, state 0x1401, reconstr 3, sector 
198248960
[  328.716278] XX handle_stripe 5121, state 0x1403, reconstr 6, sector 
198248960
[  328.717485] XX handle_stripe 5124, state 0x1403, reconstr 6, sector 
198248960
[  328.718700] XX handle_stripe 5138, state now 0x1402


-- 
Anssi Hannula

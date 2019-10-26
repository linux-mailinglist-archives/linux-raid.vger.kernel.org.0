Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF70FE598A
	for <lists+linux-raid@lfdr.de>; Sat, 26 Oct 2019 12:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbfJZKH6 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 26 Oct 2019 06:07:58 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:38247 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfJZKH5 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sat, 26 Oct 2019 06:07:57 -0400
Received: by mail-lj1-f175.google.com with SMTP id q78so5940373lje.5
        for <linux-raid@vger.kernel.org>; Sat, 26 Oct 2019 03:07:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date:from
         :to:cc:subject:in-reply-to:references:user-agent:message-id;
        bh=2EbX4LEQTGQBxAJKrc23xjyha72G1YjOz1xedG2g15E=;
        b=AtAll+A5eSuXGs/yXzLpNKlslu86+OjZYZ5birwwwVwkOPoO2SoX0YeMBMzmS3OASJ
         ahBL0mBEH8GMJ32/FEljfajWJxL4PR5KN5OFr/TaijRHCWbTPUJWDT7kr6bNBafSCXUr
         1+JoMHpgvrpCc6UHldMUeotc9XdxetK4PEmwgjR0Bk/aeVsfoUJKujWEP0Z3s0cnIS/j
         4z2L52tRV2hypESceicsdb8Ndq/qrWNa0uIeIVvUceQtRebsiZAsLaZEZs/y1/GwtlwE
         Tb8OGwD4bZbXsPA8v/iWZ67OoMS2WpE2pnWXlcEzmcUZtF8qyxnatbcyj6hul+cdPNLc
         RhvQ==
X-Gm-Message-State: APjAAAXpMxsFQj3zGJ3fbkm+jHPhNe/ZXOwb+8AZcesfxCfVVT/gvcwH
        1ElZO0HTGig6hJmuFFGitv8=
X-Google-Smtp-Source: APXvYqyw6xuG3W8Jt2k8NFVJKW2cU5OsakqdqxFGPYdrjRkLmxn/lHWSQQVslIR/pxm6SC88ck//Xw==
X-Received: by 2002:a2e:9bcb:: with SMTP id w11mr5316588ljj.11.1572084475766;
        Sat, 26 Oct 2019 03:07:55 -0700 (PDT)
Received: from mail.onse.fi ([109.204.156.230])
        by smtp.gmail.com with ESMTPSA id b18sm1788772lfa.65.2019.10.26.03.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2019 03:07:52 -0700 (PDT)
Received: from mail.onse.fi (delta.onse.fi [127.0.0.1])
        by mail.onse.fi (Postfix) with ESMTP id 9270A40758;
        Sat, 26 Oct 2019 13:07:51 +0300 (EEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 26 Oct 2019 13:07:51 +0300
From:   Anssi Hannula <anssi.hannula@iki.fi>
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Subject: Re: RAID6 gets stuck during reshape with 100% CPU
In-Reply-To: <CAPhsuW4pddLHge+tkz2pvsPv9xgXi=WvVH3ck5KTF7EkNgE2iA@mail.gmail.com>
References: <25373b220163b01b8990aa049fec9d18@iki.fi>
 <CAPhsuW51S=tO+A0SDb1EvtoCG9pVSC91e9euG2nsp+rZiUgF7A@mail.gmail.com>
 <f1de00a04761370d90018f288b9b2996@iki.fi>
 <CAPhsuW4pddLHge+tkz2pvsPv9xgXi=WvVH3ck5KTF7EkNgE2iA@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4-rc2
Message-ID: <2054f286c123d9b9bcc66faf0d6f7d10@iki.fi>
X-Sender: anssi.hannula@iki.fi
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Song Liu kirjoitti 2019-10-25 01:56:
> On Thu, Oct 24, 2019 at 12:42 PM Anssi Hannula <anssi.hannula@iki.fi> 
> wrote:
>> Song Liu kirjoitti 2019-10-24 21:50:
>> > On Sat, Oct 19, 2019 at 2:10 AM Anssi Hannula <anssi.hannula@iki.fi>
>> > wrote:
>> >>
>> >> Hi all,
>> >>
>> >> I'm seeing a reshape issue where the array gets stuck with requests
>> >> seemingly getting blocked and md0_raid6 process taking 100% CPU
>> >> whenever
>> >> I --continue the reshape.
>> >>
>> >>  From what I can tell, the md0_raid6 process is stuck processing a set
>> >> of
>> >> stripes over and over via handle_stripe() without progressing.
>> >>
>> >> Log excerpt of one handle_stripe() of an affected stripe with some
>> >> extra
>> >> logging is below.
>> >> The 4600-5200 integers are line numbers for
>> >> http://onse.fi/files/reshape-infloop-issue/raid5.c .
>> >
>> > Maybe add sh->sector to DEBUGPRINT()?
>> 
>> Note that the XX debug printing was guarded by
>> 
>>   bool debout = (sh->sector == 198248960) && __ratelimit(&_rsafasfas);
>> 
>> So everything was for sector 198248960 and rate limited every 20sec to
>> avoid a flood.
>> 
>> > Also, please add more DEBUGPRINT() in the
>> >
>> > if (sh->reconstruct_state == reconstruct_state_result) {
>> >
>> > case.
>> 
>> OK, added prints there.
>> 
>> Though after logging I noticed that the execution never gets there,
>> sh->reconstruct_state is always reconstruct_state_idle at that point.
>> It gets cleared on the "XX too many failed" log message (line 4798).
>> 
> I guess the failed = 10 is the problem here..
> 
> What does /proc/mdstat say?

After --assemble --backup-file=xx, before --grow:

md0 : active raid6 sdac[0] sdf[21] sdh[17] sdj[18] sde[26] sdr[20] 
sds[15] sdad[25] sdk[13] sdp[27] sdo[11] sdl[10] sdn[9] sdt[16] md8[28] 
sdi[22] sdae[23] sdaf[24] sdm[3] sdg[2] sdq[1]
       74232661248 blocks super 1.1 level 6, 64k chunk, algorithm 2 
[20/20] [UUUUUUUUUUUUUUUUUUUU]
       [===================>.]  reshape = 97.5% (4024886912/4124036736) 
finish=10844512.0min speed=0K/sec
       bitmap: 5/31 pages [20KB], 65536KB chunk

After --grow --continue --backup-file=xx (i.e. during the 
handle_stripe() loop):

md0 : active raid6 sdac[0] sdf[21] sdh[17] sdj[18] sde[26] sdr[20] 
sds[15] sdad[25] sdk[13] sdp[27] sdo[11] sdl[10] sdn[9] sdt[16] md8[28] 
sdi[22] sdae[23] sdaf[24] sdm[3] sdg[2] sdq[1]
       74232661248 blocks super 1.1 level 6, 64k chunk, algorithm 2 
[20/20] [UUUUUUUUUUUUUUUUUUUU]
       [===================>.]  reshape = 97.5% (4024917256/4124036736) 
finish=7674.2min speed=215K/sec
       bitmap: 5/31 pages [20KB], 65536KB chunk

After a reboot due to the stuck array the reshape progress gets reset 
back to 4024886912.

-- 
Anssi Hannula

Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80467E3C3A
	for <lists+linux-raid@lfdr.de>; Thu, 24 Oct 2019 21:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403794AbfJXTmq (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 24 Oct 2019 15:42:46 -0400
Received: from mail-lj1-f172.google.com ([209.85.208.172]:46812 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390785AbfJXTmq (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 24 Oct 2019 15:42:46 -0400
Received: by mail-lj1-f172.google.com with SMTP id d1so26276835ljl.13
        for <linux-raid@vger.kernel.org>; Thu, 24 Oct 2019 12:42:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date:from
         :to:cc:subject:in-reply-to:references:user-agent:message-id;
        bh=1KDZVY4BKwzH1PoJPcu7nz7wgPInlQ9oTwG5Kavir34=;
        b=rOyLuqP/gcLiHibka7LlY25A3LR04skgXElXK+WHty1tvn1YmskHeoozj1zn/H/Ak8
         mIrxGuURPCi+aKZnBRvI8qqQrMU6cdgsGuQSTOQY8d56hlJWSKR4iJTJStnHfYoUNeMF
         hC4AdYbgpuuBpPXQ8fsTa7BeZQVAVBzPfGvetn8+HrVE0zqZ272D1jHUTLfsJyxtgX0L
         N7iXPcptDcH1CDGZ0dYU8oW5lElb8Bce0agYPYHXTOdBYl0EEGf00DH1AMXyDo8hHjJK
         AQPp0q4Nywi947QhtOdiNNDIChxWaQGUNCyY/Su1WyRIML2ByeSNLrdcAILOsZTVJDJZ
         +CXQ==
X-Gm-Message-State: APjAAAV2AqYN84hS63UtBO5RfJhuNINWfltrUhsmRyR5YlhEDSy/CgtN
        psU2O7YveRmkRVtMnU09vhmDG/7ggT0=
X-Google-Smtp-Source: APXvYqwU/hhF1CdFz7zjooO339G9m8HspT5hyV8byOHKTdXzmGEqmuzBefw4fHZHHFEV3OiXl2IEYA==
X-Received: by 2002:a2e:88c1:: with SMTP id a1mr8532061ljk.204.1571946162816;
        Thu, 24 Oct 2019 12:42:42 -0700 (PDT)
Received: from mail.onse.fi ([109.204.156.230])
        by smtp.gmail.com with ESMTPSA id x16sm2838807ljd.69.2019.10.24.12.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 12:42:39 -0700 (PDT)
Received: from mail.onse.fi (delta.onse.fi [127.0.0.1])
        by mail.onse.fi (Postfix) with ESMTP id 0DA3C40272;
        Thu, 24 Oct 2019 22:42:39 +0300 (EEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 24 Oct 2019 22:42:39 +0300
From:   Anssi Hannula <anssi.hannula@iki.fi>
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Subject: Re: RAID6 gets stuck during reshape with 100% CPU
In-Reply-To: <CAPhsuW51S=tO+A0SDb1EvtoCG9pVSC91e9euG2nsp+rZiUgF7A@mail.gmail.com>
References: <25373b220163b01b8990aa049fec9d18@iki.fi>
 <CAPhsuW51S=tO+A0SDb1EvtoCG9pVSC91e9euG2nsp+rZiUgF7A@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4-rc2
Message-ID: <f1de00a04761370d90018f288b9b2996@iki.fi>
X-Sender: anssi.hannula@iki.fi
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Song Liu kirjoitti 2019-10-24 21:50:
> Sorry for delayed reply.

No problem :)

> On Sat, Oct 19, 2019 at 2:10 AM Anssi Hannula <anssi.hannula@iki.fi> 
> wrote:
>> 
>> Hi all,
>> 
>> I'm seeing a reshape issue where the array gets stuck with requests
>> seemingly getting blocked and md0_raid6 process taking 100% CPU 
>> whenever
>> I --continue the reshape.
>> 
>>  From what I can tell, the md0_raid6 process is stuck processing a set 
>> of
>> stripes over and over via handle_stripe() without progressing.
>> 
>> Log excerpt of one handle_stripe() of an affected stripe with some 
>> extra
>> logging is below.
>> The 4600-5200 integers are line numbers for
>> http://onse.fi/files/reshape-infloop-issue/raid5.c .
> 
> Maybe add sh->sector to DEBUGPRINT()?

Note that the XX debug printing was guarded by

  bool debout = (sh->sector == 198248960) && __ratelimit(&_rsafasfas);

So everything was for sector 198248960 and rate limited every 20sec to 
avoid a flood.

> Also, please add more DEBUGPRINT() in the
> 
> if (sh->reconstruct_state == reconstruct_state_result) {
> 
> case.

OK, added prints there.

Though after logging I noticed that the execution never gets there, 
sh->reconstruct_state is always reconstruct_state_idle at that point.
It gets cleared on the "XX too many failed" log message (line 4798).


>> 
>> 0x1401 = STRIPE_ACTIVE STRIPE_EXPANDING STRIPE_EXPAND_READY
>> 0x1402 = STRIPE_HANDLE STRIPE_EXPANDING STRIPE_EXPAND_READY
>> 
>> 0x813 = R5_UPTODATE R5_LOCKED R5_Insync R5_Expanded
>> 0x811 = R5_UPTODATE R5_Insync R5_Expanded
>> 0xa01 = R5_UPTODATE R5_ReadError R5_Expanded
>> 
>> [  499.262769] XX handle_stripe 4694, state 0x1402, reconstr 6
>> [  499.263376] XX handle_stripe 4703, state 0x1401, reconstr 6
>> [  499.263681] XX handle_stripe 4709, state 0x1401, reconstr 6
>> [  499.263988] XX handle_stripe 4713, state 0x1401, reconstr 6
>> [  499.264355] XX handle_stripe 4732, state 0x1401, reconstr 6
>> [  499.264657] handling stripe 198248960, state=0x1401 cnt=1, 
>> pd_idx=19,
>> qd_idx=0
>>                 , check:0, reconstruct:6
>> [  499.265304] check 19: state 0x813 read 000000000bfabb56 write
>> 000000000bfabb56 written 000000000bfabb56
>> [  499.265649] check 18: state 0xa01 read 000000000bfabb56 write
>> 000000000bfabb56 written 000000000bfabb56
>> [  499.265978] check 17: state 0xa01 read 000000000bfabb56 write
>> 000000000bfabb56 written 000000000bfabb56
>> [  499.266337] check 16: state 0xa01 read 000000000bfabb56 write
>> 000000000bfabb56 written 000000000bfabb56
>> [  499.266658] check 15: state 0x811 read 000000000bfabb56 write
>> 000000000bfabb56 written 000000000bfabb56
>> [  499.266988] check 14: state 0xa01 read 000000000bfabb56 write
>> 000000000bfabb56 written 000000000bfabb56
>> [  499.267335] check 13: state 0xa01 read 000000000bfabb56 write
>> 000000000bfabb56 written 000000000bfabb56
>> [  499.267657] check 12: state 0xa01 read 000000000bfabb56 write
>> 000000000bfabb56 written 000000000bfabb56
>> [  499.267985] check 11: state 0x811 read 000000000bfabb56 write
>> 000000000bfabb56 written 000000000bfabb56
>> [  499.268349] check 10: state 0x811 read 000000000bfabb56 write
>> 000000000bfabb56 written 000000000bfabb56
>> [  499.268670] check 9: state 0x811 read 000000000bfabb56 write
>> 000000000bfabb56 written 000000000bfabb56
>> [  499.269021] check 8: state 0x811 read 000000000bfabb56 write
>> 000000000bfabb56 written 000000000bfabb56
>> [  499.269371] check 7: state 0xa01 read 000000000bfabb56 write
>> 000000000bfabb56 written 000000000bfabb56
>> [  499.269695] check 6: state 0xa01 read 000000000bfabb56 write
>> 000000000bfabb56 written 000000000bfabb56
>> [  499.270027] check 5: state 0xa01 read 000000000bfabb56 write
>> 000000000bfabb56 written 000000000bfabb56
>> [  499.270376] check 4: state 0xa01 read 000000000bfabb56 write
>> 000000000bfabb56 written 000000000bfabb56
>> [  499.270700] check 3: state 0x811 read 000000000bfabb56 write
>> 000000000bfabb56 written 000000000bfabb56
>> [  499.271031] check 2: state 0x811 read 000000000bfabb56 write
>> 000000000bfabb56 written 000000000bfabb56
>> [  499.271380] check 1: state 0x811 read 000000000bfabb56 write
>> 000000000bfabb56 written 000000000bfabb56
>> [  499.271707] check 0: state 0x813 read 000000000bfabb56 write
>> 000000000bfabb56 written 000000000bfabb56
>> [  499.272039] XX handle_stripe 4742, state 0x1401, reconstr 6
>> [  499.272410] XX handle_stripe 4746, state 0x1401, reconstr 6
>> [  499.272740] XX handle_stripe 4753, state 0x1401, reconstr 6
>> [  499.273093] XX handle_stripe 4765, state 0x1401, reconstr 6
>> [  499.273446] locked=2 uptodate=20 to_read=0 to_write=0 failed=10
>> failed_num=18,17
>> [  499.273786] XX too many failed
>> [  499.274174] XX handle_stripe 4834, state 0x1401, reconstr 0
>> [  499.274523] XX handle_stripe 4847, state 0x1401, reconstr 0
>> [  499.274877] XX handle_stripe 4874, state 0x1401, reconstr 0
>> [  499.275250] XX handle_stripe 4882, state 0x1401, reconstr 0
>> [  499.275591] XX handle_stripe 4893, state 0x1401, reconstr 0
>> [  499.275939] XX handle_stripe 4923, state 0x1401, reconstr 0
>> [  499.276324] XX handle_stripe 4939, state 0x1401, reconstr 0
>> [  499.276666] XX handle_stripe 4956, state 0x1401, reconstr 0
>> [  499.277033] XX handle_stripe 4965, state 0x1401, reconstr 0
>> [  499.277399] XX handle_stripe 4990, state 0x1401, reconstr 0
>> [  499.277742] XX handle_stripe 5019, state 0x1401, reconstr 0
>> [  499.278090] handle_stripe: 5026
>> [  499.278477] XX handle_stripe 5035, state 0x1401, reconstr 3
>> [  499.278831] XX handle_stripe 5040, state 0x1401, reconstr 3
>> [  499.279198] XX handle_stripe 5043, state 0x1401, reconstr 3
>> [  499.279547] XX handle_stripe 5057, state 0x1401, reconstr 3
>> [  499.279898] XX handle_stripe 5087, state 0x1401, reconstr 3
>> [ ... raid_run_ops() call with STRIPE_OP_RECONSTRUCT ... ]
>> [  499.280292] XX handle_stripe 5091, state 0x1403, reconstr 6
>> [  499.280645] XX handle_stripe 5094, state 0x1403, reconstr 6
> After this the stripe should be handled again, but I didn't find it in
> the dmesg file.
> Could you please retry with the extra debug information?

Yes, it was rate limited and I didn't wait long enough for the limiter 
to allow logging again.

I now dropped the rate limiting and instead logged the first 100 
handle_stripe() calls for that sector, so we now got 100 consecutive 
handle_stripe() calls for sector 198248960 in the log.

Below is a new excerpt, with full log at 
http://onse.fi/files/reshape-infloop-issue/dmesg-2.txt , source file 
http://onse.fi/files/reshape-infloop-issue/raid5-2.c .

>> [  499.281042] XX handle_stripe 5108, state now 0x1402
> 


[  274.866530] XX handle_stripe 4705, state 0x1402, reconstr 6, sector 
198248960
[  274.867060] XX handle_stripe 4714, state 0x1401, reconstr 6, sector 
198248960
[  274.867607] XX handle_stripe 4720, state 0x1401, reconstr 6, sector 
198248960
[  274.868132] XX handle_stripe 4724, state 0x1401, reconstr 6, sector 
198248960
[  274.868659] XX handle_stripe 4743, state 0x1401, reconstr 6, sector 
198248960
[  274.869189] handling stripe 198248960, state=0x1401 cnt=1, pd_idx=19, 
qd_idx=0
                , check:0, reconstruct:6
[  274.870281] check 19: state 0x813 read 00000000b79fab11 write 
00000000b79fab11 written 00000000b79fab11
[  274.870840] check 18: state 0xa01 read 00000000b79fab11 write 
00000000b79fab11 written 00000000b79fab11
[  274.871376] check 17: state 0xa01 read 00000000b79fab11 write 
00000000b79fab11 written 00000000b79fab11
[  274.871930] check 16: state 0xa01 read 00000000b79fab11 write 
00000000b79fab11 written 00000000b79fab11
[  274.872465] check 15: state 0x811 read 00000000b79fab11 write 
00000000b79fab11 written 00000000b79fab11
[  274.873042] check 14: state 0xa01 read 00000000b79fab11 write 
00000000b79fab11 written 00000000b79fab11
[  274.873596] check 13: state 0xa01 read 00000000b79fab11 write 
00000000b79fab11 written 00000000b79fab11
[  274.874132] check 12: state 0xa01 read 00000000b79fab11 write 
00000000b79fab11 written 00000000b79fab11
[  274.874677] check 11: state 0x811 read 00000000b79fab11 write 
00000000b79fab11 written 00000000b79fab11
[  274.875203] check 10: state 0x811 read 00000000b79fab11 write 
00000000b79fab11 written 00000000b79fab11
[  274.875747] check 9: state 0x811 read 00000000b79fab11 write 
00000000b79fab11 written 00000000b79fab11
[  274.876272] check 8: state 0x811 read 00000000b79fab11 write 
00000000b79fab11 written 00000000b79fab11
[  274.876818] check 7: state 0xa01 read 00000000b79fab11 write 
00000000b79fab11 written 00000000b79fab11
[  274.877344] check 6: state 0xa01 read 00000000b79fab11 write 
00000000b79fab11 written 00000000b79fab11
[  274.877869] check 5: state 0xa01 read 00000000b79fab11 write 
00000000b79fab11 written 00000000b79fab11
[  274.878398] check 4: state 0xa01 read 00000000b79fab11 write 
00000000b79fab11 written 00000000b79fab11
[  274.878939] check 3: state 0x811 read 00000000b79fab11 write 
00000000b79fab11 written 00000000b79fab11
[  274.879455] check 2: state 0x811 read 00000000b79fab11 write 
00000000b79fab11 written 00000000b79fab11
[  274.879997] check 1: state 0x811 read 00000000b79fab11 write 
00000000b79fab11 written 00000000b79fab11
[  274.880520] check 0: state 0x813 read 00000000b79fab11 write 
00000000b79fab11 written 00000000b79fab11
[  274.881029] XX handle_stripe 4753, state 0x1401, reconstr 6, sector 
198248960
[  274.881544] XX handle_stripe 4757, state 0x1401, reconstr 6, sector 
198248960
[  274.882063] XX handle_stripe 4764, state 0x1401, reconstr 6, sector 
198248960
[  274.882594] XX handle_stripe 4776, state 0x1401, reconstr 6, sector 
198248960
[  274.883109] locked=2 uptodate=20 to_read=0 to_write=0 failed=10 
failed_num=18,17
[  274.883649] XX too many failed
[  274.884168] XX handle_stripe 4845, state 0x1401, reconstr 0, sector 
198248960
[  274.884713] XX handle_stripe 4858, state 0x1401, reconstr 0, sector 
198248960
[  274.885236] XX handle_stripe 4885, state 0x1401, reconstr 0, sector 
198248960
[  274.885777] XX handle_stripe 4893, state 0x1401, reconstr 0, sector 
198248960
[  274.886304] XX handle_stripe 4904, state 0x1401, reconstr 0, sector 
198248960
[  274.886848] XX handle_stripe 4934, state 0x1401, reconstr 0, sector 
198248960
[  274.887370] XX handle_stripe 4950, state 0x1401, reconstr 0, sector 
198248960
[  274.887914] XX handle_stripe 4967, state 0x1401, reconstr 0, sector 
198248960
[  274.888435] XX handle_stripe 4976, state 0x1401, reconstr 0, sector 
198248960
[  274.888991] XX handle_stripe 5001, state 0x1401, reconstr 0, sector 
198248960
[  274.889522] XX handle_stripe 5034, state 0x1401, reconstr 0, sector 
198248960
[  274.890048] handle_stripe: 5041
[  274.890586] XX handle_stripe 5050, state 0x1401, reconstr 3, sector 
198248960
[  274.891111] XX handle_stripe 5055, state 0x1401, reconstr 3, sector 
198248960
[  274.891656] XX handle_stripe 5058, state 0x1401, reconstr 3, sector 
198248960
[  274.892180] XX handle_stripe 5072, state 0x1401, reconstr 3, sector 
198248960
[  274.892721] XX handle_stripe 5102, state 0x1401, reconstr 3, sector 
198248960
[  274.893250] XX handle_stripe 5106, state 0x1403, reconstr 6, sector 
198248960
[  274.893773] XX handle_stripe 5109, state 0x1403, reconstr 6, sector 
198248960
[  274.894347] XX handle_stripe 5123, state now 0x1402
[  274.894942] XX handle_stripe 4705, state 0x1402, reconstr 6, sector 
198248960
[  274.895459] XX handle_stripe 4714, state 0x1401, reconstr 6, sector 
198248960
[  274.896017] XX handle_stripe 4720, state 0x1401, reconstr 6, sector 
198248960
[  274.896531] XX handle_stripe 4724, state 0x1401, reconstr 6, sector 
198248960
[  274.897047] XX handle_stripe 4743, state 0x1401, reconstr 6, sector 
198248960
[  274.897584] handling stripe 198248960, state=0x1401 cnt=1, pd_idx=19, 
qd_idx=0
                , check:0, reconstruct:6
[  274.898621] check 19: state 0x813 read 00000000b79fab11 write 
00000000b79fab11 written 00000000b79fab11
[  274.899199] check 18: state 0xa01 read 00000000b79fab11 write 
00000000b79fab11 written 00000000b79fab11
[  274.899747] check 17: state 0xa01 read 00000000b79fab11 write 
00000000b79fab11 written 00000000b79fab11
[  274.900271] check 16: state 0xa01 read 00000000b79fab11 write 
00000000b79fab11 written 00000000b79fab11
[  274.900795] check 15: state 0x811 read 00000000b79fab11 write 
00000000b79fab11 written 00000000b79fab11
[  274.901317] check 14: state 0xa01 read 00000000b79fab11 write 
00000000b79fab11 written 00000000b79fab11
[  274.901865] check 13: state 0xa01 read 00000000b79fab11 write 
00000000b79fab11 written 00000000b79fab11
[  274.902402] check 12: state 0xa01 read 00000000b79fab11 write 
00000000b79fab11 written 00000000b79fab11
[  274.902943] check 11: state 0x811 read 00000000b79fab11 write 
00000000b79fab11 written 00000000b79fab11
[  274.903458] check 10: state 0x811 read 00000000b79fab11 write 
00000000b79fab11 written 00000000b79fab11
[  274.904017] check 9: state 0x811 read 00000000b79fab11 write 
00000000b79fab11 written 00000000b79fab11
[  274.904535] check 8: state 0x811 read 00000000b79fab11 write 
00000000b79fab11 written 00000000b79fab11
[  274.905051] check 7: state 0xa01 read 00000000b79fab11 write 
00000000b79fab11 written 00000000b79fab11
[  274.905587] check 6: state 0xa01 read 00000000b79fab11 write 
00000000b79fab11 written 00000000b79fab11
[  274.906118] check 5: state 0xa01 read 00000000b79fab11 write 
00000000b79fab11 written 00000000b79fab11
[  274.906654] check 4: state 0xa01 read 00000000b79fab11 write 
00000000b79fab11 written 00000000b79fab11
[  274.907166] check 3: state 0x811 read 00000000b79fab11 write 
00000000b79fab11 written 00000000b79fab11
[  274.907697] check 2: state 0x811 read 00000000b79fab11 write 
00000000b79fab11 written 00000000b79fab11
[  274.908203] check 1: state 0x811 read 00000000b79fab11 write 
00000000b79fab11 written 00000000b79fab11
[  274.908702] check 0: state 0x813 read 00000000b79fab11 write 
00000000b79fab11 written 00000000b79fab11
[  274.909202] XX handle_stripe 4753, state 0x1401, reconstr 6, sector 
198248960
[  274.909726] XX handle_stripe 4757, state 0x1401, reconstr 6, sector 
198248960
[  274.910242] XX handle_stripe 4764, state 0x1401, reconstr 6, sector 
198248960
[  274.910768] XX handle_stripe 4776, state 0x1401, reconstr 6, sector 
198248960
[  274.911271] locked=2 uptodate=20 to_read=0 to_write=0 failed=10 
failed_num=18,17
[  274.911801] XX too many failed
[  274.912311] XX handle_stripe 4845, state 0x1401, reconstr 0, sector 
198248960
[  274.912830] XX handle_stripe 4858, state 0x1401, reconstr 0, sector 
198248960
[  274.913348] XX handle_stripe 4885, state 0x1401, reconstr 0, sector 
198248960
[  274.913882] XX handle_stripe 4893, state 0x1401, reconstr 0, sector 
198248960
[  274.914405] XX handle_stripe 4904, state 0x1401, reconstr 0, sector 
198248960
[  274.914939] XX handle_stripe 4934, state 0x1401, reconstr 0, sector 
198248960
[  274.915451] XX handle_stripe 4950, state 0x1401, reconstr 0, sector 
198248960
[  274.915996] XX handle_stripe 4967, state 0x1401, reconstr 0, sector 
198248960
[  274.916497] XX handle_stripe 4976, state 0x1401, reconstr 0, sector 
198248960
[  274.917002] XX handle_stripe 5001, state 0x1401, reconstr 0, sector 
198248960
[  274.917535] XX handle_stripe 5034, state 0x1401, reconstr 0, sector 
198248960
[  274.918058] handle_stripe: 5041
[  274.918595] XX handle_stripe 5050, state 0x1401, reconstr 3, sector 
198248960
[  274.919111] XX handle_stripe 5055, state 0x1401, reconstr 3, sector 
198248960
[  274.919647] XX handle_stripe 5058, state 0x1401, reconstr 3, sector 
198248960
[  274.920161] XX handle_stripe 5072, state 0x1401, reconstr 3, sector 
198248960
[  274.920679] XX handle_stripe 5102, state 0x1401, reconstr 3, sector 
198248960
[  274.921205] XX handle_stripe 5106, state 0x1403, reconstr 6, sector 
198248960
[  274.921745] XX handle_stripe 5109, state 0x1403, reconstr 6, sector 
198248960
[  274.922302] XX handle_stripe 5123, state now 0x1402


-- 
Anssi Hannula

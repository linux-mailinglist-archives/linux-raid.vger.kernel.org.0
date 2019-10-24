Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69F55E3B55
	for <lists+linux-raid@lfdr.de>; Thu, 24 Oct 2019 20:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440168AbfJXSuW (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 24 Oct 2019 14:50:22 -0400
Received: from mail-qt1-f180.google.com ([209.85.160.180]:41151 "EHLO
        mail-qt1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406463AbfJXSuW (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 24 Oct 2019 14:50:22 -0400
Received: by mail-qt1-f180.google.com with SMTP id o3so132688qtj.8
        for <linux-raid@vger.kernel.org>; Thu, 24 Oct 2019 11:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fGmJ6+3M30GTGah8QzHEtw7fKcc6KcayXaNJmriQyFo=;
        b=ql/mpEZ5wbDVWoMplBq4SS0/3iJ1fdqHoTImc6lYArOv/8/Bt3S/2EgLkxAXLlOAUa
         zhpWseL86P0Gi3E/VBUaW964/QXA9bRe0ik4KunRipBbGRctZnieDm86Qgk8F7liroP/
         U8v7Ah+uwKp3OGRN5ZnGxwlA1N2QmaJ8SkBmpnqfJIspWukeIFPDNJJmVr84sgNA9wnm
         pvZ7shqUc+X6I2lWwy65Gt99kQ5veBTa/Y3yTH5gMKDbiNV3Gkd6S+j1HCnQIOEfRyCe
         qcBU2uEd00W5S6flY/pYOKZmDGPZ/9U/66k/UhSOQOQRxWcIItRd3S2Tr4WbmCKL/uMf
         oU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fGmJ6+3M30GTGah8QzHEtw7fKcc6KcayXaNJmriQyFo=;
        b=SZFVogHhQlsJZA8u9ubQnD8gv5/Mpl1G2fSA3HbvOr3j+B6Be2mmzS3KRHj6VrUGcd
         vQ1v7I3QNVpsNrvTmSGEFLEZxFnhB1TB6cDJlI8p2Ukk7KlcqIxrcMQx+Hyw2j+cB3n2
         4bybN3SGioVf1orZIeqsPEhinykw2gfOn3KrHnO7YGP/o8fRP6WYtzhDqRdqcbvUVQPE
         Wi9fqUKQif52ydihYVL3GmXqyyswwwAChr99rihduGtzGjwFlrycWe8Ij4YzVXcEOQhA
         cCSxUvlmv6McLBFBXkoLbxh1QEuMPy0B7cSnAVipMm13aIgvF3qKRz0A7nLQDakr1/DG
         QxcQ==
X-Gm-Message-State: APjAAAVP1kHtryLwFVJU89CWN9oF0Q1aK9RtQ4nYUGsVft/Bxrhdmmp9
        6EXXHndEoWGncLMnNJuunZqMWIMKc+dqeX4WMFgwyxJm
X-Google-Smtp-Source: APXvYqxC8Cv1/+OH0AF+FlLHliqujQkSsy2kHlk7eg9Fb5pQ/PXooXhEinm8jdS8RINvNz/b6sKo83JuAnKZaI1TJ9c=
X-Received: by 2002:a0c:fb0c:: with SMTP id c12mr2544724qvp.96.1571943020896;
 Thu, 24 Oct 2019 11:50:20 -0700 (PDT)
MIME-Version: 1.0
References: <25373b220163b01b8990aa049fec9d18@iki.fi>
In-Reply-To: <25373b220163b01b8990aa049fec9d18@iki.fi>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Thu, 24 Oct 2019 11:50:09 -0700
Message-ID: <CAPhsuW51S=tO+A0SDb1EvtoCG9pVSC91e9euG2nsp+rZiUgF7A@mail.gmail.com>
Subject: Re: RAID6 gets stuck during reshape with 100% CPU
To:     Anssi Hannula <anssi.hannula@iki.fi>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Sorry for delayed reply.

On Sat, Oct 19, 2019 at 2:10 AM Anssi Hannula <anssi.hannula@iki.fi> wrote:
>
> Hi all,
>
> I'm seeing a reshape issue where the array gets stuck with requests
> seemingly getting blocked and md0_raid6 process taking 100% CPU whenever
> I --continue the reshape.
>
>  From what I can tell, the md0_raid6 process is stuck processing a set of
> stripes over and over via handle_stripe() without progressing.
>
> Log excerpt of one handle_stripe() of an affected stripe with some extra
> logging is below.
> The 4600-5200 integers are line numbers for
> http://onse.fi/files/reshape-infloop-issue/raid5.c .

Maybe add sh->sector to DEBUGPRINT()?
Also, please add more DEBUGPRINT() in the

if (sh->reconstruct_state == reconstruct_state_result) {

case.

>
> 0x1401 = STRIPE_ACTIVE STRIPE_EXPANDING STRIPE_EXPAND_READY
> 0x1402 = STRIPE_HANDLE STRIPE_EXPANDING STRIPE_EXPAND_READY
>
> 0x813 = R5_UPTODATE R5_LOCKED R5_Insync R5_Expanded
> 0x811 = R5_UPTODATE R5_Insync R5_Expanded
> 0xa01 = R5_UPTODATE R5_ReadError R5_Expanded
>
> [  499.262769] XX handle_stripe 4694, state 0x1402, reconstr 6
> [  499.263376] XX handle_stripe 4703, state 0x1401, reconstr 6
> [  499.263681] XX handle_stripe 4709, state 0x1401, reconstr 6
> [  499.263988] XX handle_stripe 4713, state 0x1401, reconstr 6
> [  499.264355] XX handle_stripe 4732, state 0x1401, reconstr 6
> [  499.264657] handling stripe 198248960, state=0x1401 cnt=1, pd_idx=19,
> qd_idx=0
>                 , check:0, reconstruct:6
> [  499.265304] check 19: state 0x813 read 000000000bfabb56 write
> 000000000bfabb56 written 000000000bfabb56
> [  499.265649] check 18: state 0xa01 read 000000000bfabb56 write
> 000000000bfabb56 written 000000000bfabb56
> [  499.265978] check 17: state 0xa01 read 000000000bfabb56 write
> 000000000bfabb56 written 000000000bfabb56
> [  499.266337] check 16: state 0xa01 read 000000000bfabb56 write
> 000000000bfabb56 written 000000000bfabb56
> [  499.266658] check 15: state 0x811 read 000000000bfabb56 write
> 000000000bfabb56 written 000000000bfabb56
> [  499.266988] check 14: state 0xa01 read 000000000bfabb56 write
> 000000000bfabb56 written 000000000bfabb56
> [  499.267335] check 13: state 0xa01 read 000000000bfabb56 write
> 000000000bfabb56 written 000000000bfabb56
> [  499.267657] check 12: state 0xa01 read 000000000bfabb56 write
> 000000000bfabb56 written 000000000bfabb56
> [  499.267985] check 11: state 0x811 read 000000000bfabb56 write
> 000000000bfabb56 written 000000000bfabb56
> [  499.268349] check 10: state 0x811 read 000000000bfabb56 write
> 000000000bfabb56 written 000000000bfabb56
> [  499.268670] check 9: state 0x811 read 000000000bfabb56 write
> 000000000bfabb56 written 000000000bfabb56
> [  499.269021] check 8: state 0x811 read 000000000bfabb56 write
> 000000000bfabb56 written 000000000bfabb56
> [  499.269371] check 7: state 0xa01 read 000000000bfabb56 write
> 000000000bfabb56 written 000000000bfabb56
> [  499.269695] check 6: state 0xa01 read 000000000bfabb56 write
> 000000000bfabb56 written 000000000bfabb56
> [  499.270027] check 5: state 0xa01 read 000000000bfabb56 write
> 000000000bfabb56 written 000000000bfabb56
> [  499.270376] check 4: state 0xa01 read 000000000bfabb56 write
> 000000000bfabb56 written 000000000bfabb56
> [  499.270700] check 3: state 0x811 read 000000000bfabb56 write
> 000000000bfabb56 written 000000000bfabb56
> [  499.271031] check 2: state 0x811 read 000000000bfabb56 write
> 000000000bfabb56 written 000000000bfabb56
> [  499.271380] check 1: state 0x811 read 000000000bfabb56 write
> 000000000bfabb56 written 000000000bfabb56
> [  499.271707] check 0: state 0x813 read 000000000bfabb56 write
> 000000000bfabb56 written 000000000bfabb56
> [  499.272039] XX handle_stripe 4742, state 0x1401, reconstr 6
> [  499.272410] XX handle_stripe 4746, state 0x1401, reconstr 6
> [  499.272740] XX handle_stripe 4753, state 0x1401, reconstr 6
> [  499.273093] XX handle_stripe 4765, state 0x1401, reconstr 6
> [  499.273446] locked=2 uptodate=20 to_read=0 to_write=0 failed=10
> failed_num=18,17
> [  499.273786] XX too many failed
> [  499.274174] XX handle_stripe 4834, state 0x1401, reconstr 0
> [  499.274523] XX handle_stripe 4847, state 0x1401, reconstr 0
> [  499.274877] XX handle_stripe 4874, state 0x1401, reconstr 0
> [  499.275250] XX handle_stripe 4882, state 0x1401, reconstr 0
> [  499.275591] XX handle_stripe 4893, state 0x1401, reconstr 0
> [  499.275939] XX handle_stripe 4923, state 0x1401, reconstr 0
> [  499.276324] XX handle_stripe 4939, state 0x1401, reconstr 0
> [  499.276666] XX handle_stripe 4956, state 0x1401, reconstr 0
> [  499.277033] XX handle_stripe 4965, state 0x1401, reconstr 0
> [  499.277399] XX handle_stripe 4990, state 0x1401, reconstr 0
> [  499.277742] XX handle_stripe 5019, state 0x1401, reconstr 0
> [  499.278090] handle_stripe: 5026
> [  499.278477] XX handle_stripe 5035, state 0x1401, reconstr 3
> [  499.278831] XX handle_stripe 5040, state 0x1401, reconstr 3
> [  499.279198] XX handle_stripe 5043, state 0x1401, reconstr 3
> [  499.279547] XX handle_stripe 5057, state 0x1401, reconstr 3
> [  499.279898] XX handle_stripe 5087, state 0x1401, reconstr 3
> [ ... raid_run_ops() call with STRIPE_OP_RECONSTRUCT ... ]
> [  499.280292] XX handle_stripe 5091, state 0x1403, reconstr 6
> [  499.280645] XX handle_stripe 5094, state 0x1403, reconstr 6
After this the stripe should be handled again, but I didn't find it in
the dmesg file.
Could you please retry with the extra debug information?

> [  499.281042] XX handle_stripe 5108, state now 0x1402


[...]

> - The array was originally 74230862272 kB long (21 devices of size
> 3906887488 kB). My intention was to have it end up with 20 slightly
> larger members but the same total size, so I used --grow
> --size=4124036736 to increase the device size slightly, and then
> --array-size=74230862272K to reduce the available size back to original
> before starting the reshape. Note that the --array-size I used is
> smaller than the "actual" size after the reshape (74232661248 kB), in
> case it matters.

That's an impressive array, btw.

Thanks,
Song

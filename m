Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CADE5EA344
	for <lists+linux-raid@lfdr.de>; Wed, 30 Oct 2019 19:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfJ3SZf (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 30 Oct 2019 14:25:35 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33540 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbfJ3SZf (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 30 Oct 2019 14:25:35 -0400
Received: by mail-lf1-f66.google.com with SMTP id y127so2354324lfc.0
        for <linux-raid@vger.kernel.org>; Wed, 30 Oct 2019 11:25:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date:from
         :to:cc:subject:in-reply-to:references:user-agent:message-id;
        bh=iKrOPZaQFQ3NBW+RUhUP0kgQfPiu0TcsP7Oh1KDw3p8=;
        b=QuaByFzQD2NVs8y+ha1g80xdwYsA/aKD9OZOyLkcpUSFNTI31ubaloBagY5PV2thAz
         iqM0+u+ELZ8a0nmlAUPPQGT/LS/Jz41U8RcQKjtRyNrprlT9uRtjssqrtZgvhAzY7mPy
         +KLj4HjYg8RQuY3+dyAXB1GcX7SZ+I/ZVDktudcyLyBV1jFnMWGjZmGxN2k/jDQ82+Ei
         09Q9iMKmdh+4rodB5MjHjWfNfRzDW68tglljHCsJqA49XXFEnAkYjn4Pk1UYA1JwFo1S
         PaWS2BV/FZe+baw79/AOr+KcrlC9Xm5kiR4K53d3oWWjuaPyNFAVGZSkuIIVisZBaiSe
         /9XA==
X-Gm-Message-State: APjAAAXOFIBkoG+bwkYgS2uqmdJmkl0rupsrbMMAenErgWQ4Q0Q1NRMB
        8LJJN6GXb9FR+kH4jY/EsSw=
X-Google-Smtp-Source: APXvYqxPC1u5VWPn3frAWsumoiS8SXHSwFaPcx/DbAOS4JQYVsmidCh2LAcIq24r8WRLgqHMKn3NMw==
X-Received: by 2002:a19:6f0e:: with SMTP id k14mr371966lfc.34.1572459933647;
        Wed, 30 Oct 2019 11:25:33 -0700 (PDT)
Received: from mail.onse.fi ([109.204.156.230])
        by smtp.gmail.com with ESMTPSA id o18sm374958ljj.27.2019.10.30.11.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 11:25:32 -0700 (PDT)
Received: from mail.onse.fi (delta.onse.fi [127.0.0.1])
        by mail.onse.fi (Postfix) with ESMTP id 8314B4074C;
        Wed, 30 Oct 2019 20:25:31 +0200 (EET)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 30 Oct 2019 20:25:31 +0200
From:   Anssi Hannula <anssi.hannula@iki.fi>
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>
Subject: Re: RAID6 gets stuck during reshape with 100% CPU
In-Reply-To: <CAPhsuW6HsL2GS+G5cYfjhjiZi4ZGsSj60ov=YgQUngbNkt9bPw@mail.gmail.com>
References: <25373b220163b01b8990aa049fec9d18@iki.fi>
 <CAPhsuW51S=tO+A0SDb1EvtoCG9pVSC91e9euG2nsp+rZiUgF7A@mail.gmail.com>
 <f1de00a04761370d90018f288b9b2996@iki.fi>
 <CAPhsuW4pddLHge+tkz2pvsPv9xgXi=WvVH3ck5KTF7EkNgE2iA@mail.gmail.com>
 <2054f286c123d9b9bcc66faf0d6f7d10@iki.fi>
 <CAPhsuW68wmVQ6eH3o_eE+BkDXSfWHy7kEcsMj04uEzAGigbwkg@mail.gmail.com>
 <0d3573affc5c44ff169120f8667f5780@iki.fi>
 <CAPhsuW5hj6-BOwifzQ5DRBaAWTCazgNF8oS3MtFf=4r-ioBaRw@mail.gmail.com>
 <2952af29aba2680d5c6d17b9351bc15d@iki.fi>
 <CAPhsuW6HsL2GS+G5cYfjhjiZi4ZGsSj60ov=YgQUngbNkt9bPw@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4-rc2
Message-ID: <c8b37bc022aca270102fe7114be7051e@iki.fi>
X-Sender: anssi.hannula@iki.fi
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Song Liu kirjoitti 2019-10-29 23:55:
> On Tue, Oct 29, 2019 at 1:45 PM Anssi Hannula <anssi.hannula@iki.fi> 
> wrote:
>> 
>> Song Liu kirjoitti 2019-10-29 22:28:
>> > On Tue, Oct 29, 2019 at 12:05 PM Anssi Hannula <anssi.hannula@iki.fi>
>> > wrote:
>> >>
>> >> Song Liu kirjoitti 2019-10-29 08:04:
>> >> > I guess we get into "is_bad", case, but it should not be the case?
>> >>
>> >> Right, is_bad is set, which causes R5_Insync and R5_ReadError to be
>> >> set
>> >> on lines 4497-4498, and R5_Insync to be cleared on line 4554 (if
>> >> R5_ReadError then clear R5_Insync).
>> >>
>> >> As mentioned in my first message and seen in
>> >> http://onse.fi/files/reshape-infloop-issue/examine-all.txt , the MD
>> >> bad
>> >> block lists contain blocks (suspiciously identical across devices).
>> >> So maybe the code can't properly handle the case where 10 devices have
>> >> the same block in their bad block list. Not quite sure what "handle"
>> >> should mean in this case but certainly something else than a
>> >> handle_stripe() loop :)
>> >> There is a "bad" block on 10 devices on sector 198504960, which I
>> >> guess
>> >> matches sh->sector 198248960 due to data offset of 256000 sectors (per
>> >> --examine).
>> >
>> > OK, it makes sense now. I didn't add the data offset when checking the
>> > bad
>> > block data.
>> >
>> >>
>> >> I've wondered if "dd if=/dev/md0 of=/dev/md0" for the affected blocks
>> >> would clear the bad blocks and avoid this issue, but I haven't tried
>> >> that yet so that the infinite loop issue can be investigated/fixed
>> >> first. I already checked that /dev/md0 is fully readable (which also
>> >> confuses me a bit since md(8) says "Attempting to read from a known
>> >> bad
>> >> block will cause a read error"... maybe I'm missing something).
>> >>
>> >
>> > Maybe try these steps?
>> >
>> > https://raid.wiki.kernel.org/index.php/The_Badblocks_controversy#How_do_I_fix_a_Bad_Blocks_problem.3F
>> 
>> Yeah, I guess those steps would probably resolve my situation. BTW,
>> "--update=force-no-bbl" is not mentioned on mdadm(8), is it on 
>> purpose?
>> I was trying to find such an option earlier.
>> 
>> If you don't need anything more from the array, I'll go ahead and try
>> clearing the seemingly bogus bad block lists.
> 
> Please go ahead. We already got quite a few logs.

Seems that was indeed the issue, clearing the bad block log allowed the 
reshape to continue normally.

Thanks for your help.

-- 
Anssi Hannula

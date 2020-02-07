Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6A0155BBC
	for <lists+linux-raid@lfdr.de>; Fri,  7 Feb 2020 17:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgBGQ1Q (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 7 Feb 2020 11:27:16 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:44258 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbgBGQ1Q (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 7 Feb 2020 11:27:16 -0500
Received: by mail-ot1-f53.google.com with SMTP id h9so2652267otj.11
        for <linux-raid@vger.kernel.org>; Fri, 07 Feb 2020 08:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GEcY3KvzS+WG0yk3v+XyHMKmixUarR+K0SP1Mwc53Rg=;
        b=CHNhYvje3+EXe5ukpIvspgq0aOqQK8TeOaQeBKiwCHaVCyjyS80MAwwzKFD+j7v8ox
         J1G3h9JtiXdCKo+LeK6ky7c4omkIEayZzqF9o/rbETEGVyvjbqVaH9WOnul8+N6l2tWA
         vFaG2KGkfSkIfzcNxxRs86Ms7lb0qoVrWbt9CBESLspUc1sCS/eVpYSoKiX7eKNzR3Bv
         dKV13m8gzD9XyRzBK711QffJq+sGa6EUBfMjmERYlnA+fx+vZymIP4iIpiHXjZRJuciH
         etedafPWgRsLbgDeFe29T582i7YfJI1Za1K07xN5EmP1/TSuYMZWRiAOm7MBLVHzuWIp
         jxog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GEcY3KvzS+WG0yk3v+XyHMKmixUarR+K0SP1Mwc53Rg=;
        b=NqJ/Q5kQxQZ62/Zgh3ix5Nfjw0AiA/pjDVZfs4KQSu3s995D37QWGiLzN+n5SMHwgK
         d5ujbT1ejwk81lUrrfU2YyRwWd/Xf+JKqAlB2DKy5vdNBZlVIZDRB/5OF1Lq6brOqH5f
         Es3RzigAeBV0Vplwn0uyh3/jGKQjIDzjom9op9hv9r1w63n1STJFGbOgsNFnaHVimdMB
         ylXroZCDZu6WoUJ8DOk6aspkXjznHkesuVnvngfyoRDFGwDiRPsoBp5nGvfeaJckUo14
         Fstys4YAZSrlOkYW73p8ZZYtaLoHvmQJnyRcBAv2D0GrfdyU2H3JwrznUQitqAjMa7tD
         Jddg==
X-Gm-Message-State: APjAAAUIjW3dQdRHqNBiKdYr3VjUTdOp/Dm21UhihgKt0BFlRo6RbmE6
        jeFm4j/DJl1hiq1z+HjzbPB/RbuZr4igpQkrlo+Y48t0
X-Google-Smtp-Source: APXvYqyBfb85TGfzxx7KKdlwVLOsFmZLv/0G1PdILRv3e3qng0tD3YeFN3KHTkY0ysdnzVomQ8skSzpFKlnfIq7029E=
X-Received: by 2002:a9d:6544:: with SMTP id q4mr111651otl.269.1581092835524;
 Fri, 07 Feb 2020 08:27:15 -0800 (PST)
MIME-Version: 1.0
References: <CAPpdf5-FJ0cP36pOLm40ESBOws8x5R6XbUOssFFCsY6xtb4_xw@mail.gmail.com>
 <b75c2dc2-d14e-39dc-0c06-7bab53fa7cb8@thelounge.net>
In-Reply-To: <b75c2dc2-d14e-39dc-0c06-7bab53fa7cb8@thelounge.net>
From:   o1bigtenor <o1bigtenor@gmail.com>
Date:   Fri, 7 Feb 2020 10:26:39 -0600
Message-ID: <CAPpdf5882kxxkK2YrEmWWcM2X=ffcV+YB-GFTck2Qi34ufWE2g@mail.gmail.com>
Subject: Re: Question
To:     Reindl Harald <h.reindl@thelounge.net>
Cc:     Linux-RAID <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Fri, Feb 7, 2020 at 9:53 AM Reindl Harald <h.reindl@thelounge.net> wrote:
>
>
>
> Am 07.02.20 um 16:49 schrieb o1bigtenor:
> > Running a Raid-10 array made up of 4 - 1 TB drives on a debian testing
> > (11) system.
> > mdadm - v4.1 - 2018-10-01 is the version being used.
> >
> > Some weirdness is happening - - - vis a vis - - - I have one directory
> > (not small) that has disappeared. I last accessed said directory
> > (still have the pdf open which is how I could get this information)
> > 'Last accessed 2020-01-19 6:32 A.M.'  as indicated in the 'Properties'
> > section of the file in question.
> >
> > Has been suggested to me that I make the array read only until this is resolved.
> > I have space on the the array on a different system to recover this array.
> > Suggestions on how to do both of the above would be aprreciated
>
> directories on a filesystem on top of a RAID don't disappear silently -
> my bet is a simple drag&drop move or deletion aka PEBCAK

I checked with bash - - history  and in about 500 items there is no mention of
such. Looked in log files and can't find anything either. Quite
puzzling - - - -
that's why I'm asking here.

And yes - - - I am aware that all too often I'm the problem. I've
gotten a lot more
careful that I was even 5 years ago - - - grin.

Thanks

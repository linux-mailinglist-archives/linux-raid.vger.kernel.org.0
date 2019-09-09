Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE8A2ADB95
	for <lists+linux-raid@lfdr.de>; Mon,  9 Sep 2019 16:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731919AbfIIO6F (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 9 Sep 2019 10:58:05 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44566 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbfIIO6F (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 9 Sep 2019 10:58:05 -0400
Received: by mail-qk1-f193.google.com with SMTP id i78so13320150qke.11
        for <linux-raid@vger.kernel.org>; Mon, 09 Sep 2019 07:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qyr5+VUxUEqcSi315Qd8nKtof0gOdbl6J2rvDVRcwI4=;
        b=W4Q0SNVZHsuqM5QrjA0Kj3vZGHBBcjAa83IXlpo9bEkjG0Ngyz4o5/Q3Iu5Ms/ugT4
         g7So5f7iRZ2SE+4MhWEC5+yWFMzDjgVSRmtJShgElXwcuY1GWRmRqJnTkztsh7uYvz1y
         0G3y2FGj9DX/Cq0Mi925XaCxneOg2ZWXjMMZs8nhgTOO5YcjR7xUkT2zR69W5PAnJkwJ
         BOLl8INzrZArNuEpTZjJkDqRE59gktgwsoMSzRyeIlJYKpPZYYKXx+XlCIi4WvRXKvXp
         kJU1g1EvZ+5ybuBjrILi9VcGdaEfXkLMWHwwHZ33NVkRaUDJ9R9Vg4ftEf9KdUDT6wm+
         L39g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qyr5+VUxUEqcSi315Qd8nKtof0gOdbl6J2rvDVRcwI4=;
        b=W2x+/bs/5Z6pcW/l9wb6bu0nkbZCrFHicEjf2InYK8UcEH2rIo/2rPEDMpQyGcUTdi
         p9k3UhUbTQadapwy/4mSzIRueBCot+4tY026hs+WJIZ5gacoV91nqKGPrD5RQ9icYXfP
         XDrsz6XkbxEPcSkdTbxHTlzero4WrdrthZplNerO7iqC4SWPMlUKvvppPfjZMmcOQSzD
         bO/2d8hWyMi9mso9j9I5nsKv5nMyPLtfkTpFst3YI0dtpgmq+DQsKpDLOBni77joOA1M
         N+CEWRgDp4N9FzBAM3bJZlj9j3FXg7K9UrlQqSWsf9/SxgdwbZUXkunhnsUC9bu3hVyx
         v+cw==
X-Gm-Message-State: APjAAAVKAK0sbxvZSkHuV3OPnj7p4s+OLfIAiExDju6cyA2aNlUpyvan
        2xWoYw3pxCNlSa39VPevVSWBnzfdOEMhFUzA66DJGtKx
X-Google-Smtp-Source: APXvYqzdEumqvPFogiCKMiIdEvL+vm0sbIiI8dMdQuUlpfz38zdOg93Al01ILz688nrupzhGTXrgA5al/iKESxtYCKM=
X-Received: by 2002:a05:620a:166b:: with SMTP id d11mr23976851qko.437.1568041083014;
 Mon, 09 Sep 2019 07:58:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190906132133.22771-1-ncroxon@redhat.com>
In-Reply-To: <20190906132133.22771-1-ncroxon@redhat.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Mon, 9 Sep 2019 15:57:52 +0100
Message-ID: <CAPhsuW6m8zpzRHHn0pFXNXuC3vuOmRs_We0fvCM24R1nZfTzDw@mail.gmail.com>
Subject: Re: [PATCH] raid5: don't increment read_errors on EILSEQ return
To:     Nigel Croxon <ncroxon@redhat.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>, neilb@suse.de,
        Xiao Ni <xni@redhat.com>, Mikulas Patocka <mpatocka@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Fri, Sep 6, 2019 at 7:47 PM Nigel Croxon <ncroxon@redhat.com> wrote:
>
> While MD continues to count read errors returned by the lower layer.
> If those errors are -EILSEQ, instead of -EIO, it should NOT increase
> the read_errors count.
>
> When RAID6 is set up on dm-integrity target that detects massive
> corruption, the leg will be ejected from the array.  Even if the
> issue is correctable with a sector re-write and the array has
> necessary redundancy to correct it.
>
> The leg is ejected because it runs up the rdev->read_errors beyond
> conf->max_nr_stripes.  The return status in dm-drypt when there is
> a data integrity error is -EILSEQ (BLK_STS_PROTECTION).
>
> Signed-off-by: Nigel Croxon <ncroxon@redhat.com>

Applied. Thanks for the patch!

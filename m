Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 798E610F200
	for <lists+linux-raid@lfdr.de>; Mon,  2 Dec 2019 22:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbfLBVRW (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 2 Dec 2019 16:17:22 -0500
Received: from sender11-op-o12.zoho.eu ([185.20.211.226]:17491 "EHLO
        sender11-op-o12.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbfLBVRW (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 2 Dec 2019 16:17:22 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1575321439; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=H9PSFFE5/2V1wsEdv7Y8zyLOmWbhRJcwc1RQItM966oKspK1SI1kbthG8kvH+2FlZWdOkGo3ZFZ9okPBQX12JpAaNvYFoe2QNUs9h5Zqjcunw05DwYkMnc43i7r8tKhFYx7Hqqb2g0KCo6MC/NPrAdJqxoPlZaSSbs+m7N4ZE1k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1575321439; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=M0BCYny8a2mxD/xv3ZiHHDzMtqaBA6gUbBcCt/vJ+Z0=; 
        b=WQiRXE4HsQT2gL6UM0CKavUtWPkHABmrhDEF7flB0sy3PPjIrguyqOgfoCMeU32JQFSQrDfPtkdznabtYOmlz/ls4imwJPsSV7a2+4hY4gl7urqIR1RDkJCKlJpj6+1CWhMsyt5iZgG8H76OljlKIH9ctcGRmC8s2ZH+LBtNUGQ=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        dkim=pass  header.i=trained-monkey.org;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org> header.from=<jes@trained-monkey.org>
Received: from [172.30.221.108] (163.114.130.128 [163.114.130.128]) by mx.zoho.eu
        with SMTPS id 1575321438842799.3507653166175; Mon, 2 Dec 2019 22:17:18 +0100 (CET)
Subject: Re: [PATCH 2/2] Assemble: add support for RAID0 layouts.
To:     NeilBrown <neilb@suse.de>
Cc:     linux-raid@vger.kernel.org,
        dann frazier <dann.frazier@canonical.com>,
        Song Liu <liu.song.a23@gmail.com>
References: <157283799101.17723.14738560497847478383.stgit@noble.brown>
 <157247951643.8013.12020039865359474811.stgit@noble.brown>
 <157283806997.17723.7291225373208105610.stgit@noble.brown>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <bd91f3c9-25d8-9bdd-7443-9db742939682@trained-monkey.org>
Date:   Mon, 2 Dec 2019 16:17:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <157283806997.17723.7291225373208105610.stgit@noble.brown>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 11/3/19 10:27 PM, NeilBrown wrote:
> If you have a RAID0 array with varying sized devices
> on a kernel before 5.4, you cannot assembling it on
> 5.4 or later without explicitly setting the layout.
> This is now possible with
>    --update=layout-original (For 3.13 and earlier kernels)
> or
>    --update=layout-alternate (for 3.14 and later kernels)
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>   Assemble.c |    8 ++++++++
>   md.4       |    7 +++++++
>   mdadm.8.in |   17 +++++++++++++++++
>   mdadm.c    |    4 ++++
>   super1.c   |   12 +++++++++++-
>   5 files changed, 47 insertions(+), 1 deletion(-)
> 

Applied!

Thanks,
Jes




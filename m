Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFB361F7A22
	for <lists+linux-raid@lfdr.de>; Fri, 12 Jun 2020 16:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgFLOvA (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 12 Jun 2020 10:51:00 -0400
Received: from sender11-op-o12.zoho.eu ([31.186.226.226]:17442 "EHLO
        sender11-op-o12.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgFLOu7 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 12 Jun 2020 10:50:59 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1591973448; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=Cc9NLdmQZ1isuZEjhTjhurDzx6LOVP2/z6eiZdfNuvYlcv46MGDdooJBESFcmqq0plQhZxoEiORu2ThM10d5GvqC1k48Sd23suqKtkXp/2ckMPQGZDJ/d6MckNaKSiUpWP1DDn0GA33/W7OEQ6w3Z1UBEWT4068WH5E/LhLrMNA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1591973448; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=i6MHMjUDePhsAvjWCAgkRempzDyDv3efrC1AP1wtTkM=; 
        b=edOSI/O5Pf4zGFOBRm1VFyYTZforoS07jMzfHSh87dhb6DMc/kaJ151+pR2KOpt2iwsooJjWifHGUbcpYzm54ixsPMiOGGyG+7zZzmac+X9TQLf5CP2ckow/EX7Zyf8X4j4a+cQotHGOccJqQ7uPSYiCdBg01lKgKuXQ/+2GRCA=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org> header.from=<jes@trained-monkey.org>
Received: from [100.109.165.210] (163.114.130.7 [163.114.130.7]) by mx.zoho.eu
        with SMTPS id 1591973446394751.6318987632438; Fri, 12 Jun 2020 16:50:46 +0200 (CEST)
Subject: Re: [PATCH v2] Use more secure HTTPS URLs
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Mariusz Tkaczyk <mariusz.tkaczyk@intel.com>
Cc:     linux-raid@vger.kernel.org
References: <20200528145224.19062-1-pmenzel@molgen.mpg.de>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <575ffb80-8a26-8b03-4036-4f1b5bc91649@trained-monkey.org>
Date:   Fri, 12 Jun 2020 10:50:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200528145224.19062-1-pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 5/28/20 10:52 AM, Paul Menzel wrote:
> All URLs in the source are available over HTTPS, so convert all URLs to
> HTTPS with the command below.
> 
>     git grep -l 'http://' | xargs sed -i 's,http://,https://,g'
> 
> Revert the changes to announcement files `ANNOUNCE-*` as requested by
> the maintainer.
> 
> Cc: linux-raid@vger.kernel.org
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
>  external-reshape-design.txt      | 2 +-
>  mdadm.8.in                       | 6 +++---
>  mdadm.spec                       | 4 ++--
>  raid6check.8                     | 2 +-
>  restripe.c                       | 2 +-
>  udev-md-raid-safe-timeouts.rules | 2 +-
>  6 files changed, 9 insertions(+), 9 deletions(-)
I applied this and then applied a follow-on patch to fix the Intel link
to the one Mariusz provided.

Thanks,
Jes


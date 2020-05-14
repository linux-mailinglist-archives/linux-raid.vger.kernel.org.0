Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E184A1D32AD
	for <lists+linux-raid@lfdr.de>; Thu, 14 May 2020 16:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgENOYP (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 14 May 2020 10:24:15 -0400
Received: from sender11-op-o11.zoho.eu ([31.186.226.225]:17194 "EHLO
        sender11-op-o11.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgENOYP (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 14 May 2020 10:24:15 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589466250; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=XiCXJOrbZhIQRtxWIjS1OWZztGHKZn9nUB5Qv6FUZlmOKUJqbGQW6i0z5cYk668sXM/EHw6sQNy6yDKOoPButgbf3rGLrP5QMM+cqikjwh8M6LgtDK2Pj/ve0ERHrxwTolwYdNx8b9AdOstrceT6rrUBciCnr2+9RhDEgZ6eCC8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1589466250; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=Uoq44DGEM42E68ro2hBzS8qtl00gaoawCy1MF46fS00=; 
        b=ONwc18ZYwcrgB/Hane3ZgYVVPzg10rJGGT9LX9fko2z77VTIaPeJWLwUOoa7zZAnQyHzqqIyYH3MqK+rU5BYaGwC8xKHexL2EeDnrff/jz9apKkmhl+r4wiHPkIcksl2WTDWp/BCpVSUeQqyCnfUmC+tBcEPvO/aRDXS4XMpgQo=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org> header.from=<jes@trained-monkey.org>
Received: from [100.109.129.242] (163.114.130.1 [163.114.130.1]) by mx.zoho.eu
        with SMTPS id 158946624645454.47385201042732; Thu, 14 May 2020 16:24:06 +0200 (CEST)
Subject: Re: [PATCH] Makefile: add LABEL support
To:     Tkaczyk Mariusz <mariusz.tkaczyk@intel.com>
Cc:     linux-raid@vger.kernel.org
References: <20200513110036.19724-1-mariusz.tkaczyk@intel.com>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <a474fdee-5781-3f92-d996-e34697c92884@trained-monkey.org>
Date:   Thu, 14 May 2020 10:24:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200513110036.19724-1-mariusz.tkaczyk@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 5/13/20 7:00 AM, Tkaczyk Mariusz wrote:
> Add optional LABEL parameter to Makefile and allow to mark version
> by user friendly label. It might be useful when creating custom
> spins of mdadm, or labeling some instance in between major releases.
> 
> Signed-off-by: Tkaczyk Mariusz <mariusz.tkaczyk@intel.com>
> ---
>  Makefile | 3 ++-
>  ReadMe.c | 5 ++++-
>  2 files changed, 6 insertions(+), 2 deletions(-)

I am not against this, but could we name it EXTRAVERSION to match what
the kernel does?

Cheers,
Jes

> diff --git a/Makefile b/Makefile
> index a33319a8..9c129c54 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -105,7 +105,8 @@ VERSION = $(shell [ -d .git ] && git describe HEAD | sed 's/mdadm-//')
>  VERS_DATE = $(shell [ -d .git ] && date --iso-8601 --date="`git log -n1 --format=format:%cd --date=iso --date=short`")
>  DVERS = $(if $(VERSION),-DVERSION=\"$(VERSION)\",)
>  DDATE = $(if $(VERS_DATE),-DVERS_DATE="\"$(VERS_DATE)\"",)
> -CFLAGS += $(DVERS) $(DDATE)
> +DLABEL = $(if $(LABEL),-DLABEL="\" - $(LABEL)\"",)
> +CFLAGS += $(DVERS) $(DDATE) $(DLABEL)
>  
>  # The glibc TLS ABI requires applications that call clone(2) to set up
>  # TLS data structures, use pthreads until mdmon implements this support
> diff --git a/ReadMe.c b/ReadMe.c
> index eaf10423..883136df 100644
> --- a/ReadMe.c
> +++ b/ReadMe.c
> @@ -33,7 +33,10 @@
>  #ifndef VERS_DATE
>  #define VERS_DATE "2018-10-01"
>  #endif
> -char Version[] = "mdadm - v" VERSION " - " VERS_DATE "\n";
> +#ifndef LABEL
> +#define LABEL ""
> +#endif
> +char Version[] = "mdadm - v" VERSION " - " VERS_DATE LABEL "\n";
>  
>  /*
>   * File: ReadMe.c
> 


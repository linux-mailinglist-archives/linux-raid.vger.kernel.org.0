Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2C01EFC57
	for <lists+linux-raid@lfdr.de>; Fri,  5 Jun 2020 17:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgFEPRg (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 5 Jun 2020 11:17:36 -0400
Received: from sender11-op-o11.zoho.eu ([31.186.226.225]:17105 "EHLO
        sender11-op-o11.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbgFEPRg (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 5 Jun 2020 11:17:36 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1591370240; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=hACHNCXwG7TdCK62bdvbzKpfA1x5KoNMriQ5KJtArHVeZswKn9ULFtGfPhoId+16pJALs9Eov9uRsX9j9vus98luDk3asIz75TzxPSlnCtSMgRSJxoqkfjAPQI9lE0lmt2Axm3SAEB9WnYpsyZ544O5Sp99mlGliNybGa37gM4c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1591370240; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=8KyiCuixe0Xf7ybxOQZiaBiTxDbBi40CyyLN0Dp8T1s=; 
        b=QS9upEo3NYKV1z7a56nI3eo2jsPhXrzXlyvEaVl6lna0tm9+p2Mh6DKSa8ajQ1sLsm5dC0tLHbRB90jkf1nz5P3jTUf2zMHSTongS7B5KSIlXM8yg+WsBfYjHFFDf/4w+yFEPoAlyjTt4OIYfWP5CzsLek9Brr3UXD1p+n7mElU=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org> header.from=<jes@trained-monkey.org>
Received: from [100.108.78.247] (163.114.132.6 [163.114.132.6]) by mx.zoho.eu
        with SMTPS id 1591370238237277.13898413386187; Fri, 5 Jun 2020 17:17:18 +0200 (CEST)
Subject: Re: [PATCH v2] Use more secure HTTPS URLs
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Mariusz Tkaczyk <mariusz.tkaczyk@intel.com>
Cc:     linux-raid@vger.kernel.org,
        Pawel Baldysiak <pawel.baldysiak@intel.com>,
        Kinga Tanska <kinga.tanska@intel.com>
References: <20200528145224.19062-1-pmenzel@molgen.mpg.de>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <8b02033d-7570-e654-dc18-a96f0a71d00c@trained-monkey.org>
Date:   Fri, 5 Jun 2020 11:17:15 -0400
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
> 
> diff --git a/external-reshape-design.txt b/external-reshape-design.txt
> index 10c57cc..e4cf4e1 100644
> --- a/external-reshape-design.txt
> +++ b/external-reshape-design.txt
> @@ -277,4 +277,4 @@ sync_action
>  
>  ...
>  
> -[1]: Linux kernel design patterns - part 3, Neil Brown http://lwn.net/Articles/336262/
> +[1]: Linux kernel design patterns - part 3, Neil Brown https://lwn.net/Articles/336262/
> diff --git a/mdadm.8.in b/mdadm.8.in
> index 9e7cb96..7f32762 100644
> --- a/mdadm.8.in
> +++ b/mdadm.8.in
> @@ -367,7 +367,7 @@ Use the Intel(R) Matrix Storage Manager metadata format.  This creates a
>  which is managed in a similar manner to DDF, and is supported by an
>  option-rom on some platforms:
>  .IP
> -.B http://www.intel.com/design/chipsets/matrixstorage_sb.htm
> +.B https://www.intel.com/design/chipsets/matrixstorage_sb.htm

Sorry for being a pain, but this link isn't actually valid.

Does someone from Intel know what to point at?

Cheers,
Jes

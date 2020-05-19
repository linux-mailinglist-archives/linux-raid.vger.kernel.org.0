Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1A81D8C49
	for <lists+linux-raid@lfdr.de>; Tue, 19 May 2020 02:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgESAcO (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 18 May 2020 20:32:14 -0400
Received: from sender11-op-o11.zoho.eu ([31.186.226.225]:17161 "EHLO
        sender11-op-o11.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbgESAcO (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 18 May 2020 20:32:14 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589848325; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=bQeF1336WrjULcRzxMtKBdvNCMgPfzPLrTefVztHisWnSTyYPnPMoRHmMGM/inXW81+vSCUT0o+4JkwBIjdQbHTfMOfA+V0/AH19NG6qa0ZAwEe4AfmzbmPMDAKg7JOFnuDcMTZO1DBhSGZngeXDNTiMF3pKxUcGo7AY9W68tTM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1589848325; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=JWhROHvTa6G5O3tKmswYKb9urheNh+t/UKQxq1/y618=; 
        b=RdaXZIoZ+3+rzKNRsrK1vE7kiS0fF1aeRJ/M+fQ0psQQcQBf4l1yoSsKrpyw6D1Za9KcVeJMRm1kUcFcgFXDoaBVZorir89JAaYxQyOds1Gb3yoPFGFATA23Ui0VwZF62OUVWYl/Hh45U6a5G4WUyfcMF+ooz1PQTOfnNq4kT/g=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org> header.from=<jes@trained-monkey.org>
Received: from [100.109.105.145] (163.114.130.4 [163.114.130.4]) by mx.zoho.eu
        with SMTPS id 1589848323926656.2332427133565; Tue, 19 May 2020 02:32:03 +0200 (CEST)
Subject: Re: [PATCH] mdadm: detect too-small device: error rather than
 underflow/crash
To:     David Favro <dfavro@meta-dynamic.com>
Cc:     linux-raid@vger.kernel.org
References: <20200516035020.ABA6D19801B5@minderbinder.meta-dynamic.com>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <8c7c42f8-2040-859b-d558-0b523f7092d8@trained-monkey.org>
Date:   Mon, 18 May 2020 20:32:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200516035020.ABA6D19801B5@minderbinder.meta-dynamic.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 5/15/20 4:40 PM, David Favro wrote:
> Hi,
> 
> My apologies that this is so late, but would be nice if it could
> make it into the release.

It's not too late, but the patch needs some cleaning up to be acceptable.

Could you also post it with git send-email so I don't have to manually
take it apart to apply it?

> In trying to test the behavior of mdadm under various circumstances,
> I was experimenting with creating a test array of very small
> loopback devices, when I observed some strange behavior from mdadm
> (died with floating-point-exception signal).  Turning on --verbose
> showed enormous volume sizes, and I eventually tracked down exactly
> what one might guess is happening, integer underflow.
> 
> I prepared a patch, which follows the scissors line -- while it's
> obviously not likely to come up frequently in "real life", corner
> cases have a way of occurring and should be properly handled, not
> left to crash at a later time in parts unknown.
> 
> There are two places in the code for 1.x metadata where the same
> problem occurs, depending on 1.0 vs. 1.1+: I used the same
> error-message code for both, via a goto (which I prefer to
> replicating code, although a good optimizing compiler might combine
> replicated code to generate the same goto); I know that goto offends
> the sensibilities of some, but I noticed that it is already used
> elsewhere in existing mdadm codebase.
> 
> A preexisting too-small-device check is removed both because it is
> inadequate to properly detect the condition, and because it is made
> redundant by the proper check (after the size of reserved space is
> computed).
> 
> I wrote a small shell script which nicely demonstrates the bug and
> the patch's fix using loopback devices, will send in a separate
> email.
> 
> As an aside, the follow-on hardware fault that I got was the result
> of a divide-by-0 on a little-endian 64-bit architecture after some
> word-size conversions on enormous integer values; it may manifest
> differently on machines with a different byte-ordering or word-size,
> perhaps attempting to create a garbage array rather than crashing,
> but it's not really relevant: the real fix is not to proceed with
> the invalid devices, as this patch prevents.
> 
> -- David Favro
> 
> 
> 8< --------------------------------------------------
> 
> For 1.x metadata, when the user requested creation of an array on
> component devices that were too small even to hold the superblock,
> an undetected integer wraparound (underflow) resulted in an enormous
> computed size which resulted in various follow-on errors such as
> floating-point exception.
> 
> This patch detects this condition, prints a reasonable diagnostic
> message, and refuses to continue.
> 
> Signed-off-by: David Favro <dfavro@meta-dynamic.com>
> ---
>  super1.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/super1.c b/super1.c
> index e0d80be1..1e12198d 100644
> --- a/super1.c
> +++ b/super1.c
> @@ -2785,10 +2785,6 @@ static int validate_geometry1(struct supertype *st, int level,
>  	close(fd);
>  
>  	devsize = ldsize >> 9;
> -	if (devsize < 24) {
> -		*freesize = 0;
> -		return 0;
> -	}
>  
>  	/* creating:  allow suitable space for bitmap or PPL */
>  	if (consistency_policy == CONSISTENCY_POLICY_PPL)
> @@ -2829,15 +2825,27 @@ static int validate_geometry1(struct supertype *st, int level,
>  	case 0: /* metadata at end.  Round down and subtract space to reserve */
>  		devsize = (devsize & ~(4ULL*2-1));
>  		/* space for metadata, bblog, bitmap/ppl */
> -		devsize -= 8*2 + 8 + bmspace;
> +		const unsigned long long required = 8*2 + 8 + bmspace;
> +		if ( devsize < required ) /* detect underflow */
> +			goto dev_too_small_err;
> +		devsize -= required;

You don't declare new variables right in the middle of the code like
this. It should always be done in a fresh context after a {

>  		break;
>  	case 1:
>  	case 2:
> +		if ( devsize < data_offset ) /* detect underflow */
> +			goto dev_too_small_err;

We don't use spaces between the parenthesis and the variable names, only
after the if ().

>  		devsize -= data_offset;
>  		break;
>  	}
>  	*freesize = devsize;
>  	return 1;
> +
> +	/* Error condition, device cannot even hold the overhead. */
> +	dev_too_small_err:
> +		fprintf( stderr, "device %s is too small (%lluK) for "
> +				"required metadata!\n", subdev, devsize>>1 );
> +		*freesize = 0;
> +		return 0;

This indentation is broken, the label should not be indented, and the
code for it needs to be aligned properly. Please look at how it's done
elsewhere in the code.

Thanks,
Jes


Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6901C23A74A
	for <lists+linux-raid@lfdr.de>; Mon,  3 Aug 2020 15:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbgHCNJl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-raid@lfdr.de>); Mon, 3 Aug 2020 09:09:41 -0400
Received: from sender11-op-o12.zoho.eu ([31.186.226.226]:17474 "EHLO
        sender11-op-o12.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgHCNJl (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 3 Aug 2020 09:09:41 -0400
X-Greylist: delayed 904 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Aug 2020 09:09:40 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1596459268; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=GIwV57QShfd9tqYV/pFf+/VElr/qJHlz14BN/R3hVtL2pYUfgtInHOGZh8iYLv2aRnJmKTjaiRiLgPif1HLRcRzica3Oc+DHEK3iBKqZ3a3pmwNdD3RVBk/kp0AVJsGzZXb7nUUitkzTbYRVx4sq6ksM2GmICcqVQtGpd7QQAFs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1596459268; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=t6bjMPbqXrmuKxIeEDYFHN5dpf0UcDF5BuVIV12qSAQ=; 
        b=F3dmn9BVS9EK9iHdqp7bvY8Ara2PPVZIqI0qaIiHenSGG+dmVm7s8n2TKXflYQGV1DA0mDgO/upox9GaMZsUbsDbppVo7ns3gZ1zJzwNoRqyHvM2fr9iLeNFw4+Te/6lhwHnXogXvHOjv8U357SSASYKC9WUikS2SS0LkIs/DVo=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org> header.from=<jes@trained-monkey.org>
Received: from [192.168.99.29] (pool-108-46-250-244.nycmny.fios.verizon.net [108.46.250.244]) by mx.zoho.eu
        with SMTPS id 1596459266482572.774771307599; Mon, 3 Aug 2020 14:54:26 +0200 (CEST)
Subject: Re: mdadm-4.2 release
To:     "Tkaczyk, Mariusz" <mariusz.tkaczyk@intel.com>
Cc:     "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "Baldysiak, Pawel" <pawel.baldysiak@intel.com>
References: <SA0PR11MB454290C854066D0AFD7EEC75FF6C0@SA0PR11MB4542.namprd11.prod.outlook.com>
 <SA0PR11MB4542AD5A1AEF00B96404D5A4FF6C0@SA0PR11MB4542.namprd11.prod.outlook.com>
 <SA0PR11MB4542B9DC53D2B8013450A767FF4D0@SA0PR11MB4542.namprd11.prod.outlook.com>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <cfed90ab-69ec-c90e-f120-f8e8453e40c8@trained-monkey.org>
Date:   Mon, 3 Aug 2020 08:54:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <SA0PR11MB4542B9DC53D2B8013450A767FF4D0@SA0PR11MB4542.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
X-ZohoMailClient: External
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 8/3/20 8:48 AM, Tkaczyk, Mariusz wrote:
> Hi Jes,
> Is there any chance to release mdadm soon?

Hi Mariusz,

Sorry I dropped the ball on this one. I am pretty swamped at work right
now, but I'll try to catch up on the pending patches and do the first rc
soon. Sorry for the delay.

Cheers,
Jes


> Thanks,
> Mariusz
> 
> -----Original Message-----
> From: linux-raid-owner@vger.kernel.org <linux-raid-owner@vger.kernel.org> On Behalf Of Tkaczyk, Mariusz
> Sent: Wednesday, July 1, 2020 11:18 AM
> To: Jes Sorensen <jes@trained-monkey.org>
> Cc: linux-raid@vger.kernel.org; Baldysiak, Pawel <pawel.baldysiak@intel.com>
> Subject: mdadm-4.2 release
> 
> Hi Jes,
> It will be nice to release mdadm-4.2 soon.  If I remember correctly, release has been planned for May- now is July.
> Do you still working on it?
> We are ok with releasing it on current HEAD.
> Sorry for spam, resending as plain text.
> 
> Thanks,
> Mariusz
> 



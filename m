Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5D3BC7B7
	for <lists+linux-raid@lfdr.de>; Tue, 24 Sep 2019 14:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730256AbfIXMPW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-raid@lfdr.de>); Tue, 24 Sep 2019 08:15:22 -0400
Received: from mga14.intel.com ([192.55.52.115]:56869 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728080AbfIXMPV (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Tue, 24 Sep 2019 08:15:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2019 05:15:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,544,1559545200"; 
   d="scan'208";a="182895240"
Received: from irsmsx110.ger.corp.intel.com ([163.33.3.25])
  by orsmga008.jf.intel.com with ESMTP; 24 Sep 2019 05:15:20 -0700
Received: from irsmsx155.ger.corp.intel.com (163.33.192.3) by
 irsmsx110.ger.corp.intel.com (163.33.3.25) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 24 Sep 2019 13:15:19 +0100
Received: from irsmsx107.ger.corp.intel.com ([169.254.10.7]) by
 irsmsx155.ger.corp.intel.com ([169.254.14.139]) with mapi id 14.03.0439.000;
 Tue, 24 Sep 2019 13:15:19 +0100
From:   "Tkaczyk, Mariusz" <mariusz.tkaczyk@intel.com>
To:     Jes Sorensen <jes.sorensen@gmail.com>
CC:     "Smolinski, Krzysztof" <krzysztof.smolinski@intel.com>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "Dabrowski, Mariusz" <mariusz.dabrowski@intel.com>
Subject: Re: [PATCH,v2] mdadm: check value returned by snprintf against
 errors
Thread-Topic: [PATCH,v2] mdadm: check value returned by snprintf against
 errors
Thread-Index: AQHVVBJFLDAWHlxZxE6D35wniA2Hqab9v0oAgD0rQgA=
Date:   Tue, 24 Sep 2019 12:15:18 +0000
Message-ID: <14012545.AkVXcDBcQu@mtkaczyk-devel.igk.intel.com>
References: <20190816090617.12679-1-krzysztof.smolinski@intel.com>
 <d540ec64-ffb2-dab1-c792-f088594330c2@gmail.com>
In-Reply-To: <d540ec64-ffb2-dab1-c792-f088594330c2@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [163.33.7.139]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7544E0EDFF980C48A4C8AD63596405A6@intel.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi Jes,

Did you setup new key? We had some patches to send upstream.
Also, some patches are waiting for your feedback.

Please let me know when you will be ready.

Thanks,
Mariusz

On Friday, August 16, 2019 4:08:38 PM CEST Jes Sorensen wrote:
> On 8/16/19 5:06 AM, Krzysztof Smolinski wrote:
> > GCC 8 checks possible truncation during snprintf more strictly
> > than GCC 7 which result in compilation errors. To fix this
> > problem checking result of snprintf against errors has been added.
> > 
> > Signed-off-by: Krzysztof Smolinski <krzysztof.smolinski@intel.com>
> > ---
> > 
> >  sysfs.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> Applied thanks!
> 
> Note my ubi key fried itself so I need to setup a new one before I can
> push to kernel.org.
>
> I am glad to see some of this addressed, but the problem is much bigger.
> We need to fixup super-intel.c to build with gcc 9, not just gcc 8. I
> did a bunch of stuff, but the bigger problems remain. I am not a huge
> fan of just hiding it via typecasts, I'd like to see a proper solution.
> 
> Cheers,
> Jes





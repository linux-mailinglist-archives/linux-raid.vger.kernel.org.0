Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C962C652DCF
	for <lists+linux-raid@lfdr.de>; Wed, 21 Dec 2022 09:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234560AbiLUITi (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Wed, 21 Dec 2022 03:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234434AbiLUIS5 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 21 Dec 2022 03:18:57 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF4D218B9
        for <linux-raid@vger.kernel.org>; Wed, 21 Dec 2022 00:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671610717; x=1703146717;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pPEbSVH3UwhsEWjVgKd2cSbOyBp9g8BlZ0KLOD8PNFE=;
  b=BtYODjsQANc6QXFiuq3tAC6lisY4EQXOz1yPc3q/1bqcfBDhoaSmUF5B
   fZp71taODhDlpuODhMXP0Lj2k/LyylnLrqckb66TCMQwLN47mt6CPxffS
   dy0vUG/MYhsEAX7QWrYtJhB4V98esBPXDuDfIAHO23o7VDFBfjB979mZq
   2n41Rn+L94HAmX5TD6Jh91U2mhTelaNAkixRCFPVkekYItFyMpsH6S7ie
   pSKTi6lZ+c1/L5rzmFcx1I16TgO7J+qdIhjAyDJKnxjcHlqS7sj5UKFl+
   1bsauPRES1bmdrLQ8DUJazuuPi76oJO0fBI1dx2RCSMahkDJLrqpSrkoy
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="382043836"
X-IronPort-AV: E=Sophos;i="5.96,262,1665471600"; 
   d="scan'208";a="382043836"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2022 00:18:17 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="629036557"
X-IronPort-AV: E=Sophos;i="5.96,262,1665471600"; 
   d="scan'208";a="629036557"
Received: from mtkaczyk-mobl.ger.corp.intel.com (HELO localhost) ([10.252.62.71])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2022 00:18:15 -0800
Date:   Wed, 21 Dec 2022 09:18:10 +0100
From:   Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To:     lixiaokeng <lixiaokeng@huawei.com>
Cc:     Jes Sorensen <jes@trained-monkey.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        <linux-raid@vger.kernel.org>, linfeilong <linfeilong@huawei.com>,
        "liuzhiqiang (I)" <liuzhiqiang26@huawei.com>,
        Wu Guanghao <wuguanghao3@huawei.com>
Subject: Re: [PATCH V3] Fix NULL dereference in super_by_fd
Message-ID: <20221221091810.000072c9@linux.intel.com>
In-Reply-To: <44edac17-12c8-a512-3d27-f2f22e82b990@huawei.com>
References: <44edac17-12c8-a512-3d27-f2f22e82b990@huawei.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org


>  			*subarrayp = subarray;
>  		strcpy(st->container_devnm, container);
> -		strcpy(st->devnm, fd2devnm(fd));
> +		strncpy(st->devnm, devnm, MD_NAME_MAX);

Sorry for bothering you again but there is one nit. Strncpy implementation
doesn't guarantee '\0' ended string- static code analysis may warn. In this
case you can use:
strncpy(st->devnm, devnm, MD_NAME_MAX - 1);
or
snprintf(st->devnm, MD_NAME_MAX, "%s", devnm);

Thanks,
Mariusz

Return-Path: <linux-raid+bounces-138-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C76A48089A6
	for <lists+linux-raid@lfdr.de>; Thu,  7 Dec 2023 14:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72F231F2146B
	for <lists+linux-raid@lfdr.de>; Thu,  7 Dec 2023 13:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8870940C15;
	Thu,  7 Dec 2023 13:58:31 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847B6D5E;
	Thu,  7 Dec 2023 05:58:27 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rBEtL-0006HO-Pv; Thu, 07 Dec 2023 14:58:15 +0100
Message-ID: <e2d47b6c-3420-4785-8e04-e5f217d09a46@leemhuis.info>
Date: Thu, 7 Dec 2023 14:58:13 +0100
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: md raid6 oops in 6.6.4 stable
Content-Language: en-US, de-DE
To: Bagas Sanjaya <bagasdotme@gmail.com>, Genes Lists <lists@sapience.com>,
 snitzer@kernel.org, song@kernel.org, yukuai3@huawei.com, axboe@kernel.dk,
 mpatocka@redhat.com, heinzm@redhat.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux RAID <linux-raid@vger.kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>
Cc: Bhanu Victor DiCara <00bvd0+linux@gmail.com>, Xiao Ni <xni@redhat.com>,
 Guoqing Jiang <guoqing.jiang@linux.dev>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <6e6816dd-2ec5-4bca-9558-60cfde46ef8c@sapience.com>
 <ZXHJEkwIJ5zKTMjV@archie.me>
From: Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <ZXHJEkwIJ5zKTMjV@archie.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1701957507;23c09c83;
X-HE-SMSGID: 1rBEtL-0006HO-Pv

On 07.12.23 14:30, Bagas Sanjaya wrote:
> On Thu, Dec 07, 2023 at 08:10:04AM -0500, Genes Lists wrote:
>> I have not had chance to git bisect this but since it happened in stable I
>> thought it was important to share sooner than later.
>>
>> One possibly relevant commit between 6.6.3 and 6.6.4 could be:
>>
>>   commit 2c975b0b8b11f1ffb1ed538609e2c89d8abf800e
>>   Author: Song Liu <song@kernel.org>
>>   Date:   Fri Nov 17 15:56:30 2023 -0800
>>
>>     md: fix bi_status reporting in md_end_clone_io
>>
>> log attached shows page_fault_oops.
>> Machine was up for 3 days before crash happened.
> 
> Can you confirm that culprit by bisection?

Bagas, I know you are trying to help, but sorry, I'd say this is not
helpful at all -- any maybe even harmful.

From the quoted texts it's pretty clear that the reporter knows that a
bisection would be helpful, but currently is unable to perform one --
and even states reasons for reporting it without having it bisected. So
your message afaics doesn't bring anything new to the table; and I might
be wrong with that, but I fear some people in a situation like this
might even be offended by a reply like that, as it states something
already obvious.

Ciao, Thorsten



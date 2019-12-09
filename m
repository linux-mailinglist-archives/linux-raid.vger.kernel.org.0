Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6AF8117435
	for <lists+linux-raid@lfdr.de>; Mon,  9 Dec 2019 19:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfLISaA (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 9 Dec 2019 13:30:00 -0500
Received: from sender11-op-o12.zoho.eu ([185.20.211.226]:17456 "EHLO
        sender11-op-o12.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfLISaA (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 9 Dec 2019 13:30:00 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1575916191; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=KuB7Q6VeLnHn70RMJZO9c/1uYwLgaLR79uczXmPOkftqAm9Y6HrajjLP0cGf1excSKoF+5crGcfCDxenB0/1NiyDTWd4B+yivTU9YFKq73ypHd6tBNmba6inBfGR1xHCzuT40TjI/Ux/BX6QJhrswPkG7XS3xyv+IJrJy4l4ao8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1575916191; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=PzSqxsH3TeNklvKXF3hzB95xa/My/XS3tFEI/sFenZ4=; 
        b=PmDRKFBM0CFqJX0XtSVN0nCM6sQRnpNlRutdHwRXbzeSr0BUtC7BZ3vBXAU+NjR4AW2iiktlepTIT+J9/O60KMR6jO1woEZnQ9zkPqKRuSvccQD19gb5WEKmzxznlONthhdMdmFNt+6LO3mfrCUN3ZHH2lNroVV6TNxdcpGE5sM=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        dkim=pass  header.i=trained-monkey.org;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org> header.from=<jes@trained-monkey.org>
Received: from [172.30.221.108] (163.114.130.128 [163.114.130.128]) by mx.zoho.eu
        with SMTPS id 1575916187977480.7595803778238; Mon, 9 Dec 2019 19:29:47 +0100 (CET)
Subject: Re: [PATCH v2] md/raid0: Provide admin guidance on multi-zone RAID0
 layout migration
To:     dann frazier <dann.frazier@canonical.com>,
        Song Liu <liu.song.a23@gmail.com>, NeilBrown <neilb@suse.de>
Cc:     Ivan Topolsky <doktor.yak@gmail.com>, Andreas <a@hegyi.info>,
        linux-raid@vger.kernel.org
References: <20191112232105.749-1-dann.frazier@canonical.com>
 <20191209174828.GA411439@xps13.dannf>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <c05d46d4-d970-df69-9da7-20c52eab3e6f@trained-monkey.org>
Date:   Mon, 9 Dec 2019 13:29:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191209174828.GA411439@xps13.dannf>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 12/9/19 12:48 PM, dann frazier wrote:
> [ + Jes ]
> 
> Hi Song, Neil,
>  Now that the merge window has closed, I wanted to check in on the
> status of this. fyi, this still applies cleanly to 5.5-rc1.
> 
> Jes: note that this patch makes an assumption that the next version of
> mdadm would be >= 4.2, so seeking your ACK as well.

The last release was 4.1, so I think it's fair to assume it'll be 4.2
next time.

Cheers,
Jes

>  -dann
> 
> On Tue, Nov 12, 2019 at 03:21:05PM -0800, dann frazier wrote:
>> Helping an administrator understand this issue and how to deal with it
>> requires more text than achievable in a kernel error message. Let's
>> clarify the issue in the admin guide, and have the kernel emit a link
>> to it.
>>
>> v2:
>>   - Add info about setting layout w/ mdadm, using presumed-next-mdadm
>>     version.
>>   - Add comment to doc to help prevent future changes from breaking
>>     the link emitted by raid0.
>>
>> Fixes: c84a1372df92 ("md/raid0: avoid RAID0 data corruption due to layout confusion.")
>> Cc: stable@vger.kernel.org (3.14+)
>> Signed-off-by: dann frazier <dann.frazier@canonical.com>
>> ---
>>  Documentation/admin-guide/md.rst | 48 ++++++++++++++++++++++++++++++++
>>  drivers/md/raid0.c               |  2 ++
>>  2 files changed, 50 insertions(+)
>>
>> diff --git a/Documentation/admin-guide/md.rst b/Documentation/admin-guide/md.rst
>> index 3c51084ffd379..a736e3b4117fc 100644
>> --- a/Documentation/admin-guide/md.rst
>> +++ b/Documentation/admin-guide/md.rst
>> @@ -759,3 +759,51 @@ These currently include:
>>  
>>    ppl_write_hint
>>        NVMe stream ID to be set for each PPL write request.
>> +
>> +Multi-Zone RAID0 Layout Migration
>> +---------------------------------
>> +.. Note: a public URL to this section is emitted in an error message from
>> +   the raid0 driver, so please take care to not make changes that would
>> +   cause that link to break.
>> +An unintentional RAID0 layout change was introduced in the v3.14 kernel.
>> +This effectively means there are 2 different layouts Linux will use to
>> +write data to RAID0 arrays in the wild - the "pre-3.14" way and the
>> +"3.14 and later" way. Mixing these layouts by writing to an array while
>> +booted on these different kernel versions can lead to corruption.
>> +
>> +Note that this only impacts RAID0 arrays that include devices of different
>> +sizes. If your devices are all the same size, both layouts are equivalent,
>> +and your array is not at risk of corruption due to this issue.
>> +
>> +Unfortunately, the kernel cannot detect which layout was used for writes
>> +to pre-existing arrays, and therefore requires input from the
>> +administrator. This input can be provided via the kernel command line
>> +with the ``raid0.default_layout=<N>`` parameter, or by setting the
>> +``default_layout`` module parameter when loading the ``raid0`` module.
>> +With a new enough version of mdadm (>= 4.2, or equivalent distro backports),
>> +you can set the layout version when assembling a stopped array. For example::
>> +
>> +       mdadm --stop /dev/md0
>> +       mdadm --assemble -U layout-alternate /dev/md0 /dev/sda1 /dev/sda2
>> +
>> +See the mdadm manpage for more details. Once set in this manner, the layout
>> +will be recorded in the array and will not need to be explicitly specified
>> +in the future.
>> +
>> +Which layout version should I use?
>> +++++++++++++++++++++++++++++++++++
>> +If your RAID array has only been written to by a 3.14 or later kernel, then
>> +you should specify default_layout=2, or set ``layout-alternate`` in mdadm.
>> +If your kernel has only been written to by a < 3.14 kernel, then you should
>> +specify default_layout=1 or set ``layout-original`` in mdadm. If the array
>> +may have already been written to by both kernels < 3.14 and >= 3.14, then it
>> +is possible that your data has already suffered corruption. Note that
>> +``mdadm --detail`` will show you when an array was created, which may be
>> +useful in helping determine the kernel version that was in-use at the time.
>> +
>> +When determining the scope of corruption, it may also be useful to know
>> +that the area susceptible to this corruption is limited to the area of the
>> +array after "MIN_DEVICE_SIZE * NUM DEVICES".
>> +
>> +For new arrays you may choose either layout version. Neither version is
>> +inherently better than the other.
>> diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
>> index 1e772287b1c8e..e01cd52d71aa4 100644
>> --- a/drivers/md/raid0.c
>> +++ b/drivers/md/raid0.c
>> @@ -155,6 +155,8 @@ static int create_strip_zones(struct mddev *mddev, struct r0conf **private_conf)
>>  		pr_err("md/raid0:%s: cannot assemble multi-zone RAID0 with default_layout setting\n",
>>  		       mdname(mddev));
>>  		pr_err("md/raid0: please set raid0.default_layout to 1 or 2\n");
>> +		pr_err("Read the following page for more information:\n");
>> +		pr_err("https://www.kernel.org/doc/html/latest/admin-guide/md.html#multi-zone-raid0-layout-migration\n");
>>  		err = -ENOTSUPP;
>>  		goto abort;
>>  	}



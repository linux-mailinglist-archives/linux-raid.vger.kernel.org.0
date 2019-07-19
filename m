Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBB76E54D
	for <lists+linux-raid@lfdr.de>; Fri, 19 Jul 2019 14:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbfGSMAI (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 19 Jul 2019 08:00:08 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:40150 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728006AbfGSMAI (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Fri, 19 Jul 2019 08:00:08 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A13E4365CB0116E81683;
        Fri, 19 Jul 2019 20:00:03 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.14) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Fri, 19 Jul 2019
 20:00:00 +0800
Subject: Re: [PATCH 1/1] bad block is after superblock and bitmap
To:     Xiao Ni <xni@redhat.com>, <linux-raid@vger.kernel.org>
CC:     <artur.paszkiewicz@intel.com>, <jes.sorensen@gmail.com>,
        <ncroxon@redhat.com>, <heinzm@redhat.com>
References: <1563526156-17802-1-git-send-email-xni@redhat.com>
From:   Hou Tao <houtao1@huawei.com>
Message-ID: <eacb8ed2-d947-cfdd-1920-3380b6aa0b96@huawei.com>
Date:   Fri, 19 Jul 2019 19:59:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1563526156-17802-1-git-send-email-xni@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.14]
X-CFilter-Loop: Reflected
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi,

On 2019/7/19 16:49, Xiao Ni wrote:
> Now it calculate bad block offset by bm_offset + bm_space. It should add sb_offset.
> 
> Fixes: 1b7eb672(super1: fix setting bad block log offset in write_init_super1())
> Signed-off-by: Xiao Ni <xni@redhat.com>
> ---
>  super1.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/super1.c b/super1.c
> index b85dc20..682655a 100644
> --- a/super1.c
> +++ b/super1.c
> @@ -2012,7 +2012,7 @@ static int write_init_super1(struct supertype *st)
>  			sb->data_size = __cpu_to_le64(dsize - data_offset);
>  			if (data_offset >= sb_offset+bm_offset+bm_space+8) {
>  				sb->bblog_size = __cpu_to_le16(8);
> -				sb->bblog_offset = __cpu_to_le32(bm_offset +
> +				sb->bblog_offset = __cpu_to_le32(sb_offset + bm_offset +
>  								 bm_space);
bblog_offset is used as the signed offset from the sb_offset not the offset from
the start of the device, so I don't think the addition of sb_offset is correct.

Regards,
Tao

>  			} else if (data_offset >= sb_offset + 16) {
>  				sb->bblog_size = __cpu_to_le16(8);
> 


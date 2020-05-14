Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11DFB1D3F0F
	for <lists+linux-raid@lfdr.de>; Thu, 14 May 2020 22:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgENUjy (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 14 May 2020 16:39:54 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:45225 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726035AbgENUjx (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Thu, 14 May 2020 16:39:53 -0400
Received: from [192.168.0.3] (ip5f5af6ec.dynamic.kabel-deutschland.de [95.90.246.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 1F59B20646094;
        Thu, 14 May 2020 22:39:51 +0200 (CEST)
Subject: Re: [PATCH] Use more secure HTTPS URLs
To:     Jes Sorensen <jes.sorensen@gmail.com>
Cc:     linux-raid@vger.kernel.org
References: <20200513132707.16744-1-pmenzel@molgen.mpg.de>
 <f2d4fa4e-697f-033a-1144-d4ff30e48ec3@gmail.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <844fa4e8-fe19-ad46-55e3-1357518f1366@molgen.mpg.de>
Date:   Thu, 14 May 2020 22:39:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <f2d4fa4e-697f-033a-1144-d4ff30e48ec3@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Dear Jes,


Am 13.05.20 um 15:44 schrieb Jes Sorensen:
> On 5/13/20 9:27 AM, Paul Menzel wrote:
>> All URLs in the source are available over HTTPS, so convert all URLs to
>> HTTPS with the command below.
>>
>>      git grep -l 'http://' | xargs sed -i 's,http://,https://,g'
>>
>> Cc: linux-raid@vger.kernel.org
>> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> 
> Some of this looks valid, but we're not going back to update existing
> ANNOUNCE files.

May I ask why? It’s all logged in the VCS history, and the two URLs are 
always the same.


Kind regards,

Paul

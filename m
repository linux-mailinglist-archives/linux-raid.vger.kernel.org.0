Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B80D13F64A
	for <lists+linux-raid@lfdr.de>; Thu, 16 Jan 2020 20:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388855AbgAPTCd (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 16 Jan 2020 14:02:33 -0500
Received: from sender11-of-f72.zoho.eu ([31.186.226.244]:17349 "EHLO
        sender21-op-o12.zoho.eu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2437317AbgAPTCd (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 16 Jan 2020 14:02:33 -0500
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Jan 2020 14:02:31 EST
Received: from [172.30.220.41] (163.114.130.128 [163.114.130.128]) by mx.zoho.eu
        with SMTPS id 1579200440532167.36529918859594; Thu, 16 Jan 2020 19:47:20 +0100 (CET)
Subject: Re: [PATCH] Respect $(CROSS_COMPILE) when $(CC) is the default
To:     dann frazier <dann.frazier@canonical.com>
Cc:     Helmut Grohne <helmut@subdivi.de>, linux-raid@vger.kernel.org
References: <20191209205413.6839-1-dann.frazier@canonical.com>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <f6916112-b52e-8fb7-e0db-01192537e72b@trained-monkey.org>
Date:   Thu, 16 Jan 2020 13:47:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191209205413.6839-1-dann.frazier@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 12/9/19 3:54 PM, dann frazier wrote:
> Commit 1180ed5 told make to only respect $(CROSS_COMPILE) when $(CC)
> was unset. But that will never be the case, as make provides
> a default value for $(CC). Change this logic to respect $(CROSS_COMPILE)
> when $(CC) is the default. Patch originally by Helmet Grohne.
> 
> Fixes: 1180ed5 ("Makefile: make the CC definition conditional")
> Signed-off-by: dann frazier <dann.frazier@canonical.com>
> ---
>  Makefile | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied!

Thanks,
Jes



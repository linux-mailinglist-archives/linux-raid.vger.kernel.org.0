Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 883FC18751F
	for <lists+linux-raid@lfdr.de>; Mon, 16 Mar 2020 22:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732698AbgCPVul (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 16 Mar 2020 17:50:41 -0400
Received: from sender11-of-f72.zoho.eu ([31.186.226.244]:17335 "EHLO
        sender11-of-f72.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732636AbgCPVul (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 16 Mar 2020 17:50:41 -0400
Received: from [100.109.44.175] (163.114.130.4 [163.114.130.4]) by mx.zoho.eu
        with SMTPS id 158439543639721.372976205732243; Mon, 16 Mar 2020 22:50:36 +0100 (CET)
Subject: Re: [PATCH] Detail: show correct bitmap info for cluster raid device
To:     Lidong Zhong <lidong.zhong@suse.com>
Cc:     linux-raid@vger.kernel.org, guoqing.jiang@cloud.ionos.com
References: <20200316021649.4423-1-lidong.zhong@suse.com>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <46fbe3ac-f9e6-078d-a9cc-eb8457bf80b5@trained-monkey.org>
Date:   Mon, 16 Mar 2020 17:50:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200316021649.4423-1-lidong.zhong@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 3/15/20 10:16 PM, Lidong Zhong wrote:
> Signed-off-by: Lidong Zhong <lidong.zhong@suse.com>
> ---
>  Detail.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied!

Thanks,
Jes


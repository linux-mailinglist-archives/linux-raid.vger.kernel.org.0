Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71B94EDDC2
	for <lists+linux-raid@lfdr.de>; Thu, 31 Mar 2022 17:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237726AbiCaPqv (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 31 Mar 2022 11:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239348AbiCaPqn (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 31 Mar 2022 11:46:43 -0400
Received: from sender11-op-o11.zoho.eu (sender11-op-o11.zoho.eu [31.186.226.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D334322451B
        for <linux-raid@vger.kernel.org>; Thu, 31 Mar 2022 08:41:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1648741289; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=JNIXyVEvsAIQUd2AwpEdLHkKn4talDshjZt8snKRagSx1j9IIh0s0Sjay4sokXp3R0DM/3GT3unURleCCAmqDQweMA1tXKIEQLs2BjL+6hQ+QBwQaks2XNqrkeBw0xNqbp8RaFTvTuflwP1rO8drCsldFaNQWfoMH2bq7Ju6eFY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1648741289; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=OIClQwKwhgRjXzkazoypqiwLx57kdKyHrGAeqLPETTg=; 
        b=ZdTM7uQEQa46c6cQ5YZbxv89aEnwpd94KFZuMjgzQ2NhgWHTOZxMdbVvZhqcMrHk55eVB7TTRo5QIk1goodi43oRdVHgJ0HQn+vUocmTahm0cMBbrE3D76Ln8XBseAFM+mMWe7SQKCwb7E5SAxRsk3K6IGTdRZM6bi4h3h6thN8=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org>
Received: from [172.30.27.237] (163.114.130.4 [163.114.130.4]) by mx.zoho.eu
        with SMTPS id 1648741287539133.55575443384691; Thu, 31 Mar 2022 17:41:27 +0200 (CEST)
Message-ID: <8494d046-814b-9ff4-1dc4-d9c49e0f9d93@trained-monkey.org>
Date:   Thu, 31 Mar 2022 11:41:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] udev: adapt rules to systemd v247
Content-Language: en-US
To:     Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Cc:     linux-raid@vger.kernel.org
References: <20220114154433.7386-1-mariusz.tkaczyk@linux.intel.com>
From:   Jes Sorensen <jes@trained-monkey.org>
In-Reply-To: <20220114154433.7386-1-mariusz.tkaczyk@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 1/14/22 10:44, Mariusz Tkaczyk wrote:
> New events have been added in kernel 4.14 ("bind" and "unbind").
> Systemd maintainer suggests to modify "add|change" branches.
> This patches implements their suggestions. There is no issue yet because
> new event types are not used in md.
> 
> Please see systemd announcement for details[1].
> 
> [1] https://lists.freedesktop.org/archives/systemd-devel/2020-November/045646.html
> 
> Signed-off-by: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>

Applied!

Thanks,
Jes



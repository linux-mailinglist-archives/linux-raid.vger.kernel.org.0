Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7030255EDE
	for <lists+linux-raid@lfdr.de>; Fri, 28 Aug 2020 18:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgH1Qib (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 28 Aug 2020 12:38:31 -0400
Received: from static.214.254.202.116.clients.your-server.de ([116.202.254.214]:57330
        "EHLO ciao.gmane.io" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgH1Qi3 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 28 Aug 2020 12:38:29 -0400
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <linux-raid@m.gmane-mx.org>)
        id 1kBhOU-00018a-3y
        for linux-raid@vger.kernel.org; Fri, 28 Aug 2020 18:38:26 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-raid@vger.kernel.org
From:   Ian Pilcher <arequipeno@gmail.com>
Subject: Re: [RFC PATCH] Detail: don't display the raid level when it's
 inactive
Date:   Fri, 28 Aug 2020 11:38:21 -0500
Message-ID: <ribbtt$t51$1@ciao.gmane.io>
References: <20200826151658.3493-1-lidong.zhong@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <20200826151658.3493-1-lidong.zhong@suse.com>
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 8/26/20 10:16 AM, Lidong Zhong wrote:
> ...
> So the misleading "raid0" is shown in this testcase. I think maybe
> the "Raid Level" item shouldn't be displayed any more for the inactive
> array.

As a system administrator, I'd much rather see "unknown" (or something
similar), rather than simply omitting the information.

-- 
========================================================================
                  In Soviet Russia, Google searches you!
========================================================================


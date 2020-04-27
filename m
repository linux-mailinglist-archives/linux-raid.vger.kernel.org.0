Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 614191BA69C
	for <lists+linux-raid@lfdr.de>; Mon, 27 Apr 2020 16:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbgD0OjC (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 27 Apr 2020 10:39:02 -0400
Received: from sender11-op-o11.zoho.eu ([31.186.226.225]:17104 "EHLO
        sender11-op-o11.zoho.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727824AbgD0OjB (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 27 Apr 2020 10:39:01 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1587997433; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=gvT/BQV/pgwXelfi1Y3UXzH4XGkkaj3RazUE6sZe4o8wRhtFJnKsR+4fMDMaB9PQekglm3fcvdQ2gVWpSN6jZ3H1D9mEntHbd+BmqDPl0pAfK2uL+9rjAEA7oiSi9gRsESiHsRo/tRfECTkHCHit1exPqf3tdB4NiEhrF6N86Cc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1587997433; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=oldCmFh36fkF/tgrkUaIhxwAa5DiddLZtLibNeskKo4=; 
        b=iD+Kut979oHf94pxAy9zUhFYZ6Hs1GOsoo2T13ODU558TFOfV/etS+DDbr63XIiLJ+2LbW4h+vMoyoTae03H2sliEsHn56b9HvU+JMhSg+n0ERl7i/VVeBo0WBUvAOp0xg2JWqaxwRUiHK0FPR6CIwEefj5mIutfNhv77eCcobw=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        dkim=pass  header.i=trained-monkey.org;
        spf=pass  smtp.mailfrom=jes@trained-monkey.org;
        dmarc=pass header.from=<jes@trained-monkey.org> header.from=<jes@trained-monkey.org>
Received: from [100.109.71.206] (163.114.130.1 [163.114.130.1]) by mx.zoho.eu
        with SMTPS id 1587997431858298.3853893146098; Mon, 27 Apr 2020 16:23:51 +0200 (CEST)
Subject: Re: [PATCH] udev: Ignore change event for imsm
To:     Mariusz Tkaczyk <mariusz.tkaczyk@intel.com>
Cc:     linux-raid@vger.kernel.org
References: <20200408144452.19275-1-mariusz.tkaczyk@intel.com>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <4d9e6fc9-2099-edf7-8982-f4cc4a1068a1@trained-monkey.org>
Date:   Mon, 27 Apr 2020 10:23:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200408144452.19275-1-mariusz.tkaczyk@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 4/8/20 10:44 AM, Mariusz Tkaczyk wrote:
> When adding a device to a container mdadm has to close its file
> descriptor before sysfs_add_disk(). This generates change event.
> There is race possibility because metadata is already written and other
> -I process can place drive differently. As a result device can be added
> to two containers simultaneously.
> From IMSM perspective there is no need to react for change event. IMSM
> doesn't support stacked devices.
> 
> Signed-off-by: Mariusz Tkaczyk <mariusz.tkaczyk@intel.com>
> ---
>  udev-md-raid-assembly.rules | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied!

Thanks,
Jes


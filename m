Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE37A15C2D5
	for <lists+linux-raid@lfdr.de>; Thu, 13 Feb 2020 16:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbgBMPg5 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 13 Feb 2020 10:36:57 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49384 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727725AbgBMPgz (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Thu, 13 Feb 2020 10:36:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581608215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IwQHI79iQNnLF0R813K4ZfyJ/4oVZzBfHd4LqqijBNs=;
        b=QJ5KUCHpoHxzmHxMnCNPYpFg6CmWfK8bDzEQWHDGEjfFj6zn4iNSfRaHQrsaK3O5ia9ivp
        GuMvw39wG0VqVrX6tEKwoiGsKOiinX8bLmMDMWwYWdhZWsPFT0u9Ev0ZVfUBUsFPRrwipq
        vfXAsJCFyliiu/v6OsXEusODedkdhUY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-2EOjsAokOgC2pnOKYZU8tQ-1; Thu, 13 Feb 2020 10:36:51 -0500
X-MC-Unique: 2EOjsAokOgC2pnOKYZU8tQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D3280100550E;
        Thu, 13 Feb 2020 15:36:49 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A17CD5DA85;
        Thu, 13 Feb 2020 15:36:46 +0000 (UTC)
Date:   Thu, 13 Feb 2020 10:36:45 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
Cc:     Zhou Wang <wangzhou1@hisilicon.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Alasdair Kergon <agk@redhat.com>, dm-devel@redhat.com,
        Song Liu <song@kernel.org>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-erofs@lists.ozlabs.org
Subject: Re: Remove WQ_CPU_INTENSIVE flag from unbound wq's
Message-ID: <20200213153645.GA11313@redhat.com>
References: <20200213141823.2174236-1-mplaneta@os.inf.tu-dresden.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213141823.2174236-1-mplaneta@os.inf.tu-dresden.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Thu, Feb 13 2020 at  9:18am -0500,
Maksym Planeta <mplaneta@os.inf.tu-dresden.de> wrote:

> The documentation [1] says that WQ_CPU_INTENSIVE is "meaningless" for
> unbound wq. I remove this flag from places where unbound queue is
> allocated. This is supposed to improve code readability.
> 
> 1. https://www.kernel.org/doc/html/latest/core-api/workqueue.html#flags
> 
> Signed-off-by: Maksym Planeta <mplaneta@os.inf.tu-dresden.de>

What the Documentation says aside, have you cross referenced with the
code?  And/or have you done benchmarks to verify no changes?

Thanks,
Mike


Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A022CD6CB2
	for <lists+linux-raid@lfdr.de>; Tue, 15 Oct 2019 03:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbfJOBBF (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 14 Oct 2019 21:01:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39472 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727104AbfJOBBF (ORCPT <rfc822;linux-raid@vger.kernel.org>);
        Mon, 14 Oct 2019 21:01:05 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1213318C426F;
        Tue, 15 Oct 2019 01:01:05 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0016860BE2;
        Tue, 15 Oct 2019 01:01:04 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id D415B4A460;
        Tue, 15 Oct 2019 01:01:04 +0000 (UTC)
Date:   Mon, 14 Oct 2019 21:01:04 -0400 (EDT)
From:   Xiao Ni <xni@redhat.com>
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     David Jeffery <djeffery@redhat.com>,
        linux-raid <linux-raid@vger.kernel.org>,
        Nigel Croxon <ncroxon@redhat.com>,
        Heinz Mauelshagen <heinzm@redhat.com>,
        NeilBrown <neilb@suse.de>, Song Liu <songliubraving@fb.com>
Message-ID: <1192855783.6467006.1571101264721.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAPhsuW4wuYyeZ2QLVnYqXKgCvMbOowbzHedj2gXVw2H_pmO4zA@mail.gmail.com>
References: <1568627145-14210-1-git-send-email-xni@redhat.com> <20190916171514.GA1970@redhat> <e80828b0-c115-7f50-b3da-241d7c8871c0@redhat.com> <c1779eb9-932c-aad1-3b31-d988af33ac4a@redhat.com> <CAPhsuW4wuYyeZ2QLVnYqXKgCvMbOowbzHedj2gXVw2H_pmO4zA@mail.gmail.com>
Subject: Re: [PATCH 1/1] Call md_handle_request directly in md_flush_request
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.68.5.41, 10.4.195.30]
Thread-Topic: Call md_handle_request directly in md_flush_request
Thread-Index: aYUpZrTBuSxsqmSElZjMX+rTr5rjHA==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.62]); Tue, 15 Oct 2019 01:01:05 +0000 (UTC)
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org



----- Original Message -----
> From: "Song Liu" <liu.song.a23@gmail.com>
> To: "Xiao Ni" <xni@redhat.com>
> Cc: "David Jeffery" <djeffery@redhat.com>, "linux-raid" <linux-raid@vger.kernel.org>, "Nigel Croxon"
> <ncroxon@redhat.com>, "Heinz Mauelshagen" <heinzm@redhat.com>, "NeilBrown" <neilb@suse.de>, "Song Liu"
> <songliubraving@fb.com>
> Sent: Tuesday, October 15, 2019 1:03:57 AM
> Subject: Re: [PATCH 1/1] Call md_handle_request directly in md_flush_request
> 
> On Mon, Oct 14, 2019 at 1:48 AM Xiao Ni <xni@redhat.com> wrote:
> >
> > Hi Song
> >
> > Could you merge this one?
> 
> I updated the commit log as:
> 
> ===================== 8< ======================
> md: improve handling of bio with REQ_PREFLUSH in md_flush_request()
> 
> If pers->make_request fails in md_flush_request(), the bio is lost. To
> fix this, pass back a bool to indicate if the original make_request call
> should continue to handle the I/O and instead of assuming the flush logic
> will push it to completion.
> 
> Convert md_flush_request to return a bool and no longer calls the raid
> driver's make_request function.  If the return is true, then the md flush
> logic has or will complete the bio and the md make_request call is done.
> If false, then the md make_request function needs to keep processing like
> it is a normal bio. Let the original call to md_handle_request handle any
> need to retry sending the bio to the raid driver's make_request function
> should it be needed.
> 
> Also mark md_flush_request and the make_request function pointer as
> __must_check to issue warnings should these critical return values be
> ignored.
> 
> Fixes: 2bc13b83e629 ("md: batch flush requests.")
> Cc: stable@vger.kernel.org # # v4.19+
> Signed-off-by: David Jeffery <djeffery@redhat.com>
> Reviewed-by: Xiao Ni <xni@redhat.com>
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ===================== 8< ======================
> 
> Please let me know if anything is not accurate.
> 
> Thanks,
> Song
> 

Hi Song

The comments are OK for me. Thanks for the adjustment.

Regards
Xiao

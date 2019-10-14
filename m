Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 098FAD67EB
	for <lists+linux-raid@lfdr.de>; Mon, 14 Oct 2019 19:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387794AbfJNREJ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 14 Oct 2019 13:04:09 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45222 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbfJNREJ (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 14 Oct 2019 13:04:09 -0400
Received: by mail-qt1-f196.google.com with SMTP id c21so26331416qtj.12
        for <linux-raid@vger.kernel.org>; Mon, 14 Oct 2019 10:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E70ytEtupbNkMQbx6jM1cTGjWy1pJi3Kmy5s9NuzLPs=;
        b=iEzRMZqQDn+FVAbmTgQqAjVk96xXBIVYAdO8Xt34m2WnrKAjYPBGtmMDv84FnpnLrT
         Xeivdn2k1QJ3BRb/tZkVFTra0TMug/NBc2zmNr494ngJ0c6UOV88quKTjrPQ+Z1YEtVz
         AqXRnHs4qWYQLC6MX99Qevgx+Z+9SNhGdn5yLArDQtCpiTH1kSdokrcBBOns2OGyOHqt
         9oM6nzsRbjv0ie2zCKkfGkxFqsuAVOxLywhUdz+T23ec1Ft2PYtOIEv+trWrLBrPk0+P
         Trm2KHm1a+HQ+gj/QRlOuniao+44Ft60DWrevuBB7ca6IexZFTrkWZUJCKk/yCNIWdsz
         ws/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E70ytEtupbNkMQbx6jM1cTGjWy1pJi3Kmy5s9NuzLPs=;
        b=OvBBW6rkL/YLxJmQMM6ozqckjzUl2d5hM+9N0e9ox3uGjRScz47a6TuzEMVQss9erV
         3DDBGR+h6zPpeo9o+dCJk0dmqUxoxVTjwxnuNGGokLUJLMidsPOhT1w8widjLKLgq+da
         IqLhwpIbuaef6jHSDcgiaiw7abvL5CSUw0VI5zL0+/6CHNWKR5UzfL7NcrKi0t210aLe
         tIMawi/8nv3lhrb3O9vcy2lVw31J8JhfbE4V90TLlZc9pR41lpkcDJQGJlrp8sqe1Tsl
         Iy6FE+53bf/chjce7tQ18fQdvWtpJdmPcXpKe7VBLmEVBCbBhN1o9swbLoQHCfy5wqz9
         Sjng==
X-Gm-Message-State: APjAAAXBMKa0jt7tO5qfJiHWYmV2qA7A16K8dsrwQqAwAIxFxBmdS2Me
        lzAC+eOTYj2prTJGwnw+ySR9neoyxNTAjvu+dbs=
X-Google-Smtp-Source: APXvYqwlqw8T+MDhnaXKDuY8PQDm3XRlOL1DsgWjHNXRlGn1S3zBaEusipmFQNVeIBzFxdm1ey1SQXJlFtyvCxchlzs=
X-Received: by 2002:ac8:34cb:: with SMTP id x11mr33263038qtb.183.1571072648359;
 Mon, 14 Oct 2019 10:04:08 -0700 (PDT)
MIME-Version: 1.0
References: <1568627145-14210-1-git-send-email-xni@redhat.com>
 <20190916171514.GA1970@redhat> <e80828b0-c115-7f50-b3da-241d7c8871c0@redhat.com>
 <c1779eb9-932c-aad1-3b31-d988af33ac4a@redhat.com>
In-Reply-To: <c1779eb9-932c-aad1-3b31-d988af33ac4a@redhat.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Mon, 14 Oct 2019 10:03:57 -0700
Message-ID: <CAPhsuW4wuYyeZ2QLVnYqXKgCvMbOowbzHedj2gXVw2H_pmO4zA@mail.gmail.com>
Subject: Re: [PATCH 1/1] Call md_handle_request directly in md_flush_request
To:     Xiao Ni <xni@redhat.com>
Cc:     David Jeffery <djeffery@redhat.com>,
        linux-raid <linux-raid@vger.kernel.org>,
        Nigel Croxon <ncroxon@redhat.com>,
        Heinz Mauelshagen <heinzm@redhat.com>,
        NeilBrown <neilb@suse.de>, Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Mon, Oct 14, 2019 at 1:48 AM Xiao Ni <xni@redhat.com> wrote:
>
> Hi Song
>
> Could you merge this one?

I updated the commit log as:

===================== 8< ======================
md: improve handling of bio with REQ_PREFLUSH in md_flush_request()

If pers->make_request fails in md_flush_request(), the bio is lost. To
fix this, pass back a bool to indicate if the original make_request call
should continue to handle the I/O and instead of assuming the flush logic
will push it to completion.

Convert md_flush_request to return a bool and no longer calls the raid
driver's make_request function.  If the return is true, then the md flush
logic has or will complete the bio and the md make_request call is done.
If false, then the md make_request function needs to keep processing like
it is a normal bio. Let the original call to md_handle_request handle any
need to retry sending the bio to the raid driver's make_request function
should it be needed.

Also mark md_flush_request and the make_request function pointer as
__must_check to issue warnings should these critical return values be
ignored.

Fixes: 2bc13b83e629 ("md: batch flush requests.")
Cc: stable@vger.kernel.org # # v4.19+
Signed-off-by: David Jeffery <djeffery@redhat.com>
Reviewed-by: Xiao Ni <xni@redhat.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
===================== 8< ======================

Please let me know if anything is not accurate.

Thanks,
Song

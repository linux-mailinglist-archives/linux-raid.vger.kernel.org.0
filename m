Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2217180C32
	for <lists+linux-raid@lfdr.de>; Wed, 11 Mar 2020 00:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbgCJXTB (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 10 Mar 2020 19:19:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45448 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726411AbgCJXTB (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 10 Mar 2020 19:19:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583882340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z5sLqw2q00TFWFE2+/xEamSW6/qGE1IWWYINTtiDzeQ=;
        b=Rj9QDPftG/jz8cX7UbkFeEOEWSvdFLVrqeckBoauoZfVexbVFpwONB822wfPDG9ULf7hJN
        jz45ilvD3F674oUyLCiS9cfdeQPCTegMs3S//3j5dM7qlLiR5PQSu+gdFA9Pzk6cfi+zO0
        w1/lK0m8RPrjDsrNqO/ApJd46OoxXYI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-gy1-6Q3MN9KfKTWUkq74rw-1; Tue, 10 Mar 2020 19:18:58 -0400
X-MC-Unique: gy1-6Q3MN9KfKTWUkq74rw-1
Received: by mail-ed1-f71.google.com with SMTP id y4so204737edm.0
        for <linux-raid@vger.kernel.org>; Tue, 10 Mar 2020 16:18:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z5sLqw2q00TFWFE2+/xEamSW6/qGE1IWWYINTtiDzeQ=;
        b=MdxH2yKq4eIx58lwQxPm5SOAUAEs0PlkjIaUFRiSMXU9ORIClcL6ODHXXur618yJna
         gv4xC8FzOnc0U8fXofgb4sr/0Zor4EctxFolEJYgIauISo8T5NsSIk4GAkmRdtXc7V7Q
         3Y1UxT8e4rFhVeqZ3OCCNjnculC5gxJVAL8LmngYKZadPmPW/DyEzjD48N2jRu87hmfb
         J15QaBv4Nt+qhS0OlRmzQ5Eltjg3Me5c0OvpBAIKZPP3/rVYES7tpDfD4GHErPc8r6Kk
         d8jpubfygDeryrd3qIIy8YY96vpoWgH1FbMdg5beF67x0qcqX1SWPlWZ2b/hyCbXZS+1
         PqKA==
X-Gm-Message-State: ANhLgQ2wUcFMCDPrNgzzwMgKYoagOyj5fMiw17lDrY3VWlu2y2RpzoDI
        wqJxrkXCe6gVZpNrm2W+azCJqkm1UJYjNWkd0d55Qae4BOI0CWktp7D/W3jpRcc9W0lhLZW2C8n
        1OCdP0cpfOItGRjw4DlzeKPtIBtDnBx9BKGcuRQ==
X-Received: by 2002:a17:907:262a:: with SMTP id aq10mr12415671ejc.377.1583882337423;
        Tue, 10 Mar 2020 16:18:57 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vstjHqiZOF0xElis+31S7G0gY2aH73JLw/AluJvKeWmdJcJyHfoWoeERc+w0Ht0pyWZgseKXsqtbLAkFkQLxyM=
X-Received: by 2002:a17:907:262a:: with SMTP id aq10mr12415648ejc.377.1583882337100;
 Tue, 10 Mar 2020 16:18:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200310223516.102758-1-mcroce@redhat.com> <d473061b-688f-f4a6-c0e8-61c22b8a2b10@cloud.ionos.com>
In-Reply-To: <d473061b-688f-f4a6-c0e8-61c22b8a2b10@cloud.ionos.com>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Wed, 11 Mar 2020 00:18:21 +0100
Message-ID: <CAGnkfhwjXN_T09MsD1e6P95gUqxCbWL7BcOLSy16_QOZsZKbgQ@mail.gmail.com>
Subject: Re: [PATCH v2] block: refactor duplicated macros
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     linux-block@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-bcache@vger.kernel.org,
        linux-raid <linux-raid@vger.kernel.org>,
        linux-mmc@vger.kernel.org,
        xen-devel <xen-devel@lists.xenproject.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-nfs@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Wed, Mar 11, 2020 at 12:10 AM Guoqing Jiang
<guoqing.jiang@cloud.ionos.com> wrote:
>
>
>
> On 3/10/20 11:35 PM, Matteo Croce wrote:
> > +++ b/drivers/md/raid1.c
> > @@ -2129,7 +2129,7 @@ static void process_checks(struct r1bio *r1_bio)
> >       int vcnt;
> >
> >       /* Fix variable parts of all bios */
> > -     vcnt = (r1_bio->sectors + PAGE_SIZE / 512 - 1) >> (PAGE_SHIFT - 9);
> > +     vcnt = (r1_bio->sectors + PAGE_SECTORS - 1) >> (PAGE_SHIFT - 9);
>
> Maybe replace "PAGE_SHIFT - 9" with "PAGE_SECTORS_SHIFT" too.
>
> Thanks,
> Guoqing
>

Wow, there are a lot of them!

$ git grep -c 'PAGE_SHIFT - 9'
arch/ia64/include/asm/pgtable.h:2
block/blk-settings.c:2
block/partition-generic.c:1
drivers/md/dm-table.c:1
drivers/md/raid1.c:1
drivers/md/raid10.c:1
drivers/md/raid5-cache.c:5
drivers/md/raid5.h:1
drivers/nvme/host/fc.c:1
drivers/nvme/target/loop.c:1
fs/erofs/internal.h:1
fs/ext2/dir.c:1
fs/libfs.c:1
fs/nilfs2/dir.c:1
mm/page_io.c:2
mm/swapfile.c:6

-- 
Matteo Croce
per aspera ad upstream


Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD32770BEA
	for <lists+linux-raid@lfdr.de>; Mon, 22 Jul 2019 23:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730274AbfGVVqQ (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 22 Jul 2019 17:46:16 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37424 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729624AbfGVVqQ (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 22 Jul 2019 17:46:16 -0400
Received: by mail-qk1-f195.google.com with SMTP id d15so29609336qkl.4;
        Mon, 22 Jul 2019 14:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y5NLHCvyvtEY+fLnxFgCWbb8gW3X9ssvxOBTPCkuHdE=;
        b=puFbiiJsm0MXZ/zSTAfUMYUKLi0H4vYdLibW/lNqNMWvk5i0vKklONa3o9HBA/LehJ
         0UU7NycEmierrY6s/YH5Tfq0C7THnC9ezLo/Z3lIoMXQAOQ41CudOUpDdQL52h63mafJ
         4yl5B0IayHkKVns2oA8xDwV+F4+xx7lqnjl4TkYmX5yYip3wAw85Gm02smxbjJDJaSUi
         1Rb8LrNPsdmBI+Qy79d/odFUhXJ8YDpk5nrD0iv7RAIgRtioRu4gWBeUYKZ8k9tuJLtK
         nukNZO8kNx5KcjlZZbYF6VmQmKNLdwWPlMRi4qaoYJCqv3K8CwzFajlq9KrgPagPcLcX
         AD6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y5NLHCvyvtEY+fLnxFgCWbb8gW3X9ssvxOBTPCkuHdE=;
        b=pU87ERFNEnymn3YfWyBoDMELh2up0SoivTDFC628uYwlLtlot75LwzKMnJ+JRsDcCq
         i0KDDRR2+rHJRCatf2HXuwMv8osvQ4+bEfUyE4T+Xu1nZuQAdNOoGWhiqLlNJmyjyCJw
         +VVlZpDPLRnuhc3MQC/hamUesHUcGSlKj8fLD22wp/zzcdYCBk5tAVom8DgUXoQlH+kq
         hV8TXM0MDl5TrFV49LVONdEMGo5pay6boKf90F24pU6zdIEXxi2B4IT1QsWvwqOZypJG
         UZi0Izbmzau260TbMB2p/vyCPK6T0VJHXYVKSVxktblFdNliHNZfs9uwRZsN2h3/9QIE
         PGVA==
X-Gm-Message-State: APjAAAXmDrarcIVocCfploqB2xOXLRooedEMoMWuU211spQgVBhRWL8n
        s8/gnDvIGXQhKpO6YK+XO9xYm7R44QXKYmnrF9c=
X-Google-Smtp-Source: APXvYqxsj0FW8dlomAaE61phQvZRgy/maiojZrYq6ePiB945N0OFcnrUMP60+OMGhUvQybteQdDSIv5a9BR6pXkGrlc=
X-Received: by 2002:a37:4d82:: with SMTP id a124mr46381963qkb.72.1563831975659;
 Mon, 22 Jul 2019 14:46:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190702143548.133020-1-houtao1@huawei.com>
In-Reply-To: <20190702143548.133020-1-houtao1@huawei.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Mon, 22 Jul 2019 14:46:04 -0700
Message-ID: <CAPhsuW5S0h66GxHeypS=3aGO=FAJ_J7TxoUatffXhOSiBzWCXg@mail.gmail.com>
Subject: Re: [PATCH] raid1: use an int as the return value of raise_barrier()
To:     Hou Tao <houtao1@huawei.com>
Cc:     linux-raid <linux-raid@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On Tue, Jul 2, 2019 at 7:30 AM Hou Tao <houtao1@huawei.com> wrote:
>
> Using a sector_t as the return value is misleading, because
> raise_barrier() only return 0 or -EINTR.
>
> Also add comments for the return values of raise_barrier().
>
> Signed-off-by: Hou Tao <houtao1@huawei.com>

Applied. Thanks for the patch.

Song

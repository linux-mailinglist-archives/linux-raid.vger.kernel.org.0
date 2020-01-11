Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A70C31383B7
	for <lists+linux-raid@lfdr.de>; Sat, 11 Jan 2020 22:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731468AbgAKVgd (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sat, 11 Jan 2020 16:36:33 -0500
Received: from mail-io1-f46.google.com ([209.85.166.46]:44456 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731456AbgAKVgd (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sat, 11 Jan 2020 16:36:33 -0500
Received: by mail-io1-f46.google.com with SMTP id b10so5733866iof.11
        for <linux-raid@vger.kernel.org>; Sat, 11 Jan 2020 13:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XFLroTjrSTukpq+NG7+TDwD3CwUvIRdiUIoMHq5ChIo=;
        b=CqVf2+Mlay10KkNhkPWrUlgKVQAcTlAcAhDZj/NGg49DfM5hBLvNygGiAeViDoHljU
         gs/hZJoMS6cW36bDI6pLWBYbjE8B1eDWeTAj1LpF/nJGqZQSnL3dwS1lFLlCDl3Fhq8N
         +2l9XeGctTro2+rxxrTJlz/BsO3mvV/Vx4dWSvYKR+2IRID5uJDAl7XqyT1myGSa9fYG
         iSm+VlfmxO0FtGXZHzzqN46Oj1XjkxsccfHocVKeGCPWO3EF1f+ftMyL8WHt4Oh6+d0J
         UiMAP2vCwrlxwV1u6eSvnyYEFsEadPYHACkmGYZrOii5QUrHwwNl87qc2gwP7atFFyC2
         eCZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XFLroTjrSTukpq+NG7+TDwD3CwUvIRdiUIoMHq5ChIo=;
        b=EbAHd2sVrrGftUPowNQS7IVfZJ2RZtmUrPvp/fI0s8/18mGhS4ES81u9JozI4T0/F6
         GvwpZFWcrt3m0e3yWYQW3PGD/P5Ecy7EPLoDD2gNIR0uuK+2ZJy97dLkuDjLfGq7jWXZ
         2es94IMJa80wuGsDn3jU/nshhCNbXEHURiHVDl1DI7u3pydxbvQLV25Ac8dtydavZu5R
         yvfng0Av1ozyWsuUrHi4/vpGs91LlbP0BoEVNtLJg+phCduwi8Y7xc2BGscrrgSdrzLh
         RhOX4S197zrC0xcJ8Z+omq9YcjL3SOdDk0+vwPdf7/Q0jsjxue9/xJdzmvw99nPZfqWP
         t4xg==
X-Gm-Message-State: APjAAAUkJ7n3naezrH8wLLbSw4CFi+esnW0sq2jegqMhfOx3Iypk1zpR
        30h0syDUrQb9gfZrfqFl6aINkqnpiBTBoJCQKpRtqEag
X-Google-Smtp-Source: APXvYqyFDHYEw1npgoqG5Ka8WPG3BX8q7HzVfl7j2b72bZ2E6VxaQP41OzJFRy0lMxEmDO0/XwImHrQWeeKt4+2+yNI=
X-Received: by 2002:a05:6638:24f:: with SMTP id w15mr8966957jaq.130.1578778592887;
 Sat, 11 Jan 2020 13:36:32 -0800 (PST)
MIME-Version: 1.0
References: <CAJH6TXhWd-AGi0_KnbnepxZXsOvpMQGwkisFuuX14dMe157jWw@mail.gmail.com>
 <82a7d9ec-f991-ad25-bf1f-eee74be90b1b@youngman.org.uk> <CAJH6TXji3e1Tp8xDDiqfqy36fpMC4kZTLaYj0Le9A6Cyg8EnGg@mail.gmail.com>
 <5E1A3D4F.30205@youngman.org.uk>
In-Reply-To: <5E1A3D4F.30205@youngman.org.uk>
From:   Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Date:   Sat, 11 Jan 2020 22:36:21 +0100
Message-ID: <CAJH6TXjQ+vLSOJGH_7-mAeRREBSSTS5DTxXFtz2SU06wfhc4gA@mail.gmail.com>
Subject: Re: RAID10, 3 copies, 3 disks
To:     Wols Lists <antlists@youngman.org.uk>
Cc:     Linux RAID Mailing List <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Il giorno sab 11 gen 2020 alle ore 22:25 Wols Lists
<antlists@youngman.org.uk> ha scritto:
> Multiple 3-way mirrors (1+0) requires disks in multiples of 3. Raid10
> simply requires "4 or more" disks. If you expect/want to expand your
> storage in small increments, then 10 is clearly better. BUT.

I'll start with 8TB usable (more than enough for me atm) and would be ok
for at least 1 year, thus saving space is not a problem. Next year, if needed,
i'll add 3 disks more (or i'll grow the existing ones)

> Depending on your filesystem - for example XFS - changing the disk
> layout underneath it can severely impact performance - when the
> filesystem is created it queries the layout and optimises for it. When I
> discussed it with one of the XFS guys he said "use 1+0 and add a fresh
> *set* of disks (or completely recreate the filesystem), because XFS
> optimises layout based on what disks it thinks its got."

No XFS, i'll use ext4.
I had *TONS* of issues with XFS

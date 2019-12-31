Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80BE612DA9C
	for <lists+linux-raid@lfdr.de>; Tue, 31 Dec 2019 18:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfLaR0v (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 31 Dec 2019 12:26:51 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41053 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbfLaR0v (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 31 Dec 2019 12:26:51 -0500
Received: by mail-ed1-f68.google.com with SMTP id c26so35687045eds.8
        for <linux-raid@vger.kernel.org>; Tue, 31 Dec 2019 09:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6/+GNKWsu3eUYu0Oa2U3/ghLesjvw+INDlX1NMqP8fY=;
        b=tP5ve/4OIdqZe1xYGg8/f+93lWNfIye7H0ihDZ9AaDcTUpH4f7YuVmMlrQW0BPAnhg
         pPmhi6lH92LFAIzgXO1aJpfRW58jYLYSOPnPmFU+iyVyi74G0bhGu+FFlzciB11kOMTn
         D4PUTp6UUlNm334LJHSWHy60tnwmpKyw12WPhYJINjEllfMm2M/s06glaLKmI4OVRqjp
         0N9Rcd+SxZkA3PFrF5WRqhUcz1hJWw4hrhUzM3+oXs3koH03rGnZr7eH03E+/M61eia+
         DVk+KFVmPGMBcOhhQyYaJGpyNbsztTfvkql32s+kBi2k+zE2J7FuonMR85E+Cvds8I0g
         Kk+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6/+GNKWsu3eUYu0Oa2U3/ghLesjvw+INDlX1NMqP8fY=;
        b=VIEkHyY3JcAA0L5e370Oz5RPLO052ANbVIUWsvScx5JY+i0CQd8tS77N9UyyjQf0C0
         5+aKFo3VmprE3oK4P+1VEpRX5oYj4Y72AvrjRUvMsFw5ca6yJWfZZiOT6zfu0kYfS63x
         iKmLYHo7oIKm4n2DGgGXt+xQvAW9sPO9n3zaClrRUe6k//hIzOPSOxYbC80orLfK5m85
         En+zFHZBiOu++eVJkaxckFlIfJkF8JCOkWPrJPyuhlzCNr92w7DCV/m0KiwtC0sau7mU
         9qaI1S7XU+164QWNByIMnqxhPM3M+/7+Y8cz3HgFqAH9TQKx8f0lCO1hUfhlC5DLV8HA
         TEoQ==
X-Gm-Message-State: APjAAAWXHwgCQjJcw2MUqlOmx0BNRY1RLbNn8gm2Kqa7Z++tw3bZHz+5
        ZYQRsryMOf/4jgsZrx1WmBlLXsunLJ6rjnPgwf4=
X-Google-Smtp-Source: APXvYqwhO3JN3s/YyNfC/fJJBEj8hpRaqhBwT7xh/LhB881qZqB3suUuo2ql3H9RaSKvhp+wKoSFnocDLtKzKxeSEjk=
X-Received: by 2002:a05:6402:799:: with SMTP id d25mr78143557edy.221.1577813209497;
 Tue, 31 Dec 2019 09:26:49 -0800 (PST)
MIME-Version: 1.0
References: <CAGRSmLsh0aqJMuFzMMhm6fYjsCL-MNXR=t04cGj9FNvG0EENTQ@mail.gmail.com>
 <CAB-xnyD+iWsbuemirPyHqEG9DnbBb1unjj6D-21ZmBbjp9eAmA@mail.gmail.com>
In-Reply-To: <CAB-xnyD+iWsbuemirPyHqEG9DnbBb1unjj6D-21ZmBbjp9eAmA@mail.gmail.com>
From:   "David F." <df7729@gmail.com>
Date:   Tue, 31 Dec 2019 09:26:38 -0800
Message-ID: <CAGRSmLs1nVWHVEv5FXzDCbsC7otzsVr_HceXXruKDO228zM5Eg@mail.gmail.com>
Subject: Re: Why isn't the "Support Intel AHCI remapped NVMe devices" in mainline?
To:     Andrew R <junkbustr@gmail.com>
Cc:     "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Was actually referring to the "Intel AHCI remapped NVMe devices Patch"
that exists but now out of date because of updates to NVMe/PCI driver.
The latest was based on 5.2 I believe.

On Sun, Dec 15, 2019 at 7:57 AM Andrew R <junkbustr@gmail.com> wrote:
>
>
> On Fri, Dec 13, 2019, 20:15 David F. <df7729@gmail.com> wrote:
>>
>> Hi,
>>
>> Despite not liking what Intel did, there isn't any reason Linux
>> shouldn't support these devices in RAID mode..   The main support
>> issues with our Linux based product is now this problem with no hard
>> drives listed in Linux.   Get a couple everyday.  Some people can't
>> change to AHCI mode, such as some Lenovo machines.
>>
>> If the patch simply adds support for this mode without affecting
>> anything when not in that mode then why wouldn't you mainline it?
>> This problem is widespread.
>>
>> TIA
>
>
> Not sure if this is your issue, but had a similar issue with an HP machin=
e that I bought with mirrored 512gb NVME drives configured from the factory=
. They were configured with the Intel Rapidstore embedded raid on the mothe=
rboard. In this configuration, the drives are not detected by the kernel.
>
> I had to go into the RAID configuration menu in the bios and release the =
drives from the raid (deleting Windows) at which point Linux could see the =
drives.
>
> In my particular case I was not installing Linux on this machine but was =
using Linux to create image backups of the Windows install using imaging to=
ols from the Clonezilla distro.
>
> After destroying the RAID, I used the HP system recovery to create a base=
 install and then setup drive mirroring in Windows Disk Manager (*not* Stor=
age Spaces!). NB this requires Windows Professional...
>
> HTH.

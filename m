Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2F671A4470
	for <lists+linux-raid@lfdr.de>; Fri, 10 Apr 2020 11:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgDJJ3c (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 10 Apr 2020 05:29:32 -0400
Received: from mail-40130.protonmail.ch ([185.70.40.130]:44999 "EHLO
        mail-40130.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgDJJ3c (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 10 Apr 2020 05:29:32 -0400
Date:   Fri, 10 Apr 2020 09:29:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1586510969;
        bh=XdiJ9EfJn4K1J6Xu9tA//UIucFWJH97rirJKgwRL06U=;
        h=Date:To:From:Reply-To:Subject:From;
        b=sOB3mfIhCdVeQUXn2tf5/TPM3KjKqe9gzrtZFkykNZkRBVxcOI8T6+DXjMv5kyfQM
         08GmYa3VhFuDRu0i8zmnhiYMMBNbZa7IlU651Qose061McU+z7ikInZJFI9XhzjhYa
         HH/M8NYpkGnifo8XhXHEWyLP5fSQpOidSR8349GM=
To:     "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>
From:   Fisher <fisherthepooh@protonmail.com>
Reply-To: Fisher <fisherthepooh@protonmail.com>
Subject: Is it possible to create a single zone RAID0 with different size member disks?
Message-ID: <5ng5lZpZoJjtdf9Xkshn3CSzsLIErcNWAzPPARDbDdzNY9Kr-tgMjy6djUaqRVo9r9KmB2HMV0ZQuurdV7wNDYGOP4azAiw1jPkcoF10-SM=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=7.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on mail.protonmail.ch
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi,

I got four disks with different size each,

first I created a raid0 and I found that nr_strip_zones larger than 1,

but I think I would convert it to raid4/5/6 someday in the future,

so I need nr_strip_zones to be 1,

then I tried to add --size to specify the used size of each disk when creat=
ing the raid0,

but the raid0 to raid4 conversion failed because nr_strip_zones still large=
r than 1,

Is there any way I can create a single zone raid0 with different size membe=
r disks?

Thanks,


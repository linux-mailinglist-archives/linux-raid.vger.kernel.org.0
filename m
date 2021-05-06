Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16B97374EC8
	for <lists+linux-raid@lfdr.de>; Thu,  6 May 2021 07:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbhEFFLI (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 6 May 2021 01:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbhEFFLD (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 6 May 2021 01:11:03 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A0EC061574
        for <linux-raid@vger.kernel.org>; Wed,  5 May 2021 22:10:04 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id l4so6300444ejc.10
        for <linux-raid@vger.kernel.org>; Wed, 05 May 2021 22:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=pzZ21OxY6xe+jvOiybiw8nb50XRY8hLZ0laWT+x69+o=;
        b=Yr4LtwYtQLpePrDfWRp7Byrvv5xXIGFjrcjmEX5/i/C1lmfhWC1q9rTsiXjsqGyt3Q
         mHLIxASjiAjPWlRcLYsEjaIODWIRnRnS4f+hXUQnlMBLK5s44DR1s+Qh/t/3XGePN6Fh
         Z1XQQaWq726L77Kf+eguEK0B3XH3sAJc2/4KUjru9AijXSkAKhhcP6AamnlpuPH2mZpG
         0sDOp+z4TmpEfX+8cvgpoGUx7j1mf1XfZqKhSQaN8r3P4o7YuTylViU8TKlzb+GYyZQs
         jh3fTfjUkxhFGrCfkuJG3Me7adzf7Fi11dGpQmtqc8j71E+8cIY9Y3uHy5n+2jNCgNcV
         u8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=pzZ21OxY6xe+jvOiybiw8nb50XRY8hLZ0laWT+x69+o=;
        b=BjFRzYdxyyE5BTdayKxM7lNBIYGQ+LKRsuHGZ7Ayhm6NpMqd+ZGMTE0Qx2MHSoOG36
         ct/CRYQJ2yWCbse2N13ZbGl2fxL/mR5Pm8xEKzY1kRUE3cibM4i7sitiv/CbXdQaYiGw
         Vquth2kjHp50woDSDW5U/lFRfRym3CfqsjPlutmVFJwJj29A+383cBb5IrAwt961jLQf
         OFNXuzlDub+WwAz6w3UueT2JcBHxaTSHX2/UMIZ4kPDvpGvaVIpk7IbWuDHXZ3pF9wrN
         qqwlkJLIMVkonhxawHiaq3dO2N0Yqm3eiYpsrnJu8YA/SreaFp59qcCQu0gLz4QolSpW
         gazg==
X-Gm-Message-State: AOAM532kg6iOKOQBmF9StFMNOF6Y8+YySwAglsEaBbDPwPOI7CtmA4We
        2ku5fNGjVXuv5eCdcJR3F1pdTAYhZVbKELoWQPS99UpWArjRbg==
X-Google-Smtp-Source: ABdhPJxhKkTK5kL5cfo/MU7ULgDYg2o/vzlybiLbA/J7KlgADG85aKWHH8M1uLgtQbBKCZAJj7nRevKuMsffzR9tozQ=
X-Received: by 2002:a17:906:8a51:: with SMTP id gx17mr2319649ejc.549.1620277803103;
 Wed, 05 May 2021 22:10:03 -0700 (PDT)
MIME-Version: 1.0
From:   d tbsky <tbskyd@gmail.com>
Date:   Thu, 6 May 2021 13:09:53 +0800
Message-ID: <CAC6SzHJLG=0_URJUsgQshpk-QLh6b8SBJDrfxiNg4wikQw4uyw@mail.gmail.com>
Subject: raid10 redundancy
To:     list Linux RAID <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi:
   I am curious about raid10 redundancy when created with disk numbers below:

2 disks => 1 disk tolerance
3 disks = > 1 disk  tolerance
4 disks =>  possible 2 disks?  or still only 1 disk ?

how about 5/6 disks with raid10?
thanks a lot for confirmation!!

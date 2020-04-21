Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E64151B2D4D
	for <lists+linux-raid@lfdr.de>; Tue, 21 Apr 2020 18:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbgDUQzR (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 21 Apr 2020 12:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726946AbgDUQzP (ORCPT
        <rfc822;linux-raid@vger.kernel.org>);
        Tue, 21 Apr 2020 12:55:15 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F88AC061A41
        for <linux-raid@vger.kernel.org>; Tue, 21 Apr 2020 09:55:15 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id 71so12120353qtc.12
        for <linux-raid@vger.kernel.org>; Tue, 21 Apr 2020 09:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hr5+ySHYvi2+kC2SXT5W7FdxSFTRDlzEhZn2uumOats=;
        b=dGgbjUpelmcwsvKBYzZD5JlAjEtptLwOGQ4Dv+KpaYV6rd87NIH5z306s8x9PY3SLZ
         4xo7te8PWPjN3aCSrQTiqDdL2ez0l+JNPva2IehUmrF/yeWiFKX9P8DJzjt3kb9dWJ/l
         Ry2IwrZMluusMCoFXjBkp8U6TdZZ268w+c14Xe1pHys6SJFTcbmaQeb+R2CSn9vtlKGu
         AQJUfNOY65i29Yq/dP/XYsOKjsZFlPyhuraEYSs2nIdaoY3vXYkxFmHMQWyk2+0aX6OW
         H6p8lkxkt82m2DB6fZXgAAuUp/neCQyy0O2V5H0atxwktxKDDQXnFTQeGWJ+4nQpN4KT
         vnYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hr5+ySHYvi2+kC2SXT5W7FdxSFTRDlzEhZn2uumOats=;
        b=XC5kvnCqD1IW3Ied+4hYt1i4xuRjxoNdThKkb+8YdCOkH8v0W0mHTgHNlk2HNNUYtm
         30Uwt+arWddC/iOzweCeJ6VpNPbrwIFjhIzkqmB7mbVg/V+Fzp0Ph3oNqNkuQQNo8OSQ
         4TW6ygtSXxIdUwbdRr6laeM3VZq7EvfgdlNQGqeT6LflZdSWYzW+evC8Vo5nejx0FYzK
         liobyu6SYtCGGofF8wZVgXipmNm0TzRi1gbs3P7AFGNLSlZ0TprPs4YttivIOyMkUIhP
         FUKgwpi6RBV72ammyYYQd+p+jsmko+SOb7f2kpTkX4ahFQm9CdP6fNaRuPbFHgWshjIv
         o0rQ==
X-Gm-Message-State: AGi0PuZKeva/S9LaLPuKN3cVwAgBqaRIa4nif2kwjS2MRW+tKDZiSwF1
        /1fk2MGzTDb91hin7CZ6H52cRB0Aariey4HeQfE=
X-Google-Smtp-Source: APiQypLojelhJ30D67yHO5qvd/m6TlWcxRaEb+YrtOYRX+4ArOE90xCM11SgCERN4LgVSqykN+7cjeG/zi+aCl1UceA=
X-Received: by 2002:ac8:4e81:: with SMTP id 1mr21828370qtp.58.1587488114772;
 Tue, 21 Apr 2020 09:55:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAM++EjGaFBh8ZChnyY0p=du0CKFT1WVikSNYyUUcJhuKwQf4sQ@mail.gmail.com>
 <CAAMCDeegCE4x26L4OYttiABxvxiu4qYykAo-b-53G-qW8Ua1Hw@mail.gmail.com>
In-Reply-To: <CAAMCDeegCE4x26L4OYttiABxvxiu4qYykAo-b-53G-qW8Ua1Hw@mail.gmail.com>
From:   Leland Ball <lelandmball@gmail.com>
Date:   Tue, 21 Apr 2020 12:55:00 -0400
Message-ID: <CAM++EjHie1FFZ7y-VveWBSQs2TW=PkD+-QXKxK_pAON-GrcRcQ@mail.gmail.com>
Subject: Re: Recovering From RAID5 Failure
To:     Roger Heflin <rogerheflin@gmail.com>
Cc:     Linux RAID <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Thanks Roger, I appreciate your help and quick reply!

Two of the disks (sda, sdb) were able to return
    # smartctl --all /dev/sdX
just fine, but sdc and sdd returned very little, so I dug a bit deeper with
    # smartctl -d ata -T permissive --all /dev/sdX

The results are in the pastebin: https://pastebin.com/yWJTPvBa
It looks like only sdd has an error count. I would love to get this up
long enough to recover at least a portion of the data, which isn't
backed up elsewhere.

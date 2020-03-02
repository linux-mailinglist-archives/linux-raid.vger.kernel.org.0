Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74ACD175445
	for <lists+linux-raid@lfdr.de>; Mon,  2 Mar 2020 08:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgCBHIa (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 2 Mar 2020 02:08:30 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36647 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgCBHIa (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 2 Mar 2020 02:08:30 -0500
Received: by mail-wm1-f65.google.com with SMTP id g83so7361896wme.1
        for <linux-raid@vger.kernel.org>; Sun, 01 Mar 2020 23:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W6CTebr41RQX4wbK78D0PgiU+uqk+TPUh7Q/g4HtEb8=;
        b=OyXEbKKFvQe1y05wDMWwjHSk17LUwYcs/ycOgaYg4MIK+mzlIdwnCrbi8Ps8dpqfhh
         BLj9bfIbL3sH/wNNkJkmG3QjWs6ojB9ygysgZXvbIZUWsTKQzkStqgNQI8ghvlYzqaQl
         bVDMXo9GPbUGwPKDbG0B5fKEJXiY7HQ0TMF7ENdO5XT4ZVCtSij9VG804uOa/Mv4w1Rj
         qqNd/UqDXQRM9RuHvgxb2BMN3IzGdwJiQsRdiHs1NhZ/3XjkNzEC38/Xy2lsbJW4NzY8
         QkKAuc4Af61UZw1OnQZQYXVMe4yl9kV6sAiFVPoTQ0GVuYW8XeVH4OlEcDRWxA5le4Ai
         /ZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W6CTebr41RQX4wbK78D0PgiU+uqk+TPUh7Q/g4HtEb8=;
        b=iHnzk/L0RKUW3m+zPU1irnp4mhqtHJzDpzrxH2/UiteYvPptXjAFCOj16LAPJPXVtY
         LO/OoCQzdteosoeNYNTeilQAXLEYqnYvcou6Sao8jKBhmTmNbHxo4WXNcLQ4tTB6eBHU
         WzMgaIzOSQEMT4s0fRo40ScNSbBtnpsS4ICS8RLLKIIN3XUUmCT6lsWc4SOQXCaOJe/o
         Qkvlhk+s8IuRNosIAi/fG8GNnZdLG2gSZGVO8AqjK8GpOrkm1iYFGWjnTTxvcTjczJ1Z
         kJvEXT7u+UBOi2xTqGPDl0L81BXUC68sieyNKizrVaUhyVO13W3ozlo6jPnCEUh8tQxw
         jv2Q==
X-Gm-Message-State: APjAAAXfAVCHGDkUoaqwzKzD0BEy21HCn5OADn9mKVWS9yJpWKcdEUiK
        cIapoU0h1e0mAmZCwW4dCtliuqm2c+B4zC0c/acfkzH2Tvk=
X-Google-Smtp-Source: APXvYqxTL+JvyWMSdAvw1FyQNGMVIPcmk6qFU4i1R1JvhQ3+iaUCKZuhP+RIPktQiVdo+mdVbwxYZVQE4kYP8F70Tc4=
X-Received: by 2002:a05:600c:214a:: with SMTP id v10mr18692698wml.182.1583132907159;
 Sun, 01 Mar 2020 23:08:27 -0800 (PST)
MIME-Version: 1.0
References: <e46b2ae7-3b88-05f2-58d7-94ee3df449e4@suddenlinkmail.com>
 <20200302102542.309e2d19@natsu> <920df583-1d9e-6037-1d61-cbd5e1133d4d@suddenlinkmail.com>
 <20200302115141.1e796b7c@natsu> <c5d8e6d2-a572-5602-6562-795ea52168ac@suddenlinkmail.com>
In-Reply-To: <c5d8e6d2-a572-5602-6562-795ea52168ac@suddenlinkmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 2 Mar 2020 00:08:11 -0700
Message-ID: <CAJCQCtTOJrvm7BnyqSSuCUa82ehZbtHgSGaQo1bzcepgdtazSw@mail.gmail.com>
Subject: Re: Linux 5.5 Breaks Raid1 on Device instead of Partition, Unusable I/O
To:     "David C. Rankin" <drankinatty@suddenlinkmail.com>
Cc:     mdraid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

smart also reports for /de/sdc

  40 53 00 ff ff ff 0f  Error: UNC at LBA = 0x0fffffff = 268435455


So I'm suspicious of timeout mismatch as well.
https://raid.wiki.kernel.org/index.php/Timeout_Mismatch


Chris Murphy

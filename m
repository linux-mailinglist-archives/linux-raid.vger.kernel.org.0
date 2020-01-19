Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC20141F24
	for <lists+linux-raid@lfdr.de>; Sun, 19 Jan 2020 18:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgASRHl (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 19 Jan 2020 12:07:41 -0500
Received: from mail-ua1-f46.google.com ([209.85.222.46]:45668 "EHLO
        mail-ua1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbgASRHl (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 19 Jan 2020 12:07:41 -0500
Received: by mail-ua1-f46.google.com with SMTP id 59so10658710uap.12
        for <linux-raid@vger.kernel.org>; Sun, 19 Jan 2020 09:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1vnAFlDnXX6CJDgAfMD5y4cwKRjsK6sWKHfPWzUOcrg=;
        b=ZavBbOjCxrrBmXK7czDbMCSV572jtjqn6HkDatyV+6I05R+gpDgkT1BjJAfVhkXzD9
         YE4zf2Q1iwjj/s9vUXjvtSXivUc3JAIZ5cBRp5XXGbkD1WybXRuZVKxyTtxbCfTDBq0b
         YJSM8dFEp/lc7UIAAf3lJiRRRgZCNBXXxnCzDtSu10oJv5cwT/V8KeuQZoGuzkCLdq04
         S4O0QY49fJyiyvETMJcxQ8QdAeNBX6lhADaMrVbOulbba8I0Hn1uI4Y8JXJRLuymnkyU
         UWed8UR7Y9l5JiC9tmveoLW9EPWzM/Y5/v+SVdSI1/uyICBRJIIVxZNsbKTh/K3tUNDk
         sCCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1vnAFlDnXX6CJDgAfMD5y4cwKRjsK6sWKHfPWzUOcrg=;
        b=I+KePJQo8HQ052g3F4+Wi0xd5AaVfPNEfVjZYG3zqEMBu4W0lsuJCnW7tlBfnrT2W6
         3km0JVSKkCETyEXuU6RYBQTkkzdptKl3xQ1LMkeEIPYh/Mk7Xh2zMGnA+Q9+WgX9f8Ef
         bhaTM6qsanZ5iScBItu+Jhn6QQYSxu1l7pOp4wIB7lIHRNPe/P1Ce5Gt+ezxyCuPKrsm
         u35CeHToYkDkwSGwv2vtEDIVldopSuxUSWACPRcuO70C4e6355K+QY9an/Ts4g1FczJ/
         CGoYs3Wh4jpWLM4gqa5JT+Tu+MsQn0s9vkEWErhxTfp0ACBchPgkGxBHSDqobHm89p5T
         kpEQ==
X-Gm-Message-State: APjAAAUsxH4rpWd9xTMRtvC4Z3M1jwyJe8o6whgITk4wabHaZIoGTuO6
        l/LqRq2nQAGv2mpMCOPewhKnqX+lQ8NmfPb8s1I=
X-Google-Smtp-Source: APXvYqwoOwHpyswmvtSElWNzzEMw92KJO2qgNBwAIT1SqDY0Jad2ElHiOclTBaz2S4UdUBAIq57k2Mn253G6ckdQwio=
X-Received: by 2002:a9f:226d:: with SMTP id 100mr26767305uad.107.1579453660527;
 Sun, 19 Jan 2020 09:07:40 -0800 (PST)
MIME-Version: 1.0
References: <CALc6PW4OKR2KVFgzoEbRJ0TRwvqi5EZAdC__HOx+vJKMT0TXYQ@mail.gmail.com>
 <959ca414-0c97-2e8d-7715-a7cb75790fcd@youngman.org.uk> <CALc6PW7276uYYWpL7j2xsFJRy3ayZeeSJ9kNCGHvB6Ndb6m1-Q@mail.gmail.com>
 <5E17D999.5010309@youngman.org.uk> <CALc6PW5DrTkVR7rLngDcJ5i8kTpqfT1-K+ki-WjnXAYP5TXXZg@mail.gmail.com>
 <CALc6PW7hwT9VDNyA8wfMzjMoUFmrFV5z=Ve+qvR-P7CPstegvw@mail.gmail.com>
 <5E1DDCFC.1080105@youngman.org.uk> <CALc6PW5Y-SvUZ5HOWZLk2YcggepUwK0N===G=42uMR88pDfAVA@mail.gmail.com>
 <5E1FA3E6.2070303@youngman.org.uk> <CALc6PW4-yMdprmube0bKku0FJVKghYt4tjhep26sy3F9Q5cB4g@mail.gmail.com>
In-Reply-To: <CALc6PW4-yMdprmube0bKku0FJVKghYt4tjhep26sy3F9Q5cB4g@mail.gmail.com>
From:   William Morgan <therealbrewer@gmail.com>
Date:   Sun, 19 Jan 2020 11:07:29 -0600
Message-ID: <CALc6PW5gQDNvL4qP_QEiGkuXYR5Zp3j9_-CuBdWdyKwc-fCA9Q@mail.gmail.com>
Subject: Re: Two raid5 arrays are inactive and have changed UUIDs
To:     Wols Lists <antlists@youngman.org.uk>
Cc:     linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Here is a better formatted output from lsblk:

bill@bill-desk:~$ sudo lsblk -fi
NAME    FSTYPE            LABEL       UUID
    FSAVAIL FSUSE% MOUNTPOINT
.
.
.
sdj
`-sdj1  linux_raid_member bill-desk:0
06ad8de5-3a7a-15ad-8811-6f44fcdee150
  `-md0 ext4
ceef50e9-afdd-4903-899d-1ad05a0780e0
sdk
`-sdk1  linux_raid_member bill-desk:0
06ad8de5-3a7a-15ad-8811-6f44fcdee150
  `-md0 ext4
ceef50e9-afdd-4903-899d-1ad05a0780e0
sdl
`-sdl1  linux_raid_member bill-desk:0
06ad8de5-3a7a-15ad-8811-6f44fcdee150
  `-md0 ext4
ceef50e9-afdd-4903-899d-1ad05a0780e0
sdm
`-sdm1  linux_raid_member bill-desk:0
06ad8de5-3a7a-15ad-8811-6f44fcdee150
  `-md0 ext4                          ceef50e9-afdd-4903-899d-1ad05a0780e0

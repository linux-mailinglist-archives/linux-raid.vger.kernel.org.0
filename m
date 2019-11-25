Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AED1109588
	for <lists+linux-raid@lfdr.de>; Mon, 25 Nov 2019 23:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726033AbfKYWhC (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 25 Nov 2019 17:37:02 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:45510 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfKYWhC (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 25 Nov 2019 17:37:02 -0500
Received: by mail-il1-f197.google.com with SMTP id h69so7296484ild.12
        for <linux-raid@vger.kernel.org>; Mon, 25 Nov 2019 14:37:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=KF2WjshW1BDTUg/k+IPUzgQidO5NFBNVVgPRIj2C55w=;
        b=Lpj51afg3ztAJLLKAckunbHG1S/YQEe0gPhsCtJrp07s1TY0gjd3+f2aucJXpC6mfM
         yKWDYyR6QchwL49StvrQct0I+NVIgGFAUV4+C8jcFgRg2yOSuLNLgHqOLS+YTmoCrt6g
         zlisv7XH3SmYJs3zAxazpSkpcX8aHzgM8DKInTqxpA6SfdzCtT5MDTAO/CF8HKOS/vAx
         fYL4a5L4s6Al4kLYczXKJmy5QfLJnvdU7TUq0U8txy+LP6roSPrmZIxdN26d9TcIRjBn
         1qg0wRfyEnBMSVtJF+O1X/nCmP58D6QOwt39CSlCDXJc8LD8X/vIZFo/7KFFlW4qUiBw
         dL1A==
X-Gm-Message-State: APjAAAV00zjQ5eTFK/B+tqNEeXjeBGyyoFVTiqvm6clybiIW3osENdvV
        ha7Zw+q8yrKBTAOdeGeMPhrqk0pXH9HBPyHtWKqV6rOCzwe2
X-Google-Smtp-Source: APXvYqwkBCex2KWBU45kzK7k9hy1eCU109ihsuTepJ0sQfsiJS80DmXhz/QeEsCiIwZ7ccJ1gnEjc/wJIBydu3gOime4bUB5ZGcg
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2181:: with SMTP id b1mr29243849iob.208.1574721421577;
 Mon, 25 Nov 2019 14:37:01 -0800 (PST)
Date:   Mon, 25 Nov 2019 14:37:01 -0800
In-Reply-To: <000000000000a52337056b065fb3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f4160705983366e8@google.com>
Subject: Re: WARNING in md_ioctl
From:   syzbot <syzbot+1e46a0864c1a6e9bd3d8@syzkaller.appspotmail.com>
To:     airlied@linux.ie, chris@chris-wilson.co.uk,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        rafael.antognolli@intel.com, rodrigo.vivi@intel.com,
        shli@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

syzbot has bisected this bug to:

commit 4b6ce6810a5dc0af387a238e8c852e0d3822381f
Author: Rafael Antognolli <rafael.antognolli@intel.com>
Date:   Mon Feb 5 23:33:30 2018 +0000

     drm/i915/cnl: WaPipeControlBefore3DStateSamplePattern

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13aeb522e00000
start commit:   c61a56ab Merge branch 'x86-urgent-for-linus' of git://git...
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=106eb522e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=17aeb522e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4013180e7c7a9ff9
dashboard link: https://syzkaller.appspot.com/bug?extid=1e46a0864c1a6e9bd3d8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16bca207800000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14819a47800000

Reported-by: syzbot+1e46a0864c1a6e9bd3d8@syzkaller.appspotmail.com
Fixes: 4b6ce6810a5d ("drm/i915/cnl:  
WaPipeControlBefore3DStateSamplePattern")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

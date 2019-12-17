Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B06A1224E1
	for <lists+linux-raid@lfdr.de>; Tue, 17 Dec 2019 07:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfLQGm1 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 17 Dec 2019 01:42:27 -0500
Received: from mail-yb1-f177.google.com ([209.85.219.177]:41142 "EHLO
        mail-yb1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfLQGm0 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 17 Dec 2019 01:42:26 -0500
Received: by mail-yb1-f177.google.com with SMTP id b145so4031162yba.8
        for <linux-raid@vger.kernel.org>; Mon, 16 Dec 2019 22:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=tA+094vopSc7n/MDrk2Jp92LnkLUBaSeF8YSMWG1ahw=;
        b=lVqZZSbmWWnuyzpvE31KpCYCI/f5LJE4KcCKhdq+nLC5YfayggL5F+01UYZqStlU4s
         GLjSIpWHxrY0JmB0nkt/8LzRzXT1hehtNHLFqYxu2NyYniX7T6mCe4g8iUnDmvCv66+h
         V4dmNHTtvm9VtwrldYfKKWaH6jyFXyCQSFHpxCPpGvQ2Am4WARIVCZsl4wGLrGPydWo6
         EHbDdxkrcmDBNAVgI5GmyZr8tj09DojTnAzOH1zF3ceIlfjOIpIDocooVSO5tuVRmnmG
         WrgW8uRC/3vEsxiammIIMQh3GOcfoDpklnXDV8FW4vN8dnCvKgGkgG+EijGzW1pwSU4X
         z4vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=tA+094vopSc7n/MDrk2Jp92LnkLUBaSeF8YSMWG1ahw=;
        b=EImn7SiaZRkjXOXCIHRv2kpEbwM8PAUcTSM3mYn4lvuWP4EfTq8gZ4X+EGUZ5FfOKO
         PeYNqyOlwROM7vVFQ4U/iVFWaOQ37BiE8LjsdW0urK+//FSlUd85Yr/3LY1QSJEoUlzl
         +3kZJQJjTmg/d73gPt4r4Y9+LZqSTjVrOLOimtAU4sXcExk1Af7w3/6PLhL1KU0hFGp5
         /0yoeyQuj7cjmqOxsLzXQY3c1dPopXQG+m3k50k0d+8KuNUW4tgK81YCXh1YgwGPWrpY
         /LF8SiRt0CtoBiK10T3YdjSCfdLndKheKwbNBLy357lrVSga/li2qwHxlre3wVGwe+qv
         Ym2Q==
X-Gm-Message-State: APjAAAVCHtnQN2P3EO8yjXskG6F1/xQX3S6kJfOCC5QuQO3TPuMkcDBW
        V9paTCxBv6qnDE3HU/6A9yN3EMAA2E8=
X-Google-Smtp-Source: APXvYqwN6xFAJQ7QxcriBYqvP3xsxJcC8qWF9be38e6Cb9bdGOv005cYT4Dq7u0FiDNdkAQUD0FKfg==
X-Received: by 2002:a25:5804:: with SMTP id m4mr24196137ybb.128.1576564945694;
        Mon, 16 Dec 2019 22:42:25 -0800 (PST)
Received: from [192.168.125.2] (quantum.benjammin.net. [173.161.90.37])
        by smtp.gmail.com with ESMTPSA id o4sm9553100ywd.5.2019.12.16.22.42.25
        for <linux-raid@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Dec 2019 22:42:25 -0800 (PST)
To:     Linux-RAID <linux-raid@vger.kernel.org>
From:   Benjammin2068 <benjammin2068@gmail.com>
Subject: Keeping existing RAID6's safe during upgrade from CentOS 6 to CentOS
 8
Message-ID: <e7e9ed61-c611-3b40-2c78-6c5c47f77148@gmail.com>
Date:   Tue, 17 Dec 2019 00:42:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hey everyone,

I have a quick and (hopefully) easy question...


At some point, I'm going to update my CentOS 6.10 system to CentOS 8.x

My biggest concern is dealing with the mdadm based RAID6 that holds my important data.

SO.... What's the safest thing I could do to protect it when I do the upgrade (which is essentially a fresh install of v8)

I'm assuming I should:

* copy /etc/mdadm.conf someplace
* copy /etc/fstab someplace (for reference more than anything)
* PULL THE DRIVES FROM THE SYSTEM.

* Once the new OS is installed, plug the drives back in.
* Patch mdadm.conf and fstab as needed ..... and.....

Anything else?

Thanks a bunch,

  -Ben


Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B899B1B4513
	for <lists+linux-raid@lfdr.de>; Wed, 22 Apr 2020 14:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbgDVM0x convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-raid@lfdr.de>); Wed, 22 Apr 2020 08:26:53 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:47074 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgDVM0x (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Wed, 22 Apr 2020 08:26:53 -0400
Received: by mail-ed1-f44.google.com with SMTP id l3so1301044edq.13
        for <linux-raid@vger.kernel.org>; Wed, 22 Apr 2020 05:26:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fjEIKNLsGsF7ncJrSZ3ONSfzUiWW/hUlANwmulDJyqc=;
        b=uFW8wspEjjoL/XPvPt3CG0IUaRb8Ny+PbVj0hzK+5O8ITA1yETrZIVv5YRuB9qMWLz
         SYyjPukj83T83RHwPZ5R1IWBtwCpB6GnbqBZ9/kZ+jrzWLka2R9XWZDqUEDmDurxxQ6J
         l0wVbKPNPIoi1nF+4gxHImSsB+G4OeLX1Bw8To5+FEyJZI3LXvkYDjougKxHRSB1TiW4
         PJAf368CYZJr1eRY3iX1WbRBZmJcg6rO7NcGf39VWgJ9lQwQFde6mzAw26YtJ19IlmNo
         /jc2TnvdxVVRQWQa8+FSYiqPPQTz0gLEAAKbrDInNxQ2vdMWgC5+tMttqhSiu41+AZIy
         TGbQ==
X-Gm-Message-State: AGi0PuYCSnAFSZHpQLZnPgaMStyOAE3syiWdCzUufBbU+N8rQCH+Spgy
        OzyK5rK7EGA0hSW/USG/iESi3sa02smJMlDo9aE=
X-Google-Smtp-Source: APiQypKfzqQHVxllDdZJT3rvf00/gpii1PBneg9i2jD4piT1L/JjiMxZkdUz2p8/THhI5AsP/6U0Iccco6KjuKt4dSc=
X-Received: by 2002:aa7:c3c2:: with SMTP id l2mr23268699edr.362.1587558410289;
 Wed, 22 Apr 2020 05:26:50 -0700 (PDT)
MIME-Version: 1.0
References: <6a7c0aba219642de8b3f1cc680d53d85@AM0P193MB0754.EURP193.PROD.OUTLOOK.COM>
In-Reply-To: <6a7c0aba219642de8b3f1cc680d53d85@AM0P193MB0754.EURP193.PROD.OUTLOOK.COM>
From:   Xiaosong Ma <xma@qf.org.qa>
Date:   Wed, 22 Apr 2020 15:26:39 +0300
Message-ID: <CAKm37QWKVcPkF0fXKk2499CsYXfU3aMuMWgwa8Nk9HFzVxG7CA@mail.gmail.com>
Subject: Fwd: Fw: some questions about uploading a Linux kernel driver
To:     song@kernel.org, linux-raid@vger.kernel.org
Cc:     ty-jiang18@mails.tsinghua.edu.cn,
        Guangyan Zhang <gyzh@tsinghua.edu.cn>,
        wei-jy19@mails.tsinghua.edu.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Dear Song,

This is Xiaosong Ma from Qatar Computing Research Institute. I am
writing to follow up with the questions posed by a co-author from
Tsinghua U, regarding upstreaming our alternative md implementation
that is designed to significantly reduce SSD RAID latency (both median
and tail) for large SSD pools (such as 20-disk or more).

We read the Linux kernel upstreaming instructions, and believe that
our implementation has excellent separability from the current code
base (as a plug-and-play module with identical interfaces as md).
Meanwhile, we wonder whether there are standard test cases or
preferred applications that we should test our system with, before
doing code cleaning up. Your guidance is much appreciated.

Best regards,
Xiaosong

Dr. Xiaosong Ma
Principal Scientist
Distributed Systems

Qatar Computing Research Institute
Hamad Bin Khalifa University
HBKU – Research Complex
P.O. Box 5825
Doha, Qatar
Tel: +974 4454 6190
www.qcri.qa
<http://www.qcri.qa>



---------- Forwarded message ---------
From: 姜天洋 <ty-jiang18@mails.tsinghua.edu.cn>
Date: Tue, Apr 14, 2020 at 2:10 PM
Subject: Fw: some questions about uploading a Linux kernel driver
To: Dr. Xiaosong Ma <xma@hbku.edu.qa>, gyzh@tsinghua.edu.cn
<gyzh@tsinghua.edu.cn>, wei-jy19@mails.tsinghua.edu.cn
<wei-jy19@mails.tsinghua.edu.cn>





-----原始邮件-----
发件人:"姜天洋" <ty-jiang18@mails.tsinghua.edu.cn>
发送时间:2020-04-08 20:34:44 (星期三)
收件人: song@kernel.org
抄送: linux-raid@vger.kernel.org
主题: some questions about uploading a Linux kernel driver

Hello
I am Tianyang JIANG, a PhD student from Tsinghua U. We finish a study
which focuses on achieving consistent low latency for SSD arrays,
especially timing tail latency in RAID level. We implement a Linux
kernel driver called FusionRAID and we are interested in uploading
codes to Linux upstream.
I notice that I should seperate my changes and style-check my codes
before submitting. Are there any other issues I need to be aware of?
Thank you for your time.

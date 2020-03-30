Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DED41985DC
	for <lists+linux-raid@lfdr.de>; Mon, 30 Mar 2020 22:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbgC3Uy3 (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 30 Mar 2020 16:54:29 -0400
Received: from mail-vk1-f169.google.com ([209.85.221.169]:37784 "EHLO
        mail-vk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727750AbgC3Uy3 (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 30 Mar 2020 16:54:29 -0400
Received: by mail-vk1-f169.google.com with SMTP id o124so5113253vkc.4
        for <linux-raid@vger.kernel.org>; Mon, 30 Mar 2020 13:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=rBZFH4VZFrWVwNdhqz3MMMFIThATExq0s8TIa7cQFPw=;
        b=GknKT0OYDx7DTErMWhG0K9yQskzauesNk4mZbwSXBwKMeT4I/BdcsZLrbm1P0ULfZn
         4SuYQAFF+E5vwIJ/rnrwcWimSeqi2AdjfYAmPb/cq0FltymXlEHXCxiNbPu/CE3t9i7i
         Jv40wQDMKYPfX9NstwvNVLiG++IvRRmRIyO5xV2wcq+YIs8Y0ywcHNLaV/90cwWlVApF
         BA1mmPc9zwU3apCSuKbqJ/JWvAzyhwVEh3vz2DE4Fp7WRxozR8bYead9vZ4IiCqvYDSi
         omZbPlNN8Zia+y2lV8nYsdKpzHvcatqWYEUM2+u1Pzdl27OD5+1GLfSoZ6qG8yvq9S5t
         78FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=rBZFH4VZFrWVwNdhqz3MMMFIThATExq0s8TIa7cQFPw=;
        b=VlxrmtTcaOg5CB9j2KOJkqI+WwCSmZHhDvOFMvNcg5vF0bPTxjtyqTmlIgPhrbE4TS
         psDZyQT8+cl6KzK3DGvdi8TaYssXS55sv7Jb9VxZeQmdmmlumOejO87p+HnxqNfeTKh6
         THH7ZgGbe7LQL3aqsMBvyNC+tvlXNQ4tRLn5iNHazUKHQlg3OL9U+Z03nQBmmn2B2yvH
         Mj4Zox34wuPVMJl+/iScYmOuEuPy57PKTLFD5R4Bf4Ux5XRgUgt5bh+brJd1aP56Yt2s
         cmQct2p6kYu4MASl3qR5qUhoXIS/XFQr+8qkQ7ixsDpDb0ZeiexLFFPUaDKr8nOIp/RI
         WwZA==
X-Gm-Message-State: AGi0PubhVTMKexBXgEUkDPMCCKgXFQGODG3lWogEFJiV22YMJPa2aSA2
        beu2+lPV4RsieHYZ9pkUE6QJjaAz0bN3SvnVwoTAa6Mm
X-Google-Smtp-Source: APiQypLU40h0lSmdAsj7zVXhyrVNqqNqA9jQW5VV+eqpvu+Owi0vuJzCl/zP8azo7aNptb3pJDdFUnpJniaKaNEHiXU=
X-Received: by 2002:a1f:eb04:: with SMTP id j4mr9608834vkh.16.1585601668085;
 Mon, 30 Mar 2020 13:54:28 -0700 (PDT)
MIME-Version: 1.0
From:   Marc Smith <msmith626@gmail.com>
Date:   Mon, 30 Mar 2020 16:54:16 -0400
Message-ID: <CAH6h+heYBA5RvBH7GPJ6JkPUYvjxT2A4f_gBVs=Pr-ps6rPRQw@mail.gmail.com>
Subject: MD Array 'stat' File - Sectors Read
To:     linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi,

Apologies in advance, as I'm sure this question has been asked many
times and there is a standard answer, but I can't seem to find it on
forums or this mailing list.

I've always observed this behavior using 'iostat', when looking at
READ throughput numbers, the value is about 4 times more than the real
throughput number. Knowing this, I typically look at the member
devices to determine what throughput is actually being achieved (or
from the application driving the I/O).

Looking at the sectors read field in the 'stat' file for an MD array
block device:
# cat /sys/block/md127/stat && sleep 1 && cat /sys/block/md127/stat
93591416        0 55082801792        0       93        0        0
  0        0        0        0        0        0        0        0
93608938        0 55092996456        0       93        0        0
  0        0        0        0        0        0        0        0

55092996456 - 55082801792 = 10194664
10194664 * 512 = 5219667968
5219667968 / 1024 / 1024 = 4977

This device definitely isn't doing 4,977 MiB/s. So now my curiosity is
getting to me: Is this just known/expected behavior for the MD array
block devices? The numbers for WRITE sectors is always accurate as far
as I can tell. Or something configured strangely on my systems?

I'm using vanilla Linux 5.4.12.


Thanks,

Marc
